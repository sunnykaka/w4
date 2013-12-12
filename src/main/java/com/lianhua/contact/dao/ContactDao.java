package com.lianhua.contact.dao;

import org.springframework.stereotype.Repository;

import com.lianhua.contact.model.Contact;
import com.rootrip.platform.genericdao.dao.hibernate.GenericDAOImpl;

@Repository
public class ContactDao extends GenericDAOImpl<Contact, Long> {

}
