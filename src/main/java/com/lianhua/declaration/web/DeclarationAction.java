package com.lianhua.declaration.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lianhua.W4Application;
import com.lianhua.area.service.AreaService;
import com.lianhua.code.service.CodeService;
import com.lianhua.common.util.ImportResult;
import com.lianhua.common.web.BaseAction;
import com.lianhua.common.web.WebHolder;
import com.lianhua.company.model.Company;
import com.lianhua.company.service.CompanyService;
import com.lianhua.declaration.model.Declaration;
import com.lianhua.declaration.service.ApprovalService;
import com.lianhua.declaration.service.DeclarationService;
import com.lianhua.document.model.Document;
import com.lianhua.document.model.DocumentDescriptor;
import com.lianhua.document.service.DocumentDescriptorService;
import com.lianhua.document.service.DocumentService;
import com.lianhua.user.model.User;
import com.rootrip.platform.Platform;
import com.rootrip.platform.common.web.page.PageEngineFactory;
import com.rootrip.platform.exception.AppException;
import com.rootrip.platform.exception.BusinessException;
import com.rootrip.platform.util.Servlets;
import com.rootrip.platform.util.ValidateUtil;

@Controller
public class DeclarationAction extends BaseAction {

	@Autowired
	private CompanyService companyService;

	@Autowired
	private DeclarationService declarationService;

	@Autowired
	private ApprovalService approvalService;

	@Autowired
	private DocumentDescriptorService documentDescriptorService;

	@Autowired
	private DocumentService documentService;

	@Autowired
	private CodeService codeService;
	
	@Autowired
	private AreaService areaService;

	W4Application app = (W4Application)Platform.getInstance().getApp();
	
	private LinkedList<String> exportTaskIds = new LinkedList<>();

	@RequestMapping(value="/declaration/update_company", method=RequestMethod.GET)
	public String updateMyCompany(ModelMap model) {
		User user = WebHolder.getUser();
		Company company = companyService.getByUserAndYear(user.getId(), app.getCurrentDeclarationYear());
		model.addAttribute("company", company);
		model.addAttribute("categoryJson", codeService.getCategoryInJson());
		if(company != null) {
			model.addAttribute("currentCategory", codeService.showCategory(company.getCategoryCode()));
		}

		return "/declaration/update_company";
	}

	@RequestMapping(value="/declaration/update_company", method=RequestMethod.POST)
	public String saveMyCompany(HttpServletRequest request, @ModelAttribute("company") Company company,
			ModelMap model, RedirectAttributes redirectAttributes) {
		
		if(companyService.isCodeExist(company.getCode(), company.getId(), app.getCurrentDeclarationYear())) {
			addErrorMsg(model, "您填写的组织机构代码与系统中已有记录重复，请检查是否填写正确");
			return COMMON_ERROR_PAGE;
		}
		
		try {
			companyService.saveMyCompany(company, company.getContact());
		} catch (AppException e) {
			addErrorMsg(model, e.getMessage());
			return COMMON_ERROR_PAGE;
		}

		redirectAttributes.addAttribute("message", "companySave");
		return "redirect:/declaration/approval_list.action";
	}

	@RequestMapping(value="/declaration/approval_list")
	public String listApproval(ModelMap model) {
		User user = WebHolder.getUser();
		Declaration declaration = declarationService.getByUserAndYear(user.getId(), app.getCurrentDeclarationYear());
		model.addAttribute("approvals", approvalService.findByDeclaration(declaration));
		return "/declaration/approval_list";
	}

	@RequestMapping(value="/declaration/fill")
	public String fillDeclaration(ModelMap model, @RequestParam(value="targetDocumentId", required=false)Long targetDocumentId) {
		User user = WebHolder.getUser();
		Company company = companyService.getByUserAndYear(user.getId(), app.getCurrentDeclarationYear());
		if(company == null || company.getCategoryCode() == null || company.getAccountingCode() == null) {
			String s = "<script type='text/javascript'>alert('填写直报数据前请先确认企业资料。'); " +
					"window.location.href='%s/declaration/update_company.action'</script>";

			addErrorMsg(model, String.format(s, Platform.getInstance().getContextPath()));
			return COMMON_ERROR_PAGE;
		}
		Long declarationId = null;
		try {
			declarationId = declarationService.prepareDeclaration(company, app.getCurrentDeclarationYear());
		} catch (AppException e) {
			addErrorMsg(model, e.getMessage());
			return COMMON_ERROR_PAGE;
		}
		Declaration declaration = declarationService.get(declarationId);
		model.addAttribute("declaration", declaration);
		List<Document> documents = documentService.findByDeclaration(declarationId);
		List<DocumentDescriptor> descriptors = new ArrayList<>(documents.size());
		Document currentDoc = null;
		boolean first = true;
		Long nextDocDescriptorId = null;
		for(Document d : documents) {
			if(currentDoc == null) {
				if(targetDocumentId != null) {
					//跳转到指定表格
					if(d.getDescriptorId().equals(targetDocumentId)) {
						currentDoc = d;
					}
				} else if(first) {
					//默认先填报第一个表格
					currentDoc = d;
					first = false;
				}
			} else if(nextDocDescriptorId == null) {
				//下一张表格
				nextDocDescriptorId = d.getDescriptorId();
			}
			descriptors.add(d.getDescriptor());
		}
		model.addAttribute("document", currentDoc);
		model.addAttribute("descriptors", descriptors);
		model.addAttribute("company", company);
		model.addAttribute("nextDocDescriptorId", nextDocDescriptorId);
		return "/declaration/fill";
	}

