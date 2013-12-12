package com.lianhua.upload.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lianhua.file.attach.model.PubFile;
import com.lianhua.file.attach.service.PubFileService;
import com.rootrip.platform.util.PubFileUtil;

@Controller
public class UploadAction {
	
	private final Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private PubFileService fileService;

	@RequestMapping(value="/upload/image")
	public void uploadImage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws IOException {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMaps = multipartRequest.getFileMap();
		if(fileMaps == null || fileMaps.isEmpty()) {
			return;
		}
		MultipartFile mFile = fileMaps.entrySet().iterator().next().getValue();
		if(mFile == null || mFile.isEmpty()) {
			return;
		}
		
		String type = request.getParameter("type");
		if("file".equalsIgnoreCase(type)) {
			if(!PubFileUtil.isPermitFileSuffix(mFile)) {
				log.warn("上传的文件后缀格式错误,文件名:{0}", mFile.getOriginalFilename());
				sendPubFileInfoToWeb(request, response, null, "不允许上传这类文件");
				return;
			}
		} else if("image".equalsIgnoreCase(type)) {
			if(!PubFileUtil.isImageSuffix(mFile)) {
				log.warn("上传的图片后缀格式错误,文件名:{0}", mFile.getOriginalFilename());
				sendPubFileInfoToWeb(request, response, null, "请上传jpg,jpeg,png,gif图片");
				return;
			}
		} else {
			sendPubFileInfoToWeb(request, response, null, "未知的上传类型");
			return;
		}
		
		PubFile pubFile = fileService.uploadImage(mFile, type);
		
		sendPubFileInfoToWeb(request, response, pubFile, "");
		
		return;
	}
	
	private void sendPubFileInfoToWeb(HttpServletRequest request, HttpServletResponse response,
			PubFile pubFile, String message) throws IOException {
		response.setContentType("text/html; charset=UTF-8");  
        response.setHeader("Cache-Control", "no-cache");  
        PrintWriter out = response.getWriter();
        String fileUrl = "";
        if(pubFile != null) {
        	fileUrl = request.getContextPath() + pubFile.getFilePath();
        }
        
        String callback = request.getParameter("CKEditorFuncNum");  
        out.println("<script type='text/javascript'><!--  ");  
        out.println("window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + fileUrl + "','" + message + "'" + ")");  
        out.println("//--></script>"); 
        out.flush();
	}

}
