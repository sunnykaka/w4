package com.lianhua.file.attach.model;

// Generated 2012-11-3 16:12:19 by Hibernate Tools 3.6.0

import java.util.Date;

/**
 * PubFile generated by hbm2java
 */
public class PubFile implements java.io.Serializable,
		com.rootrip.platform.common.dao.Entity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Long id;
	private String suffix;
	private String name;
	private String tableName;
	private Long tableId;
	private String filePath;
	private Date addTime;
	private Byte purpose;

	public String getSuffix() {
		return this.suffix;
	}

	public void setSuffix(String suffix) {
		this.suffix = suffix;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTableName() {
		return this.tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public Long getTableId() {
		return this.tableId;
	}

	public void setTableId(Long tableId) {
		this.tableId = tableId;
	}

	public String getFilePath() {
		return this.filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Date getAddTime() {
		return this.addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public Byte getPurpose() {
		return this.purpose;
	}

	public void setPurpose(Byte purpose) {
		this.purpose = purpose;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
