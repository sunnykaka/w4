package com.lianhua.code.dao;

import org.springframework.stereotype.Repository;

import com.lianhua.code.model.Code;
import com.rootrip.platform.genericdao.dao.hibernate.GenericDAOImpl;

@Repository
public class CodeDao extends GenericDAOImpl<Code, Long> {

}
