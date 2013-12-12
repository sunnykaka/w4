package com.lianhua.file.attach.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.lianhua.file.attach.model.PubFile;
import com.rootrip.platform.Platform;
import com.rootrip.platform.util.DateUtil;
import com.rootrip.platform.util.PubFileUtil;

@Service
public class PubFileService {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());

	public File getRealFile(PubFile pubFile) {
		if(pubFile == null) return null;
		String directory = Platform.getInstance().getApp().getAttachPath();
		String filePath = directory + pubFile.getFilePath();
		log.debug("读取附件,路径为[{}]", filePath);
		File file = new File(filePath);
		if(file.exists() && file.isFile()) {
			return file;
		}
		return null;
	}
	

	/**
	 * 在文本编辑器中上传图片
	 * @param mFile 
	 * @param type 
	 * @return VO对象,数据库没有对应记录
	 */
	public PubFile uploadImage(MultipartFile mFile, String type) {
		if(mFile == null || mFile.isEmpty()) {
			return null;
		}
		String fileName = null;
		if("file".equalsIgnoreCase(type)) {
			fileName = mFile.getOriginalFilename();
		} else {
			fileName = PubFileUtil.generateRandomFileName() + PubFileUtil.getSuffix(mFile);
		}
		String directory = Platform.getInstance().getApp().getAttachPath();
		String webPathDirectory = new StringBuilder().append("/rooufiles/")
				.append(DateUtil.formatDate(new Date(), "yyyyMMdd")).append("/").toString();
		if(log.isDebugEnabled()) {
			log.debug("保存附件,路径为[{}]", new StringBuilder().append(directory).append(webPathDirectory).append(fileName).toString());
		}
		File fileDirectory = new File(directory + webPathDirectory);
		if(!fileDirectory.exists()) {
			fileDirectory.mkdirs();
		}
		try {
			mFile.transferTo(new File(fileDirectory, fileName));
			PubFile pubFile = new PubFile();
			pubFile.setName(fileName);
			pubFile.setFilePath(webPathDirectory + fileName);
			return pubFile;
		} catch (IllegalStateException e) {
			log.error("文件上传失败", e);
		} catch (IOException e) {
			log.error("文件上传失败", e);
		}
		return null;
	}
	
	/**
	 * 从url路径复制文件到本地
	 * @param urlStr
	 * @return
	 */
	public PubFile copyImageFromUrl(String urlStr) {
		if(StringUtils.isBlank(urlStr)) 
			return null;
		InputStream inputStream = null;
		try {
			String fileName = PubFileUtil.generateRandomFileName() + ".jpg";
			String directory = Platform.getInstance().getApp().getAttachPath();
			String webPathDirectory = new StringBuilder().append("/rooufiles/")
					.append(DateUtil.formatDate(new Date(), "yyyyMMdd")).append("/").toString();
			if(log.isDebugEnabled()) {
				log.debug("保存附件,路径为[{}]", new StringBuilder().append(directory).append(webPathDirectory).append(fileName).toString());
			}
			File fileDirectory = new File(directory + webPathDirectory);
			if(!fileDirectory.exists()) {
				fileDirectory.mkdirs();
			}
			
			URL url = new URL(urlStr);
			inputStream = url.openStream();
			
			IOUtils.copy(inputStream, new FileOutputStream(new File(fileDirectory, fileName)));
			
			PubFile pubFile = new PubFile();
			pubFile.setName(fileName);
			pubFile.setFilePath(webPathDirectory + fileName);
			return pubFile;
			
		} catch (MalformedURLException e) {
			log.error("文件url路径格式不正确", e);
		} catch (IOException e) {
			log.error("", e);
		} finally {
			if(inputStream != null) {
				try {
					inputStream.close();
				} catch (IOException e) {
					log.error("", e);
				}
			}
		}
		return null;
	}

	
	/**
	 * 删除路径下的附件,多个路径以,分隔
	 * @param filePath
	 */
	public void deleteImages(String filePaths) {
		if(StringUtils.isBlank(filePaths)) return;
		String[] oldImages = filePaths.split(",");
		for (int i = 0; i < oldImages.length; i++) {
			deleteImage(oldImages[i]);
		}
	}
	
	/**
	 * 删除路径下的附件
	 * @param filePath
	 */
	private void deleteImage(String filePath) {
		if(StringUtils.isBlank(filePath)) return;
		String realFilePath = Platform.getInstance().getApp().getAttachPath() + filePath;
		File realFile = new File(realFilePath);
		log.debug("删除附件,路径为[{}]", realFilePath);
		if(realFile.exists() && realFile.isFile()) {
			if(!realFile.delete()) {
				log.warn("删除附件失败,路径为[{}]", realFilePath);
			}
		}
	}


}
