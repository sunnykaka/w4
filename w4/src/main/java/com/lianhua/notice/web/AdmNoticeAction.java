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
import com.lianhua.notice.model.Notice;
import com.lianhua.notice.model.NoticeType;
import com.lianhua.notice.service.NoticeService;
import com.rootrip.platform.common.web.page.PageEngineFactory;
import com.rootrip.platform.util.EntityUtil;
import com.rootrip.platform.util.Servlets;
import com.rootrip.platform.util.ValidateUtil;

@Controller
public class AdmNoticeAction extends BaseAction {

	@Autowired
	private NoticeService noticeService;

	@RequestMapping(value="/adm/notice/list")
	public String list(HttpServletRequest request, ModelMap model) {
		
		List<NoticeType> types = noticeService.findAllType();
		model.addAttribute("types", types);
		Map<String, String[]> params = Servlets.getParametersStartingWith(request, "sParam_");
		List<Notice> notices = noticeService.findByKey(params, PageEngineFactory.getPageEngine(request));
		model.addAttribute("notices", notices);
		
		return "/adm/notice/list";
	}
	
	@RequestMapping(value="/adm/notice/add")
	public String add(ModelMap model) {
		List<NoticeType> types = noticeService.findAllType();
		model.addAttribute("types", types);
		return "/adm/notice/add";
	}
	
	@RequestMapping(value="/adm/notice/update")
	public String update(ModelMap model) {
		List<NoticeType> types = noticeService.findAllType();
		model.addAttribute("types", types);
		return "/adm/notice/update";
	}
	
	@RequestMapping(value="/adm/notice/save")
	public String save(HttpServletRequest request, @ModelAttribute("notice") @Valid Notice notice, 
			BindingResult results, ModelMap model) {
		if(results.hasErrors()) {
			//数据验证失败
			if(EntityUtil.isCreate(notice)) {
				return add(model);
			} else {
				return update(model);
			}
		}
		String important = request.getParameter("important");
		if(important == null || important.equals("")) {
			notice.setImportant(false);
		}
		String news = request.getParameter("news");
		if(news == null || news.equals("")) {
			notice.setNews(false);
		}
		
		noticeService.saveNotice(notice);
		
		return "redirect:/adm/notice/list.action";
	}
	
	@RequestMapping(value="/adm/notice/delete")
	public String delete(@ModelAttribute("notice") Notice notice, ModelMap model) {
		noticeService.deleteNotice(notice);
		
		return "redirect:/adm/notice/list.action";
	}
	
	@RequestMapping(value="/ajax/adm/notice/update_sort")
	@ResponseBody
	public String updateSort(@RequestParam("entityId")Long entityId, @RequestParam("bySort")Long bySort) {
		Notice notice = noticeService.get(entityId);
		if(notice != null && bySort != null) {
			notice.setBySort(bySort);
			noticeService.save(notice);
			return "success";
		}
		return "fail";
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
