package com.lianhua.company.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.lianhua.W4Application;
import com.lianhua.code.service.CodeService;
import com.lianhua.common.web.BaseAction;
import com.lianhua.company.model.Company;
import com.lianhua.company.model.EnumCompanyState;
import com.lianhua.company.service.CompanyService;
import com.lianhua.declaration.service.ApprovalService;
import com.rootrip.platform.Platform;
import com.rootrip.platform.common.web.page.PageEngineFactory;
import com.rootrip.platform.exception.AppException;
import com.rootrip.platform.util.Servlets;
import com.rootrip.platform.util.ValidateUtil;

@Controller
public class CompanyAction extends BaseAction {

	@Autowired
	private CompanyService companyService;

	@Autowired
	private ApprovalService approvalService;

	@Autowired
	private CodeService codeService;
	
	private W4Application app = (W4Application)Platform.getInstance().getApp(); 

	@RequestMapping("/company/add")
	public String addCompany(ModelMap model) {
		model.addAttribute("categoryJson", codeService.getCategoryInJson());
		return "/company/add";
	}

	@RequestMapping("/company/update")
	public String updateCompany(@ModelAttribute("company") Company company, ModelMap model) {
		model.addAttribute("categoryJson", codeService.getCategoryInJson());
		model.addAttribute("currentCategory", codeService.showCategory(company.getCategoryCode()));
		return "/company/update";
	}

	@RequestMapping("/company/save")
	public String saveCompany(HttpServletRequest request, @ModelAttribute("company") Company company,
			ModelMap model, @RequestParam(value="commit", required=false)Boolean commit) {
		if(companyService.isCodeExist(company.getCode(), company.getId(), app.getCurrentDeclarationYear())) {
			addErrorMsg(model, "您填写的组织机构代码与系统中已有记录重复，请检查是否填写正确");
			return COMMON_ERROR_PAGE;
		}
		
		try {
			companyService.saveCompany(company, company.getContact(), commit);
		} catch (AppException e) {
			addErrorMsg(model, e.getMessage());
			return COMMON_ERROR_PAGE;
		}

		return "redirect:/company/list.action";
	}

	@RequestMapping({"/company/list", "/company/wait_approve"})
	public String listCompany(HttpServletRequest request, ModelMap model) {
		Map<String, String[]> params = Servlets.getParametersStartingWith(request, "sParam_");
		model.put("companies", companyService.findByKey(params, PageEngineFactory.getPageEngine(request)));
		return "/company/list";
	}

	@RequestMapping("/company/final_list")
	public String finalListCompany(HttpServletRequest request, ModelMap model) {
		Map<String, String[]> params = Servlets.getParametersStartingWith(request, "sParam_");
		if(!params.containsKey("state")) {
			params.put("state", new String[]{String.valueOf(EnumCompanyState.NORMAL.value)});
		}
		model.put("companies", companyService.findByKey(params, PageEngineFactory.getPageEngine(request)));
		return "/company/final_list";
	}

	@RequestMapping(value="/company/approve", method=RequestMethod.GET)
	public String approvePage(ModelMap model, @ModelAttribute("company") Company company) {
		model.addAttribute("approvals", approvalService.findByCompany(company));
		model.addAttribute("currentCategory", codeService.showCategory(company.getCategoryCode()));
		return "/company/approve";
	}

	@RequestMapping(value="/company/approve", method=RequestMethod.POST)
	public String approve(ModelMap model, @ModelAttribute("company") Company company, String comment,
			@RequestParam(value="back", required=false)Boolean back) {
		try {
			companyService.approve(company, back, comment);
		} catch (AppException e) {
			addErrorMsg(model, e.getMessage());
			return COMMON_ERROR_PAGE;
		}
		return "redirect:/company/wait_approve.action";
	}

	@RequestMapping(value="/company/delete")
	public String delete(ModelMap model, @ModelAttribute("company") Company company) {
		try {
			companyService.deleteCompany(company);
		} catch (AppException e) {
			addErrorMsg(model, e.getMessage());
			return COMMON_ERROR_PAGE;
		}
		return "redirect:/company/final_list.action";
	}

	@RequestMapping(value="/company/major_inquiry")
	public String majorInquiry(ModelMap model, @ModelAttribute("company") Company company, boolean isMajorInquiry) {
		companyService.setMajorInquiry(company, isMajorInquiry);
		return "redirect:/company/list.action";
	}

	@ModelAttribute("company")
	public Company getCompany(@RequestParam(value="id",required=false)Long id, ModelMap model) {
		if(!ValidateUtil.isNullOrZero(id) && !model.containsKey("company")) {
			return companyService.get(id);
		} else {
			return new Company();
		}
	}

}
