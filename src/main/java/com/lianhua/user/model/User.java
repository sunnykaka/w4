package com.lianhua.user.model;

// Generated 2013-3-11 16:58:30 by Hibernate Tools 3.6.0

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import javax.validation.constraints.Pattern.Flag;

import org.hibernate.Hibernate;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;

import com.lianhua.area.model.Area;
import com.lianhua.common.model.BusinessData;
import com.lianhua.common.model.Operator;
import com.lianhua.permission.model.Permission;
import com.lianhua.permission.model.Role;

/**
 * Employee generated by hbm2java
 */
public class User implements java.io.Serializable,
		com.rootrip.platform.common.dao.Entity<Long>, BusinessData, Cloneable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public static final String SESSION_KEY = "com.lianhua.user.model.User";

	private Long id;
	@NotBlank
	@Pattern(regexp="^[\\u4e00-\\u9fa5\\w]{3,32}$", flags={Flag.CASE_INSENSITIVE})
	private String username;
	private String password;
	private String name;
	private Byte gender;
	private String card;
	@Email
	@Size(max=50)
	private String email;
	private String mobile;
	private Byte state;
	private String description;
	private String title;
	private Date lastLoginTime;
	private Byte type;
	private Integer year;
	
	private Operator operator;
	private Long roleId;
	private Role role;
	private Long areaId;
	private Area area;
	
	//用户拥有的权限缓存,key为url,value为Permission对象
	private Map<String, Permission> permissionsCache;
	
	private int currentYear;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCard() {
		return card;
	}

	public void setCard(String card) {
		this.card = card;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Byte getState() {
		return state;
	}

	public void setState(Byte state) {
		this.state = state;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public Byte getType() {
		return type;
	}

	public void setType(Byte type) {
		this.type = type;
	}

	public Operator getOperator() {
		return operator;
	}

	public void setOperator(Operator operator) {
		this.operator = operator;
	}

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	@Override
	public Object clone() {
		User user = new User();
		user.setId(getId());
		user.setUsername(getUsername());
		user.setPassword(getPassword());
		user.setCard(getCard());
		user.setDescription(getDescription());
		user.setEmail(getEmail());
		user.setMobile(getMobile());
		user.setName(getName());
		user.setOperator(getOperator());
		user.setArea(getArea());
		user.setAreaId(getAreaId());
		user.setRoleId(getRoleId());
		user.setRole(getRole());
		user.setGender(getGender());
		user.setState(getState());
		user.setTitle(getTitle());
		user.setLastLoginTime(getLastLoginTime());
		user.setType(getType());
		return user;
	}

	public Byte getGender() {
		return gender;
	}

	public void setGender(Byte gender) {
		this.gender = gender;
	}

	public Map<String, Permission> getPermissionsCache() {
		return permissionsCache;
	}

	/**
	 * 设置用户拥有的权限缓存
	 * @param permissions
	 */
	public void buildPermissionsCache(Set<Permission> permissions) {
		Map<String, Permission> permissionsCache = new HashMap<>();
		for(Permission p : permissions) {
			permissionsCache.put(p.getOperation().getUrl(), p);
		}
		this.permissionsCache = permissionsCache;
	}

	public Long getAreaId() {
		return areaId;
	}

	public void setAreaId(Long areaId) {
		this.areaId = areaId;
	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	public void initialize() {
		Hibernate.initialize(this.getArea());
		Hibernate.initialize(this.getRole());
		Hibernate.initialize(this.getOperator());
	}

	public int getCurrentYear() {
		return currentYear;
	}

	public void setCurrentYear(int currentYear) {
		this.currentYear = currentYear;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}
}
