package com.lianhua.notice.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lianhua.notice.dao.NoticeDao;
import com.lianhua.notice.dao.NoticeTypeDao;
import com.lianhua.notice.model.Notice;
import com.lianhua.notice.model.NoticeType;
import com.rootrip.platform.common.dao.Page;
import com.rootrip.platform.genericdao.search.Filter;
import com.rootrip.platform.genericdao.search.Search;
import com.rootrip.platform.util.EntityUtil;

@Service
public class NoticeService {
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private NoticeTypeDao noticeTypeDao;

	public List<NoticeType> findAllType() {
		Search search = new Search();
		search.addSortDesc("bySort");
		return noticeTypeDao.search(search);
	}
	
	@Transactional(readOnly = true)
	public List<Notice> findByKey(Map<String, String[]> paramMap, Page page) {
		Search search = new Search().addSortDesc("bySort").addSortDesc("addTime").setPagination(page);
		if(paramMap.containsKey("key") && paramMap.get("key").length > 0) {
			String key = paramMap.get("key")[0];
			search.addFilter(Filter.like("title", "%" + key + "%"));
		}
		if(paramMap.containsKey("typeId") && paramMap.get("typeId").length > 0) {
			String typeId = paramMap.get("typeId")[0];
			if(!"-1".equals(typeId)) {
				search.addFilter(Filter.equal("typeId", Long.parseLong(typeId)));
			}
		}
		
		return noticeDao.search(search);
	}

	@Transactional
	public void saveNotice(Notice notice) {
		if(EntityUtil.isCreate(notice)) {
			notice.setAddTime(new Date());
		}
		noticeDao.save(notice);
	}

	@Transactional
	public void deleteNotice(Notice notice) {
		noticeDao.delete(notice);
	}

	@Transactional
	public void save(Notice notice) {
		noticeDao.save(notice);
	}

	@Transactional(readOnly = true)
	public Notice get(Long notice) {
		return noticeDao.get(notice);
	}

	@Transactional(readOnly = true)
	public NoticeType getType(Long typeId) {
		return noticeTypeDao.get(typeId);
	}
}
