package com.lianhua.notice.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lianhua.notice.dao.PubLinkDao;
import com.lianhua.notice.model.PubLink;
import com.rootrip.platform.common.dao.Page;
import com.rootrip.platform.genericdao.search.Filter;
import com.rootrip.platform.genericdao.search.Search;
import com.rootrip.platform.util.EntityUtil;

@Service
public class PubLinkService {
	
	@Autowired
	private PubLinkDao linkDao;

	@Transactional(readOnly = true)
	public List<PubLink> findByKey(Map<String, String[]> paramMap, Page page) {
		Search search = new Search().addSortDesc("bySort").setPagination(page);
		if(paramMap != null && paramMap.containsKey("key") && paramMap.get("key").length > 0) {
			String key = paramMap.get("key")[0];
			search.addFilter(Filter.like("title", "%" + key + "%"));
		}
		return linkDao.search(search);
	}

	@Transactional
	public void saveLink(PubLink link) {
		if(EntityUtil.isCreate(link)) {
			link.setAddTime(new Date());
		}
		linkDao.save(link);
	}

	@Transactional
	public void deleteLink(PubLink link) {
		linkDao.delete(link);
	}

	@Transactional
	public void save(PubLink link) {
		linkDao.save(link);
	}

	@Transactional(readOnly = true)
	public PubLink get(Long linkId) {
		return linkDao.get(linkId);
	}
}
