package com.lianhua.document.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lianhua.W4Application;
import com.lianhua.declaration.model.Declaration;
import com.lianhua.declaration.model.EnumDeclarationState;
import com.lianhua.document.dao.DocumentDao;
import com.lianhua.document.dao.PropertyDao;
import com.lianhua.document.model.Document;
import com.lianhua.document.model.DocumentDescriptor;
import com.rootrip.platform.Platform;
import com.rootrip.platform.exception.AppException;

@Service
public class DocumentService {
	
	@Autowired
	private DocumentDao documentDao;
	
	@Autowired
	private PropertyDao propertyDao;
	
	private W4Application app = (W4Application)Platform.getInstance().getApp();
	

	@Transactional(readOnly = true)
	public List<Document> findByDeclaration(Long declarationId) {
		return documentDao.findByDeclaration(declarationId);
	}

	@Transactional
	public void deleteDocument(Document document) {
		propertyDao.deleteByDocument(document.getId());
		documentDao.delete(document);
	}

	@Transactional
	public void createDocument(Declaration declaration, DocumentDescriptor descriptor) {
		Document document = new Document();
		document.setDescriptorId(descriptor.getId());
		document.setDescriptor(descriptor);
		document.setDeclarationId(declaration.getId());
		document.setDeclaration(declaration);
		documentDao.save(document);
	}

	@Transactional(readOnly = true)
	public Document get(Long id) {
		return documentDao.get(id);
	}

	
}