	@RequestMapping("/declaration/save")
	public String saveDeclaration(HttpServletRequest request, @ModelAttribute("document") Document document, ModelMap model,
			@RequestParam(value="action")String action,  @RequestParam(value="targetDocumentId", required=false)Long targetDocumentId,
			RedirectAttributes redirectAttributes) {

		Map<String, String[]> propertyMap = Servlets.getParametersStartingWith(request, "prop_");

		try {
			declarationService.saveDocument(document, propertyMap, action);
		} catch (AppException e) {
			addErrorMsg(model, e.getMessage());
			return COMMON_ERROR_PAGE;
		}

		//跳转到指定表格则不显示成功信息
		if(targetDocumentId == null) {
			redirectAttributes.addAttribute("message", action);
		}
		//保存和暂存成功还是进入刚才的表格,如果指定了跳转到某个表格则跳转过去.提交成功进入审批记录页面
		if("tempSave".equalsIgnoreCase(action) || "save".equalsIgnoreCase(action)) {
			if(targetDocumentId != null) {
				redirectAttributes.addAttribute("targetDocumentId", targetDocumentId);
			} else {
				redirectAttributes.addAttribute("targetDocumentId", document.getDescriptorId());
			}
			return "redirect:/declaration/fill.action";
		}

		return "redirect:/declaration/approval_list.action";
	}

	@RequestMapping("/ajax/declaration/check_document_saved")
	@ResponseBody
	public String checkDocumentSaved(HttpServletRequest request, @RequestParam("id")Long declarationId,
			@RequestParam("documentId")Long documentId, ModelMap model) {

		List<Document> documents = documentService.findByDeclaration(declarationId);
		for(Iterator<Document> iter = documents.iterator(); iter.hasNext();) {
			Document d = iter.next();
			//114表不需要保存就能提交
			if(d.isSaved() || d.getId().equals(documentId) || d.getDescriptor().getCode().indexOf("114") != -1) {
				iter.remove();
			}
		}
		if(documents.isEmpty()) {
			return "success";
		}
		StringBuilder documentNames = new StringBuilder();
		for(Document d : documents) {
			documentNames.append("【").append(d.getDescriptor().getCode()).append("】").append("、");
		}
		documentNames.deleteCharAt(documentNames.length() - 1);
		return String.format("直报数据暂时不能进行提交,您还有%d个表格%s未填写,只有填写完并且保存所有表格之后才能提交", documents.size(), documentNames.toString());
	}

	@RequestMapping(value="/declaration/wait_approve")
	public String waitApproveList(HttpServletRequest request, ModelMap model) {
		Map<String, String[]> params = Servlets.getParametersStartingWith(request, "sParam_");
		Map<String, Object> results = declarationService.findByKey(params, PageEngineFactory.getPageEngine(request));
		model.put("companies", results.get("companies"));
		results.remove("companies");
		for(Map.Entry<String, Object> entry : results.entrySet()) {
			model.put(entry.getKey(), entry.getValue());
		}
		
		return "/declaration/wait_approve";
	}

	@RequestMapping(value="/declaration/approve", method=RequestMethod.GET)
	public String approvePage(ModelMap model, @RequestParam(value="targetDocumentId", required=false)Long targetDocumentId,
			@ModelAttribute("declaration") Declaration declaration) {
		List<Document> documents = documentService.findByDeclaration(declaration.getId());
		List<DocumentDescriptor> descriptors = new ArrayList<>(documents.size());
		Document currentDoc = null;
		boolean first = true;
		for(Document d : documents) {
			descriptors.add(d.getDescriptor());
			if(targetDocumentId != null && targetDocumentId.equals(0L)) {
				//targetDocumentId为0代表查看单位基本资料
				continue;
			}
			if(currentDoc == null) {
				if(targetDocumentId != null) {
					//跳转到指定表格
					if(d.getDescriptorId().equals(targetDocumentId)) {
						currentDoc = d;
					}
				} else if(first) {
					//默认先填报第一个表格
					currentDoc = d;
					first = false;
				}
			}
		}
		model.addAttribute("document", currentDoc);
		model.addAttribute("descriptors", descriptors);
		model.addAttribute("company", declaration.getCompany());
		model.addAttribute("approvals", approvalService.findByDeclaration(declaration));
		model.addAttribute("currentCategory", codeService.showCategory(declaration.getCompany().getCategoryCode()));
		return "/declaration/approve";
	}

