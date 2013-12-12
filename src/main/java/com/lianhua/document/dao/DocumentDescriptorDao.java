package com.lianhua.document.dao;

import org.springframework.stereotype.Repository;

import com.lianhua.document.model.DocumentDescriptor;
import com.rootrip.platform.genericdao.dao.hibernate.GenericDAOImpl;
import com.rootrip.platform.genericdao.search.Filter;
import com.rootrip.platform.genericdao.search.Search;

@Repository
public class DocumentDescriptorDao extends GenericDAOImpl<DocumentDescriptor, Long> {

	public DocumentDescriptor getByCodeAndYear(String code, int year) {
		Search search = new Search().addSortAsc("id");
		search.addFilter(Filter.equal("code", code)).addFilter(Filter.equal("year", year));
		return searchUnique(search);
	}
	
}
