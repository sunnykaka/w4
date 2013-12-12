package com.lianhua.permission.util;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.lianhua.common.web.WebHolder;
import com.lianhua.permission.model.Permission;
import com.lianhua.user.model.EnumUserType;
import com.lianhua.user.model.User;

public class PermissionUtil {
	
	/**
	 * 检查权限
	 * @param user
	 * @param url
	 * @return
	 */
	public static boolean isPermitted(User user, String url) {
		if(user == null || StringUtils.isBlank(url)) return false;
		if(user.getRole().getAdmin()) return true;
		Map<String, Permission> permissionsCache = user.getPermissionsCache();
		if(permissionsCache != null) {
			if(permissionsCache.get(url) != null) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 当前登录用户是不是企业用户
	 * @return
	 */
	public static boolean isEnterprise() {
		return isSpecUserType(EnumUserType.ENTERPRISE, null);
	}
	
	/**
	 * 当前登录用户是不是企业用户
	 * @return
	 */
	public static boolean isEnterprise(User user) {
		return isSpecUserType(EnumUserType.ENTERPRISE, user);
	}
	
	/**
	 * 当前登录用户是不是市管理员
	 * @return
	 */
	public static boolean isCityManager() {
		return isSpecUserType(EnumUserType.CITY_MANAGER, null);
	}
	
	/**
	 * 当前登录用户是不是市管理员
	 * @return
	 */
	public static boolean isCityManager(User user) {
		return isSpecUserType(EnumUserType.CITY_MANAGER, user);
	}
	
	/**
	 * 当前登录用户是不是区管理员
	 * @return
	 */
	public static boolean isCountyManager() {
		return isSpecUserType(EnumUserType.COUNTY_MANAGER, null);
	}
	
	/**
	 * 当前登录用户是不是区管理员
	 * @return
	 */
	public static boolean isCountyManager(User user) {
		return isSpecUserType(EnumUserType.COUNTY_MANAGER, user);
	}

	
	private static boolean isSpecUserType(EnumUserType userType, User user) {
		if(user == null) {
			user = WebHolder.getUser();
		}
		if(user == null) return false;
		return userType.value.equals(user.getType());
	}
}
