package com.lianhua.permission.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lianhua.permission.dao.RoleDao;
import com.lianhua.permission.dao.RolePermissionDao;
import com.lianhua.permission.model.Role;
import com.lianhua.user.model.User;
import com.lianhua.user.service.UserService;
import com.rootrip.platform.exception.AppException;
import com.rootrip.platform.genericdao.search.Filter;
import com.rootrip.platform.genericdao.search.Search;

@Service
public class RoleService {
	
	
	@Autowired
	private RoleDao roleDao;
	
	@Autowired
	private RolePermissionDao rolePermissionDao;
	
	@Autowired
	private UserService userService;

	@Transactional(readOnly = true)
	public Role getByName(String name) {
		return roleDao.searchUnique(new Search().addFilter(Filter.equal("name", name)));
	}

	@Transactional
	public void save(Role role) {
		roleDao.save(role);
	}

	@Transactional(readOnly = true)
	public List<Role> findAll() {
		return roleDao.findAll();
	}

	@Transactional
	public void deleteRole(Role role) throws AppException {
		List<User> users = userService.findByRole(role.getId());
		if(!users.isEmpty()) {
			throw new AppException(String.format("role[%s]下有%d个用户,不能删除", role.getName(), users.size()));
		}
		rolePermissionDao.deleteByRole(role.getId());
		roleDao.delete(role);
	}

	@Transactional(readOnly = true)
	public Role getEnterpriseRole() {
		return getByName("企业用户");
	}
	
	@Transactional(readOnly = true)
	public Role getCityManagerRole() {
		return getByName("市管理员");
	}
	
	@Transactional(readOnly = true)
	public Role getCountyManagerRole() {
		return getByName("区管理员");
	}

}
