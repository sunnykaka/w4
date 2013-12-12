package com.lianhua.notice.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lianhua.common.web.BaseAction;
import com.lianhua.notice.model.PubLink;
import com.lianhua.notice.service.PubLinkService;

@Controller
public class PubLinkAction extends BaseAction {

	@Autowired
	private PubLinkService linkService;

	@RequestMapping(value="/notice/link_list")
	public String list(HttpServletRequest request, ModelMap model) {
		
		List<PubLink> links = linkService.findByKey(null, null);
		model.addAttribute("links", links);
		
		prepareFooterData(model);
		
		return "/notice/link_list";
	}
	
}