	@RequestMapping(value="/declaration/approve", method=RequestMethod.POST)
	public String approve(ModelMap model, @ModelAttribute("declaration") Declaration declaration,
			Integer approveResult, String comment, @RequestParam(value="back", required=false)Boolean back) {
		try {
			declarationService.approve(declaration, back, approveResult, comment);
		} catch (AppException e) {
			addErrorMsg(model, e.getMessage());
			return COMMON_ERROR_PAGE;
		}
		return "redirect:/declaration/wait_approve.action";
	}

	@RequestMapping(value="/declaration/cancel")
	public String cancel(ModelMap model, @ModelAttribute("declaration") Declaration declaration, RedirectAttributes redirectAttributes) {
		try {
			declarationService.cancel(declaration);
		} catch (AppException e) {
			addErrorMsg(model, e.getMessage());
			return COMMON_ERROR_PAGE;
		}
		redirectAttributes.addAttribute("message", "cancel");
		return "redirect:/declaration/approval_list.action";
	}
	
	@RequestMapping(value="/declaration/export", method=RequestMethod.GET)
	public String exportDeclarationPage(ModelMap model) {
		List<DocumentDescriptor> descriptors = documentDescriptorService.findByYear(app.getCurrentDeclarationYear());
		model.addAttribute("descriptors", descriptors);
		User user = WebHolder.getUser();
		model.addAttribute("areaJson", areaService.getAreaInJson("深圳市", user));
		
		return "/declaration/export";
	}
	
	@RequestMapping(value="/declaration/export", method=RequestMethod.POST)
	public String exportDeclaration(HttpServletRequest request, HttpServletResponse response, ModelMap model, 
			Long[] areaIds, Long[] desIds, String includeBack, String includeApproving, String includeCancel, String taskId){
		
		if(areaIds == null || areaIds.length == 0) {
			addErrorMsg(model, "请选择一个区之后再导出审核数据");
			return COMMON_ERROR_PAGE;
		}
		if(desIds == null || desIds.length == 0) {
			addErrorMsg(model, "请选择需要导出的表格");
			return COMMON_ERROR_PAGE;
		}
		try {
			synchronized (exportTaskIds) {
				if(exportTaskIds.size() >= 100) {
					exportTaskIds.poll();
				}
				exportTaskIds.offer(taskId);
			}
			declarationService.export(response, areaIds, desIds, includeBack, includeApproving, includeCancel);
		} catch (IOException e) {
			log.error("导出企业直报数据的时候发生错误", e);
			throw new BusinessException("导出企业直报数据的时候发生错误");
		} finally {
			synchronized (exportTaskIds) {
				exportTaskIds.remove(taskId);
			}
		}
		return null;
	}
	
	@RequestMapping("/ajax/declaration/check_task_finished")
	@ResponseBody
	public String checkIfExportTaskFinished(HttpServletRequest request, String taskId, ModelMap model) {
		boolean finished = true;
		synchronized (exportTaskIds) {
			if(exportTaskIds.contains(taskId)) {
				finished = false;
			}
		}
		return String.valueOf(finished);
	}
	
	@RequestMapping(value="/declaration/batch_approve")
	public String batchApprove(ModelMap model, Long[] decIds) {
		if(decIds != null) {
			declarationService.batchApprove(decIds);
		}
		return "redirect:/declaration/wait_approve.action";
	}

	@ModelAttribute("declaration")
	public Declaration getDeclaration(@RequestParam(value="id",required=false)Long id, ModelMap model) {
		if(!ValidateUtil.isNullOrZero(id) && !model.containsKey("declaration")) {
			return declarationService.get(id);
		} else {
			return new Declaration();
		}
	}

	@ModelAttribute("company")
	public Company getCompany(@RequestParam(value="companyId",required=false)Long companyId, ModelMap model) {
		if(!ValidateUtil.isNullOrZero(companyId) && !model.containsKey("company")) {
			return companyService.get(companyId);
		} else {
			return new Company();
		}
	}

	@ModelAttribute("document")
	public Document getDocument(@RequestParam(value="documentId",required=false)Long documentId, ModelMap model) {
		if(!ValidateUtil.isNullOrZero(documentId) && !model.containsKey("document")) {
			return documentService.get(documentId);
		}
		return null;
	}

}
