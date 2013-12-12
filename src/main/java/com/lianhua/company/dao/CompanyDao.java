package com.lianhua.company.dao;

import org.springframework.stereotype.Repository;

import com.lianhua.company.model.Company;
import com.rootrip.platform.genericdao.dao.hibernate.GenericDAOImpl;

@Repository
public class CompanyDao extends GenericDAOImpl<Company, Long> {

}
