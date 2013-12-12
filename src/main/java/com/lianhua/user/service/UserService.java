package com.lianhua.user.service;

import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lianhua.W4Application;
import com.lianhua.common.Constants;
import com.lianhua.common.web.WebHolder;
import com.lianhua.company.model.Company;
import com.lianhua.company.service.CompanyService;
import com.lianhua.permission.model.Permission;
import com.lianhua.permission.service.PermissionService;
import com.lianhua.permission.service.RoleService;
import com.lianhua.permission.util.PermissionUtil;
import com.lianhua.user.dao.UserDao;
import com.lianhua.user.model.EnumUserState;
import com.lianhua.user.model.EnumUserType;
import com.lianhua.user.model.User;
import com.rootrip.platform.Platform;
import com.rootrip.platform.common.dao.Page;
import com.rootrip.platform.exception.AppException;
import com.rootrip.platform.genericdao.search.Filter;
import com.rootrip.platform.genericdao.search.Search;
import com.rootrip.platform.util.Encrypter;
import com.rootrip.platform.util.EntityUtil;
import com.rootrip.platform.util.MD5Encoder;

@Service
public class UserService {
	
	protected final Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private PermissionService permissionService;
	
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private CompanyService companyService;
	
	private W4Application app = (W4Application)Platform.getInstance().getApp();

	/**
	 * 根据用户名查找用户,只适用于权限文件里的admin这个用户名
	 * @param username
	 * @return
	 */
	@Transactional(readOnly = true)
	public User getByUsername(String username) {
		return userDao.searchUnique(new Search().addFilter(Filter.equal("username", username)));
	}
	
	/**
	 * 根据用户名查找用户,只适用于权限文件里的admin这个用户名
	 * @param username
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<User> findByUsername(String username) {
		return userDao.search(new Search().addFilter(Filter.equal("username", username)));
	}

	@Transactional
	public void save(User user) {
		userDao.save(user);
	}

	@Transactional(readOnly = true)
	public User get(Long userId) {
		return userDao.get(userId);
	}
	
	/**
	 * 修改密码
	 * @param user
	 * @param oldPssword
	 * @param newPassword
	 * @return
	 */
	@Transactional
	public boolean changePassword(User user, String oldPassword, String newPassword) {
		if(user == null) return false;
		if(!user.getPassword().equals(MD5Encoder.encode(oldPassword))) return false;
		user.setPassword(MD5Encoder.encode(newPassword));
		userDao.save(user);
		return true;
	}
	
