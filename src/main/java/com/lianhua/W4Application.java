package com.lianhua;

import java.util.Locale;

import javax.servlet.ServletContext;

import com.ckeditor.CKEditorConfig;
import com.lianhua.area.service.AreaService;
import com.lianhua.code.service.CodeService;
import com.lianhua.document.service.DocumentDescriptorService;
import com.rootrip.platform.Application;
import com.rootrip.platform.Platform;
import com.rootrip.platform.exception.PlatformException;

/**
 * 
 * @author liubin
 * @date 2012-11-9
 *
 */
public class W4Application extends Application {

	public static final String APP_NAME = "W4Application";
	
	/* (non-Javadoc)
	 * @see com.rootrip.platform.Application#init()
	 */
	public boolean init() {
		if(!super.init()) return false;
		
		try {
			// Set the default locale to custom locale
			Locale.setDefault(new Locale("zh", "CN"));
			
			ServletContext sc = this.getPlatform().getServletContext();
			
			//初始化数据字典
			CodeService codeService = Platform.getInstance().getBean(CodeService.class);
			codeService.load();
			//初始化区域
			AreaService areaService = Platform.getInstance().getBean(AreaService.class);
			areaService.load();
			
			DocumentDescriptorService documentDescriptorService = Platform.getInstance().getBean(DocumentDescriptorService.class);
			documentDescriptorService.initPropertyDescritor();
			
			initCkeditorConfig();
			
			if(sc != null) {
				if(getCurrentDeclarationYear() == null) {
					throw new PlatformException("没有设置当前直报年度,启动失败,请联系系统管理员");
				}
//				sc.setAttribute(AreaService.AREA_KEY, areaService.getBuffer());
				
//				sc.setAttribute("DEFAULT_PORTRAIT", Constants.DEFAULT_PORTRAIT);
//				sc.setAttribute("DEFAULT_IMAGE", Constants.DEFAULT_IMAGE);
			}
			
			return true;
		} catch (Exception e) {
			logger.error("系统初始化错误！", e);
			return false;
		}
	}

	
	public Integer getCurrentDeclarationYear() {
		ServletContext sc = this.getPlatform().getServletContext();
		if(sc == null) return null;
		return (Integer)sc.getAttribute(CodeService.DECLARATION_YEAR);
	}
	
	public boolean isCurrentDeclarationYearOpening() {
		ServletContext sc = this.getPlatform().getServletContext();
		if(sc == null) return false;
		Integer year = getCurrentDeclarationYear();
		if(year == null) return false;
		Boolean b = (Boolean)sc.getAttribute(CodeService.DECLARATION_YEAR_IS_OPENING);
		if(b == null) return false;
		return b;
	}

	private void initCkeditorConfig() {
		ServletContext sc = this.getPlatform().getServletContext();
		if(sc == null) return;
		CKEditorConfig settings = new CKEditorConfig();
		//
//		"[" +
//		"{ name: 'document', items : [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] }," +
//		"{ name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] }," +
//		"{ name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] }," +
//		"{ name: 'forms', items : [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField' ] }," +
//		"'/'," +
//		"{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] }," +
//		"{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] }," +
//		"{ name: 'links', items : [ 'Link','Unlink','Anchor' ] }," +
//		"{ name: 'insert', items : [ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe' ] }," +
//		"'/'," +
//		"{ name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] }," +
//		"{ name: 'colors', items : [ 'TextColor','BGColor' ] }," +
//		"{ name: 'tools', items : [ 'Maximize', 'ShowBlocks','-','About' ] }" +
//		"]"
		settings.addConfigValue("toolbar",
				"[" +
						"{ name: 'document', items : [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] }," +
						"{ name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] }," +
						"{ name: 'editing', items : [ 'Find','Replace','-','SelectAll'] }," +
						"'/'," +
						"{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] }," +
						"{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] }," +
						"{ name: 'links', items : [ 'Link','Unlink','Anchor' ] }," +
						"{ name: 'insert', items : [ 'Image','Table','HorizontalRule','SpecialChar','PageBreak'] }," +
						"{ name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] }," +
						"{ name: 'colors', items : [ 'TextColor','BGColor' ] }," +
						"{ name: 'tools', items : [ 'Maximize', 'ShowBlocks'] }" +
				"]"
			);
		settings.addConfigValue("filebrowserImageUploadUrl",getPlatform().getContextPath() + "/upload/image.action?type=image");
		settings.addConfigValue("filebrowserUploadUrl",getPlatform().getContextPath() + "/upload/image.action?type=file");
		settings.addConfigValue("language", "zh-cn");
		
		sc.setAttribute("ckeditorConfig", settings);
	}


}
