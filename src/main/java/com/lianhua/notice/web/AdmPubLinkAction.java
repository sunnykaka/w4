package com.lianhua.notice.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lianhua.common.web.BaseAction;
import com.lianhua.notice.model.PubLink;
import com.lianhua.notice.service.PubLinkService;
import com.rootrip.platform.common.web.page.PageEngineFactory;
import com.rootrip.platform.util.EntityUtil;
import com.rootrip.platform.util.Servlets;
import com.rootrip.platform.util.ValidateUtil;

@Controller
public class AdmPubLinkAction extends BaseAction {
	
	@Autowired
	private PubLinkService linkService;

	@RequestMapping(value="/adm/notice/link_list")
	public String list(HttpServletRequest request, ModelMap model) {
		
		Map<String, String[]> params = Servlets.getParametersStartingWith(request, "sParam_");
		List<PubLink> links = linkService.findByKey(params, PageEngineFactory.getPageEngine(request));
		model.addAttribute("links", links);
		
		return "/adm/notice/link_list";
	}
	
	@RequestMapping(value="/adm/notice/link_add")
	public String add(ModelMap model) {
		
		return "/adm/notice/link_add";
	}
	
	@RequestMapping(value="/adm/notice/link_update")
	public String update(ModelMap model) {
		
		return "/adm/notice/link_update";
	}
	
	@RequestMapping(value="/adm/notice/link_save")
	public String save(HttpServletRequest request, @ModelAttribute("link") @Valid PubLink link, 
			BindingResult results, ModelMap model) {
		if(results.hasErrors()) {
			//数据验证失败
			if(EntityUtil.isCreate(link)) {
				return add(model);
			} else {
				return update(model);
			}
		}
		
		linkService.saveLink(link);
		
		return "redirect:/adm/notice/link_list.action";
	}
	
	@RequestMapping(value="/adm/notice/link_delete")
	public String delete(@ModelAttribute("link") PubLink link, ModelMap model) {
		linkService.deleteLink(link);
		
		return "redirect:/adm/notice/link_list.action";
	}
	
	@RequestMapping(value="/ajax/adm/notice/link_update_sort")
	@ResponseBody
	public String updateSort(@RequestParam("entityId")Long entityId, @RequestParam("bySort")Long bySort) {
		PubLink link = linkService.get(entityId);
		if(link != null && bySort != null) {
			link.setBySort(bySort);
			linkService.save(link);
			return "success";
		}
		return "fail";
	}
	
	@ModelAttribute("link")
	public PubLink getLink(Long linkId, ModelMap model) {
		if(!ValidateUtil.isNullOrZero(linkId) && !model.containsKey("link")) {
			return linkService.get(linkId);
		} else {
			return new PubLink();
		}
	}

}