	/**
	 * 用cookie登录
	 * @param request
	 * @return
	 */
	@Transactional
	public User loginByCookie(HttpServletRequest request) {
		User user = null;
		int expires = 1209600;	//14天
		//尝试通过cookie登录
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			String userCookie = "";
			for(int i=0; i<cookies.length; i++) {
				Cookie c = cookies[i];
				if("w4userlogin".equals(c.getName())) {
					userCookie = c.getValue();
				}
			}
			if(userCookie != null && !"".equals(userCookie)) {
				try {
					String rootripuserlogin = Encrypter.decipher(URLDecoder.decode(userCookie, "UTF-8"));
					String[] login = rootripuserlogin.split(",");
					if (Math.abs((new Date().getTime() - Long.parseLong(login[0]))) < (expires * 1000L)) {
						String passport = login[1];
						String password = login[2];
						if(!StringUtils.isBlank(passport) && !StringUtils.isBlank(password)) {
							try {
								user = login(passport, password);
							} catch (AppException e) {
								log.warn(e.getMessage(), e);
							}
						}
					}
				} catch (Exception e) {
					log.error("cookie解密失败!", e);
				}
			}
		}
		return user;
	}
	
	/**
	 * 用户登录
	 * @param username
	 * @param password
	 * @throws AppException
	 */
	@Transactional
	public User login(String username, String password) throws AppException {
		User user = null;
		List<User> users = findByUsername(username);
		if(users.size() == 1 && !EnumUserType.ENTERPRISE.value.equals(users.get(0).getType())) {
			//尝试管理员登录
			user = users.get(0);
		} else {
			//尝试企业用户登录
			if(!users.isEmpty()) {
				int currentYear = app.getCurrentDeclarationYear();
				for(User u : users) {
					if(u.getYear().equals(currentYear)) {
						user = u;
					}
				}
			}
			if(user == null) {
				//根据组织机构代码查找对应user
				Company company = companyService.getByCodeAndYear(username, app.getCurrentDeclarationYear());
				if(company != null) {
					user = get(company.getUserId());
				}
			}
		}
		if(user == null) {
			throw new AppException("该帐号不存在");
		}
		if(!user.getPassword().equals(MD5Encoder.encode(password))) {
			throw new AppException("密码错误,请重新输入");
		}
		if(!EnumUserState.NORMAL.value.equals(user.getState())) {
			throw new AppException("登录失败,该帐号已被禁止登录");
		}
		user.setLastLoginTime(new Date());
		userDao.save(user);
		user.initialize();
		Set<Permission> permissions = user.getRole().getPermissions();
		user.buildPermissionsCache(permissions);
		user.setCurrentYear(app.getCurrentDeclarationYear());
		
		return user;
	}

	@Transactional(readOnly = true)
	public List<User> findByRole(Long roleId) {
		return userDao.findByRole(roleId);
	}

	/**
	 * 根据企业生成用户
	 * @param company
	 * @param year 
	 * @return
	 * @throws AppException 
	 */
	@Transactional
	public User createUser(Company company, Integer year) throws AppException {
		User user = new User();
		if(isUsernameExist(company.getCode(), null, year)) {
			throw new AppException("用户创建失败,组织机构代码对应的用户名已存在, 组织机构代码:" + company.getCode());
		}
		//TODO 如果组织机构代码code已经有对应的user了.两种解决办法
		//	1.抛出code重复异常
		//	2.将该company绑定到code所对应的user上去而不要重新创建
		user.setUsername(company.getCode());
		user.setName(company.getName());
		WebHolder.fillOperatorValues(user);
		user.setPassword(MD5Encoder.encode(Constants.DEFAULT_USER_PASSWORD));
		user.setType(EnumUserType.ENTERPRISE.value);
		user.setState(EnumUserState.NORMAL.value);
		user.setRoleId(roleService.getEnterpriseRole().getId());
		user.setAreaId(company.getContact().getCountyId());
		user.setYear(year);
		userDao.save(user);
		return user;
	}

	@Transactional(readOnly = true)
	public List<User> findByKey(Map<String, String[]> paramMap, Page page) {
		Search search = new Search().addSortDesc("operator.addTime").setPagination(page);
		//区管理员只能查看自己区的数据
		if(PermissionUtil.isCountyManager()) {
			search.addFilter(Filter.equal("areaId", WebHolder.getUser().getAreaId()));
		}
		//管理员列出所有,用户只列当年的
		search.addFilter(Filter.or(Filter.isNull("year"), Filter.equal("year", WebHolder.getUser().getCurrentYear())));
				
		if(paramMap.containsKey("codeOrName") && paramMap.get("codeOrName").length > 0) {
			String codeOrName = paramMap.get("codeOrName")[0];
			if(!StringUtils.isBlank(codeOrName)) {
				search.addFilter(Filter.like("username", "%" + codeOrName + "%"));
			}
		}
		if(paramMap.containsKey("state") && paramMap.get("state").length > 0) {
			String state = paramMap.get("state")[0];
			search.addFilter(Filter.equal("state", Integer.parseInt(state)));
		} else {
			search.addFilter(Filter.equal("state", EnumUserState.NORMAL.value.intValue()));
		}
//		if(paramMap.containsKey("type") && paramMap.get("type").length > 0) {
//			String type = paramMap.get("type")[0];
//			if(!"-1".equals(type)) {
//				search.addFilter(Filter.equal("type", Integer.parseInt(type)));
//			}
//		}
		if(PermissionUtil.isCityManager()) {
			if(paramMap.containsKey("type") && paramMap.get("type").length > 0) {
				String type = paramMap.get("type")[0];
				if(!"-1".equals(type)) {
					search.addFilter(Filter.equal("type", Integer.parseInt(type)));
				}
			}
		} else {
			search.addFilter(Filter.equal("type", EnumUserType.ENTERPRISE.value));
		}
		if(paramMap.containsKey("countyId") && paramMap.get("countyId").length > 0) {
			String county = paramMap.get("countyId")[0];
			if(!"-1".equals(county)) {
				search.addFilter(Filter.equal("areaId", Long.parseLong(county)));
			}
		}
		return userDao.search(search);
	}

	/**
	 * 判断用户名是否存在,创建企业用户的时候使用,不同直报年度用户名可以一样
	 * @param username
	 * @param userId
	 * @param year
	 * @return
	 */
	@Transactional(readOnly = true)
	public boolean isUsernameExist(String username, Long userId, Integer year) {
		List<User> users = userDao.search(new Search()
			.addFilter(Filter.equal("username", username))
			.addFilter(Filter.notEqual("id", userId)));
		if(users.isEmpty()) return false;
		for(User user : users) {
			if(user.getYear() == null) {
				//有非管理员使用了该帐号
				return true;
			} else {
				if(user.getYear().equals(year)) {
					return true;
				}
			}
		}
		return false;
	}
	
	/**
	 * 判断用户名是否存在,创建管理员的时候使用,管理员的用户名必须唯一,即使直报年度不同也不行
	 * @param username
	 * @param userId
	 * @param year
	 * @return
	 */
	@Transactional(readOnly = true)
	public boolean isAdminUsernameExist(String username, Long userId) {
		List<User> users = userDao.search(new Search()
			.addFilter(Filter.equal("username", username))
			.addFilter(Filter.notEqual("id", userId)));
		return !users.isEmpty();
	}
	
	/**
	 * 只保存管理员,不新增企业用户
	 * @param user
	 * @param newPassword
	 */
	@Transactional
	public void saveUser(User user, String newPassword) {
		
		if(!StringUtils.isBlank(newPassword)) {
			user.setPassword(MD5Encoder.encode(newPassword));
		} else if(EntityUtil.isCreate(user)) {
			user.setPassword(MD5Encoder.encode(Constants.DEFAULT_USER_PASSWORD));
		}
		if(EntityUtil.isCreate(user)) {
			user.setState(EnumUserState.NORMAL.value);
		}
		WebHolder.fillOperatorValues(user);
		if(user.getType().equals(EnumUserType.ENTERPRISE.value)) {
			user.setRoleId(roleService.getEnterpriseRole().getId());
		} else if(user.getType().equals(EnumUserType.COUNTY_MANAGER.value)) {
			user.setRoleId(roleService.getCountyManagerRole().getId());
		} else if(user.getType().equals(EnumUserType.CITY_MANAGER.value)) {
			user.setRoleId(roleService.getCityManagerRole().getId());
		}
		userDao.save(user);
	}

	@Transactional
	public void changeState(User user) {
		if(user.getState().equals(EnumUserState.NORMAL.value)) {
			user.setState(EnumUserState.FROZEN.value);
		} else {
			user.setState(EnumUserState.NORMAL.value);
		}
		userDao.save(user);
	}
	
}
