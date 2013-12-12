package com.lianhua.permission.dao;

import java.util.Collection;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.lianhua.permission.model.Permission;
import com.rootrip.platform.genericdao.dao.hibernate.GenericDAOImpl;
import com.rootrip.platform.genericdao.search.Filter;
import com.rootrip.platform.genericdao.search.Search;

@Repository
public class PermissionDao extends GenericDAOImpl<Permission, Long> {

	public void deleteByOperation(Long operationId) {
		String hql = "delete from Permission p where p.operationId = ?)";
		super.update(hql, operationId);
	}

	public List<Permission> findByOperationName(Collection<String> operationNames) {
		Search search = new Search();
		search.addFilter(Filter.in("operation.name", operationNames));
		return super.search(search);
	}

}
