package com.lianhua.document.dao;

import org.springframework.stereotype.Repository;

import com.lianhua.document.model.Property;
import com.rootrip.platform.genericdao.dao.hibernate.GenericDAOImpl;

@Repository
public class PropertyDao extends GenericDAOImpl<Property, Long> {

	public void deleteByDocument(Long documentId) {
		String hql = "delete from Property t where t.documentId = ?";
		super.update(hql, documentId);
	}

}
