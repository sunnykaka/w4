package com.lianhua.document.model;

// Generated 2013-3-27 13:37:50 by Hibernate Tools 3.6.0


/**
 * DocumentDescriptor generated by hbm2java
 */
public class DocumentDescriptor implements java.io.Serializable,
		com.rootrip.platform.common.dao.Entity<Long> {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	private Long id;
	private String code;
	private String name;
	private Integer year;
	private String drafter;
	private String approver;
	private String approvalNumber;
	private String validDate;
	private Long levelCode;
	private String units;
	private String surveyCategory;
	private boolean majorInquiry = false;

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
	public String getDrafter() {
		return drafter;
	}
	public void setDrafter(String drafter) {
		this.drafter = drafter;
	}
	public String getApprover() {
		return approver;
	}
	public void setApprover(String approver) {
		this.approver = approver;
	}
	public String getApprovalNumber() {
		return approvalNumber;
	}
	public void setApprovalNumber(String approvalNumber) {
		this.approvalNumber = approvalNumber;
	}
	public String getValidDate() {
		return validDate;
	}
	public void setValidDate(String validDate) {
		this.validDate = validDate;
	}
	public Long getLevelCode() {
		return levelCode;
	}
	public void setLevelCode(Long levelCode) {
		this.levelCode = levelCode;
	}
	public String getUnits() {
		return units;
	}
	public void setUnits(String units) {
		this.units = units;
	}
	public String getSurveyCategory() {
		return surveyCategory;
	}
	public void setSurveyCategory(String surveyCategory) {
		this.surveyCategory = surveyCategory;
	}
	public boolean isMajorInquiry() {
		return majorInquiry;
	}
	public void setMajorInquiry(boolean majorInquiry) {
		this.majorInquiry = majorInquiry;
	}

}
