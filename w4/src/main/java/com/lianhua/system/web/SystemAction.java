package com.lianhua.system.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lianhua.W4Application;
import com.lianhua.area.service.AreaService;
import com.lianhua.code.model.Code;
import com.lianhua.code.service.CodeService;
import com.lianhua.common.excel.ExcelTemplate;
import com.lianhua.common.util.ImportResult;
import com.lianhua.common.web.BaseAction;
import com.lianhua.common.web.WebHolder;
import com.lianhua.company.service.CompanyService;
import com.lianhua.user.model.User;
import com.rootrip.platform.Platform;
import com.rootrip.platform.exception.BusinessException;
import com.rootrip.platform.util.PubFileUtil;

@Controller
public class SystemAction extends BaseAction {

	@Autowired
	private CodeService codeService;
	
	@Autowired
	private CompanyService companyService;
	
	@Autowired
	private AreaService areaService;
	
	private W4Application app = (W4Application)Platform.getInstance().getApp();

	@RequestMapping(value="/system/set_year", method=RequestMethod.GET)
	public String setYearPage(ModelMap model) {
		Map<Long, Code> codeMap = codeService.getCodeMapByKind(CodeService.DECLARATION_YEAR);
		Code currentYearCode = codeService.getCurrentDeclarationYearCode();
		model.addAttribute("currentYearCode", currentYearCode);
		model.addAttribute("years", codeMap.values());

		return "/system/set_year";
	}

	@RequestMapping(value="/system/set_year", method=RequestMethod.POST)
	public String setYear(HttpServletRequest request, ModelMap model, Integer currentYear, String currentYearState) {
		codeService.changeCurrentYear(currentYear, currentYearState);
		WebHolder.getUser().setCurrentYear(app.getCurrentDeclarationYear());

		return "redirect:/system/set_year.action";
	}

	@RequestMapping(value="/system/set_major_inquiry", method=RequestMethod.GET)
	public String setMajorInquiryPage(ModelMap model) {
		Map<Long, Code> codeMap = codeService.getCodeMapByKind(CodeService.MAJOR_INQUIRY);
		Code code = null;
		boolean isMajorInquiry = false;
		for(Map.Entry<Long, Code> entry : codeMap.entrySet()) {
			code = entry.getValue();
		}
		if(code != null) {
			isMajorInquiry = Boolean.valueOf(code.getValue());
		}
		model.addAttribute("isMajorInquiry", isMajorInquiry);

		return "/system/set_major_inquiry";
	}

	@RequestMapping(value="/system/set_major_inquiry", method=RequestMethod.POST)
	public String setMajorInquiry(HttpServletRequest request, ModelMap model, boolean isMajorInquiry) {
		codeService.changeMajorInquiry(isMajorInquiry);

		return "redirect:/system/set_major_inquiry.action";
	}
	
	@RequestMapping(value="/system/company_import", method=RequestMethod.GET)
	public String importCompanyPage(ModelMap model) {
		
		return "/system/company_import";
	}
	
	@RequestMapping(value="/system/company_tmpl")
	public String downloadCompanyTemplate(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		try {
			ExcelTemplate template = new ExcelTemplate("templates/company_tmpl.xlsx");
			
			template.writeToDownload(response, "单位资料导入模版");
		} catch (IOException e) {
			log.error("下载单位资料导入模版的时候发生错误", e);
			throw new BusinessException("下载单位资料导入模版的时候发生错误");
		}

		return null;
	}
	
	@RequestMapping(value="/system/company_import", method=RequestMethod.POST)
	public String importCompany(HttpServletRequest request, HttpServletResponse response, ModelMap model){
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile excelFile = multipartRequest.getFile("excelFile");
		if(excelFile == null || excelFile.isEmpty()) {
			addErrorMsg(model, "请选择需要导入的excel文件");
			return importCompanyPage(model);
		}
		if(!".xlsx".equalsIgnoreCase(PubFileUtil.getSuffix(excelFile))) {
			addErrorMsg(model, "文件格式错误");
			return importCompanyPage(model);
		}
		
		ImportResult result = companyService.importCompany(excelFile);
		model.addAttribute("importResult", result);
		request.getSession().setAttribute("importResult", result);

		return "/system/company_import_result";
	}
	
	@RequestMapping(value="/system/company_pro")
	public String downloadCompanyImportResult(HttpServletRequest request, HttpServletResponse response, ModelMap model){
		HttpSession session = request.getSession(false);
		if(session != null) {
			try {
				ImportResult result = (ImportResult)session.getAttribute("importResult");
				if(result != null) {
					ExcelTemplate template = new ExcelTemplate("templates/company_tmpl.xlsx");
					
					List<String[]> datas = result.getDatas();
					String[] wrongInfos = result.getWrongInfos();
					if(datas != null) {
						for(int i = 0; i < datas.size(); i++){
							String[] items = datas.get(i);
							
							template.createRow(i);
							
							for(String item : items){
								template.createCell(item);
							}
							if(wrongInfos[i] != null) {
								template.createCell(wrongInfos[i]);
							}
						}
					}
					template.getCurrentSheet().autoSizeColumn(0);
					template.writeToDownload(response, "单位资料导入错误提示");
				}
			} catch (IOException e) {
				log.error("下载单位资料导入结果的时候发生错误", e);
				throw new BusinessException("下载单位资料导入结果的时候发生错误");
			}
		}

		return null;
	}
	
	@RequestMapping(value="/system/update_contact", method=RequestMethod.GET)
	public String updateContactPage(ModelMap model) {
		Map<Long, Code> supportContactCodeMap = codeService.getCodeMapByKind(CodeService.SUPPORT_CONTACT);
		List<Code> supportContactCodes = new ArrayList<>(supportContactCodeMap.values());
		model.addAttribute("supportContactCodes", supportContactCodes);
		prepareFooterData(model);

		return "/system/update_contact";
	}
	
	@RequestMapping(value="/system/update_contact", method=RequestMethod.POST)
	public String updateContact(ModelMap model, String[] supportContactCodeIds, String[] supportContactCodeValues, 
			Long contactCodeId, String contactCodeValue, Long copyrightCodeId, String copyrightCodeValue) {
		
		codeService.updateContact(supportContactCodeIds, supportContactCodeValues, contactCodeId, contactCodeValue,
				copyrightCodeId, copyrightCodeValue);

		return "redirect:/system/update_contact.action";
	}
	
	@RequestMapping(value="/system/company_export", method=RequestMethod.GET)
	public String exportCompanyPage(ModelMap model) {
		User user = WebHolder.getUser();
		model.addAttribute("areaJson", areaService.getAreaInJson("深圳市", user));
		
		return "/system/company_export";
	}
	
	@RequestMapping(value="/system/company_export", method=RequestMethod.POST)
	public String exportCompany(HttpServletRequest request, HttpServletResponse response, ModelMap model, 
			Long[] areaIds, Byte[] declarationStates){
		
		try {
			companyService.exportCompany(response, areaIds, declarationStates);
		} catch (IOException e) {
			log.error("导出企业名录库的时候发生错误", e);
			throw new BusinessException("导出企业名录库的时候发生错误");
		}
		return null;
	}
	
}
