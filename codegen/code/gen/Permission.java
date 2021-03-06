package code.gen;

// Generated 2013-7-18 10:23:07 by Hibernate Tools 3.6.0

import java.util.HashSet;
import java.util.Set;

/**
 * Permission generated by hbm2java
 */
public class Permission implements java.io.Serializable,
		com.rootrip.platform.common.dao.Entity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private long id;
	private Resource resource;
	private Operation operation;
	private Set<RolePermission> rolePermissions = new HashSet<RolePermission>(0);

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Resource getResource() {
		return this.resource;
	}

	public void setResource(Resource resource) {
		this.resource = resource;
	}

	public Operation getOperation() {
		return this.operation;
	}

	public void setOperation(Operation operation) {
		this.operation = operation;
	}

	public Set<RolePermission> getRolePermissions() {
		return this.rolePermissions;
	}

	public void setRolePermissions(Set<RolePermission> rolePermissions) {
		this.rolePermissions = rolePermissions;
	}

}
