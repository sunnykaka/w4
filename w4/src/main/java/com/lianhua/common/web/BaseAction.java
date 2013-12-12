package com.lianhua.common.web;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;

import com.lianhua.code.model.Code;
import com.lianhua.code.service.CodeService;

public abstract class BaseAction {
	
	public static final String COMMON_ERROR_PAGE = "/error/tips";
	
	protected final Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private CodeService codeService;

	/**
	 * 设置错误消息
	 * @param model
	 * @param string
	 */
	protected void addErrorMsg(ModelMap model, String errorMsg) {
		model.addAttribute("errorMsg", errorMsg);
	}
	
	/**
	 * 加载首页页脚的信息
	 * @param model
	 */
	protected void prepareFooterData(ModelMap model) {
		Map<Long, Code> footerInfoCodeMap = codeService.getCodeMapByKind(CodeService.FOOTER_INFO);
		for(Map.Entry<Long, Code> entry : footerInfoCodeMap.entrySet()) {
			Code code = entry.getValue();
			if("contact".equalsIgnoreCase(code.getName())) {
				model.addAttribute("contactCode", code);
			} else if("copyright".equalsIgnoreCase(code.getName())) {
				model.addAttribute("copyrightCode", code);
			}
		}
	}
	
}
