package com.lianhua.common.web.el;

import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import com.lianhua.W4Application;
import com.lianhua.code.model.Code;
import com.lianhua.code.service.CodeService;
import com.lianhua.common.web.WebHolder;
import com.lianhua.company.service.CompanyService;
import com.lianhua.declaration.service.DeclarationService;
import com.lianhua.document.model.Document;
import com.lianhua.document.model.Property;
import com.lianhua.document.service.DocumentDescriptorService;
import com.lianhua.permission.util.PermissionUtil;
import com.lianhua.user.model.User;
import com.rootrip.platform.Platform;


public class W4Function {
	
	private static CodeService codeService = Platform.getInstance().getBean(CodeService.class);
	private static CompanyService companyService = Platform.getInstance().getBean(CompanyService.class);
	private static DeclarationService declarationService = Platform.getInstance().getBean(DeclarationService.class);
	private static W4Application app = (W4Application)Platform.getInstance().getApp();
	private static DocumentDescriptorService documentDesciptorService = Platform.getInstance().getBean(DocumentDescriptorService.class);
	
	/**
	 * 得到某一类型的数据字段缓存map
	 * @param kind
	 * @return
	 */
	public static Map<Long, Code> getCodeMap(String kind) {
		return codeService.getCodeMapByKind(kind);
	}
	
	/**
	 * 根据数据字典的id显示字面值
	 * @param codeId
	 * @return
	 */
	public static String displayCode(Long codeId) {
		Code code = codeService.getCodeById(codeId);
		if(code == null) return null;
		return code.getDisplayName();
	}
	
	public static boolean isCompanyUpdatable(PageContext pageContext, Long companyId) {
		HttpSession session = pageContext.getSession();
		User currentUser = (User)session.getAttribute(User.SESSION_KEY);
		return companyService.isCompanyUpdatable(currentUser, companyId);
	}
	
	public static boolean isCompanyApprovable(PageContext pageContext, Long companyId) {
		HttpSession session = pageContext.getSession();
		User currentUser = (User)session.getAttribute(User.SESSION_KEY);
		return companyService.isCompanyApprovable(currentUser, companyId);
	}
	
	public static boolean isDeclarationUpdatable(PageContext pageContext, Long declarationId) {
		HttpSession session = pageContext.getSession();
		User currentUser = (User)session.getAttribute(User.SESSION_KEY);
		return declarationService.isDeclarationUpdatable(currentUser, declarationId);
	}
	
	public static boolean isDeclarationApprovable(PageContext pageContext, Long declarationId) {
		HttpSession session = pageContext.getSession();
		User currentUser = (User)session.getAttribute(User.SESSION_KEY);
		return declarationService.isDeclarationApprovable(currentUser, declarationId);
	}
	
	public static boolean isCountyManager() {
		User currentUser = WebHolder.getUser();
		return PermissionUtil.isCountyManager(currentUser);
	}
	
	public static boolean isCityManager() {
		User currentUser = WebHolder.getUser();
		return PermissionUtil.isCityManager(currentUser);
	}
	
	public static boolean isEnterprise() {
		User currentUser = WebHolder.getUser();
		return PermissionUtil.isEnterprise(currentUser);
	}
	
	
	/**
	 * 与showValue功能相同
	 * @param document
	 * @param propertyName
	 * @return
	 */
	public static String showNumber(Document document, String propertyName) {
		return showValue(document, propertyName);
	}
	
	/**
	 * 显示表格的属性
	 * @param document
	 * @param propertyName
	 * @return
	 */
	public static String showValue(Document document, String propertyName) {
		Map<String, Property> propertyMap = document.getPropertyMap();
		Property prop = propertyMap.get(propertyName);
		if(prop == null) {
			return null;
		}
		return prop.getValue();
	}
	
	/**
	 * 显示提示信息
	 * @param document
	 * @param tipName
	 * @return
	 */
	public static String getTip(Document document, String tipName) {
		return documentDesciptorService.getTips().get(String.valueOf(document.getDescriptorId()) + "_" + tipName);
	}
	
	/**
	 * 显示单位资料提示信息
	 * @param tipName
	 * @return
	 */
	public static String getCompanyTip(String tipName) {
		return documentDesciptorService.getTips().get("company" + "_" + tipName);
	}
	
	/**
	 * 显示统计的数据所对应年度
	 * @param document
	 * @return
	 */
	public static int showStatYear(Document document) {
		return app.getCurrentDeclarationYear() - 1;
	}
}
