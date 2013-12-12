package com.lianhua.document.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lianhua.document.model.Document;
import com.rootrip.platform.genericdao.dao.hibernate.GenericDAOImpl;
import com.rootrip.platform.genericdao.search.Filter;
import com.rootrip.platform.genericdao.search.Search;

@Repository
public class DocumentDao extends GenericDAOImpl<Document, Long> {

	/**
	 * 
	 * @param declarationId
	 * @return
	 */
	public List<Document> findByDeclaration(Long declarationId) {
		Search search = new Search().addSortAsc("descriptor.code");
		search.addFilter(Filter.equal("declarationId", declarationId));
		return super.search(search);
	}

}
