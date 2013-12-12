package com.lianhua.notice.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lianhua.common.web.BaseAction;
import com.lianhua.notice.model.Notice;
import com.lianhua.notice.service.NoticeService;
import com.rootrip.platform.util.Servlets;
import com.rootrip.platform.util.ValidateUtil;

@Controller
public class NoticeAction extends BaseAction {

	@Autowired
	private NoticeService noticeService;

	@RequestMapping(value="/notice/list")
	public String list(HttpServletRequest request, ModelMap model) {
		
		Map<String, String[]> params = Servlets.getParametersStartingWith(request, "sParam_");
		List<Notice> notices = noticeService.findByKey(params, null);
		model.addAttribute("notices", notices);
		String typeId = request.getParameter("sParam_typeId");
		if(StringUtils.isNumeric(typeId)) {
			model.addAttribute("noticeType", noticeService.getType(Long.parseLong(typeId)));
		}
		
		prepareFooterData(model);
		
		return "/notice/list";
	}
	
	@RequestMapping(value="/notice/detail")
	public String detail(ModelMap model) {
		
		prepareFooterData(model);
		
		return "/notice/detail";
	}
	
	@ModelAttribute("notice")
	public Notice getNotice(Long noticeId, ModelMap model) {
		if(!ValidateUtil.isNullOrZero(noticeId) && !model.containsKey("notice")) {
			return noticeService.get(noticeId);
		} else {
			return new Notice();
		}
	}

}
