package com.lianhua.declaration.dao;

import org.springframework.stereotype.Repository;

import com.lianhua.declaration.model.Declaration;
import com.rootrip.platform.genericdao.dao.hibernate.GenericDAOImpl;

@Repository
public class DeclarationDao extends GenericDAOImpl<Declaration, Long> {

}
