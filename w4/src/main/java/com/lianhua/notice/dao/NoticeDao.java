package com.lianhua.notice.dao;

import org.springframework.stereotype.Repository;

import com.lianhua.notice.model.Notice;
import com.rootrip.platform.genericdao.dao.hibernate.GenericDAOImpl;

@Repository
public class NoticeDao extends GenericDAOImpl<Notice, Long> {


}
