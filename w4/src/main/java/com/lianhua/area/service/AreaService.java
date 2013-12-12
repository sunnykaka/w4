package com.lianhua.area.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lianhua.area.dao.AreaDao;
import com.lianhua.area.model.Area;
import com.lianhua.permission.util.PermissionUtil;
import com.lianhua.user.model.User;
import com.rootrip.platform.exception.PlatformException;
import com.rootrip.platform.genericdao.search.Search;
import com.rootrip.platform.mapper.JsonMapper;

@Service
public class AreaService {
	
	protected final Logger log = LoggerFactory.getLogger(this.getClass());
	
	// 区域缓存Map<id, 区域对象>
	private Map<Long, Area> buffer = null;
	
	public static final String AREA_KEY = "com.lianhua.code.Code";

	@Autowired
	private AreaDao areaDao;

	@Transactional(readOnly = true)
	public synchronized void load() {
		List<Area> areas = areaDao.search(new Search().addSortAsc("id"));
		Map<Long, Area> tempIdBuffer = new TreeMap<>();
		for (Area area : areas) {
			Area cacheArea = (Area)area.clone();
			tempIdBuffer.put(cacheArea.getId(), cacheArea);
		}
		//初始化area的树状关系
		for(Map.Entry<Long, Area> entry : tempIdBuffer.entrySet()) {
			Area area = entry.getValue();
			if(area.getParentId() == null) continue;
			Area parent = tempIdBuffer.get(area.getParentId());
			if(parent == null) {
				throw new PlatformException(String.format("初始化area的时候,根据parentId找不到对应的area,当前area[%d], 不存在的parentId[%d]", area.getId(), area.getParentId()));
			}
			area.setParent(parent);
			List<Area> children = parent.getChildren();
			if(children == null) {
				children = new ArrayList<>();
				parent.setChildren(children);
			}
			children.add(area);
		}
		buffer = tempIdBuffer;
	}
	
	/**
	 * 根据名称从缓存中搜索区域
	 * @param name
	 * @return
	 */
	public Area getByName(String name) {
		if(buffer == null) return null;
		for(Map.Entry<Long, Area> entry : buffer.entrySet()) {
			Area area = entry.getValue();
			if(area.getName().equals(name)) {
				return area;
			}
		}
		return null;
	}
	
	/**
	 * 得到对应区域以及子区域(不包括子区域的子区域),区管理员只能看见自己的区,json格式
	 * @param name
	 * @param user 
	 * @return
	 */
	public String getAreaInJson(String name, User user) {
		Area area = getByName(name);
		List<Map<String, Object>> roots = new ArrayList<>();
		if(user != null) {
			Map<String, Object> result = handleArea(area, 1, user);
			if(!result.isEmpty()) {
				roots.add(result);
			}
		}
		JsonMapper mapper = JsonMapper.nonEmptyMapper();
		return mapper.toJson(roots);
	}

	private Map<String, Object> handleArea(Area area, int depth, User user) {
		Map<String, Object> node = new HashMap<>();
		if(depth == 1) {
			node.put("nocheck", true);
			node.put("open", true);
		} else if(depth == 2) {
			//depth=2为各县区,此时判断如果是区管理员,则只能查看自己的区
			if(!PermissionUtil.isCityManager(user)) {
				if(!area.getId().equals(user.getAreaId())) {
					return node;
				}
			}
		}
		node.put("id", area.getId());
		node.put("name", area.getName());
		node.put("aLevel", depth);
		
		if(area.getChildren() != null && !area.getChildren().isEmpty()) {
			List<Map<String, Object>> children = new ArrayList<>();
			for(Area child : area.getChildren()) {
				Map<String, Object> result = handleArea(child, depth+1, user);
				if(!result.isEmpty()) {
					children.add(result);
				}
			}
			node.put("children", children);
		}
		return node;
	}

	public Map<Long, Area> getBuffer() {
		return buffer;
	}

	/**
	 * 根据id从缓存中搜索区域
	 * @param areaId
	 * @return
	 */
	public Area getById(Long areaId) {
		return buffer.get(areaId);
	}
}
