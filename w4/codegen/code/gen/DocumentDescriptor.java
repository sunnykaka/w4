package code.gen;

// Generated 2013-7-18 10:23:07 by Hibernate Tools 3.6.0

import java.util.HashSet;
import java.util.Set;

/**
 * DocumentDescriptor generated by hbm2java
 */
public class DocumentDescriptor implements java.io.Serializable,
		com.rootrip.platform.common.dao.Entity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private long id;
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
	private boolean majorInquiry;
	private Set<Document> documents = new HashSet<Document>(0);

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getYear() {
		return this.year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public String getDrafter() {
		return this.drafter;
	}

	public void setDrafter(String drafter) {
		this.drafter = drafter;
	}

	public String getApprover() {
		return this.approver;
	}

	public void setApprover(String approver) {
		this.approver = approver;
	}

	public String getApprovalNumber() {
		return this.approvalNumber;
	}

	public void setApprovalNumber(String approvalNumber) {
		this.approvalNumber = approvalNumber;
	}

	public String getValidDate() {
		return this.validDate;
	}

	public void setValidDate(String validDate) {
		this.validDate = validDate;
	}

	public Long getLevelCode() {
		return this.levelCode;
	}

	public void setLevelCode(Long levelCode) {
		this.levelCode = levelCode;
	}

	public String getUnits() {
		return this.units;
	}

	public void setUnits(String units) {
		this.units = units;
	}

	public String getSurveyCategory() {
		return this.surveyCategory;
	}

	public void setSurveyCategory(String surveyCategory) {
		this.surveyCategory = surveyCategory;
	}

	public boolean isMajorInquiry() {
		return this.majorInquiry;
	}

	public void setMajorInquiry(boolean majorInquiry) {
		this.majorInquiry = majorInquiry;
	}

	public Set<Document> getDocuments() {
		return this.documents;
	}

	public void setDocuments(Set<Document> documents) {
		this.documents = documents;
	}

}