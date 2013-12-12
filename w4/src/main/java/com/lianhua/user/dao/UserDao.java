package com.lianhua.user.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lianhua.user.model.User;
import com.rootrip.platform.genericdao.dao.hibernate.GenericDAOImpl;
import com.rootrip.platform.genericdao.search.Filter;
import com.rootrip.platform.genericdao.search.Search;

@Repository
public class UserDao extends GenericDAOImpl<User, Long> {

	public List<User> findByRole(Long roleId) {
		Search search = new Search();
		search.addFilter(Filter.in("roleId", roleId));
		return super.search(search);
	}
	
}
