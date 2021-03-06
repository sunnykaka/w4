package com.lianhua.permission.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lianhua.permission.model.RolePermission;
import com.rootrip.platform.genericdao.dao.hibernate.GenericDAOImpl;
import com.rootrip.platform.genericdao.search.Filter;
import com.rootrip.platform.genericdao.search.Search;

@Repository
public class RolePermissionDao extends GenericDAOImpl<RolePermission, Long> {

	public void deleteByOperation(Long operationId) {
		String hql = "delete from RolePermission rp where rp.permissionId in (select p.id from Permission p where p.operationId = ?)";
		super.update(hql, operationId);
	}

	public List<RolePermission> findByRole(Long roleId) {
		Search search = new Search();
		search.addFilter(Filter.equal("roleId", roleId));
		return super.search(search);
	}

	public void deleteByRole(Long roleId) {
		String hql = "delete from RolePermission rp where rp.roleId = ?";
		super.update(hql, roleId);
	}

	public void deleteAll() {
		String hql = "delete from RolePermission";
		super.update(hql);
	}

}
