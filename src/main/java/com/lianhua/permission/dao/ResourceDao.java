package com.lianhua.permission.dao;

import org.springframework.stereotype.Repository;

import com.lianhua.permission.model.Resource;
import com.rootrip.platform.genericdao.dao.hibernate.GenericDAOImpl;

@Repository
public class ResourceDao extends GenericDAOImpl<Resource, Long> {

}
