package com.lianhua.declaration.dao;

import org.springframework.stereotype.Repository;

import com.lianhua.declaration.model.Approval;
import com.rootrip.platform.genericdao.dao.hibernate.GenericDAOImpl;

@Repository
public class ApprovalDao extends GenericDAOImpl<Approval, Long> {

}
