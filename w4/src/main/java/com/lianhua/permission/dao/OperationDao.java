package com.lianhua.permission.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lianhua.permission.model.Operation;
import com.rootrip.platform.genericdao.dao.hibernate.GenericDAOImpl;
import com.rootrip.platform.genericdao.search.Filter;
import com.rootrip.platform.genericdao.search.Search;

@Repository
public class OperationDao extends GenericDAOImpl<Operation, Long> {

	public List<Operation> findByResource(Long resourceId) {
		Search search = new Search();
		search.addFilter(Filter.equal("resourceId", resourceId));
		return super.search(search);
	}

}
