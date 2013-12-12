package code.gen;

// Generated 2013-7-18 10:23:07 by Hibernate Tools 3.6.0

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Company generated by hbm2java
 */
public class Company implements java.io.Serializable,
		com.rootrip.platform.common.dao.Entity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private long id;
	private Contact contact;
	private User user;
	private String code;
	private String name;
	private String product1;
	private String product2;
	private String product3;
	private Long categoryCode;
	private Long registerCode;
	private Long accountingCode;
	private Long organizationCode;
	private Integer masterNum;
	private Integer bachelorNum;
	private Integer collegeNum;
	private Integer otherNum;
	private Integer employeeNum;
	private Long operatorId;
	private String principal;
	private String preparer;
	private String mobile;
	private Date signDate;
	private Byte approveState;
	private Byte state;
	private Byte operation;
	private Integer year;
	private boolean sample;
	private Long businessTypeCode;
	private boolean majorInquiry;
	private boolean confirmed;
	private Set<Approval> approvals = new HashSet<Approval>(0);
	private Set<Declaration> declarations = new HashSet<Declaration>(0);

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Contact getContact() {
		return this.contact;
	}

	public void setContact(Contact contact) {
		this.contact = contact;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
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

	public String getProduct1() {
		return this.product1;
	}

	public void setProduct1(String product1) {
		this.product1 = product1;
	}

	public String getProduct2() {
		return this.product2;
	}

	public void setProduct2(String product2) {
		this.product2 = product2;
	}

	public String getProduct3() {
		return this.product3;
	}

	public void setProduct3(String product3) {
		this.product3 = product3;
	}

	public Long getCategoryCode() {
		return this.categoryCode;
	}

	public void setCategoryCode(Long categoryCode) {
		this.categoryCode = categoryCode;
	}

	public Long getRegisterCode() {
		return this.registerCode;
	}

	public void setRegisterCode(Long registerCode) {
		this.registerCode = registerCode;
	}

	public Long getAccountingCode() {
		return this.accountingCode;
	}

	public void setAccountingCode(Long accountingCode) {
		this.accountingCode = accountingCode;
	}

	public Long getOrganizationCode() {
		return this.organizationCode;
	}

	public void setOrganizationCode(Long organizationCode) {
		this.organizationCode = organizationCode;
	}

	public Integer getMasterNum() {
		return this.masterNum;
	}

	public void setMasterNum(Integer masterNum) {
		this.masterNum = masterNum;
	}

	public Integer getBachelorNum() {
		return this.bachelorNum;
	}

	public void setBachelorNum(Integer bachelorNum) {
		this.bachelorNum = bachelorNum;
	}

	public Integer getCollegeNum() {
		return this.collegeNum;
	}

	public void setCollegeNum(Integer collegeNum) {
		this.collegeNum = collegeNum;
	}

	public Integer getOtherNum() {
		return this.otherNum;
	}

	public void setOtherNum(Integer otherNum) {
		this.otherNum = otherNum;
	}

	public Integer getEmployeeNum() {
		return this.employeeNum;
	}

	public void setEmployeeNum(Integer employeeNum) {
		this.employeeNum = employeeNum;
	}

	public Long getOperatorId() {
		return this.operatorId;
	}

	public void setOperatorId(Long operatorId) {
		this.operatorId = operatorId;
	}

	public String getPrincipal() {
		return this.principal;
	}

	public void setPrincipal(String principal) {
		this.principal = principal;
	}

	public String getPreparer() {
		return this.preparer;
	}

	public void setPreparer(String preparer) {
		this.preparer = preparer;
	}

	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Date getSignDate() {
		return this.signDate;
	}

	public void setSignDate(Date signDate) {
		this.signDate = signDate;
	}

	public Byte getApproveState() {
		return this.approveState;
	}

	public void setApproveState(Byte approveState) {
		this.approveState = approveState;
	}

	public Byte getState() {
		return this.state;
	}

	public void setState(Byte state) {
		this.state = state;
	}

	public Byte getOperation() {
		return this.operation;
	}

	public void setOperation(Byte operation) {
		this.operation = operation;
	}

	public Integer getYear() {
		return this.year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public boolean isSample() {
		return this.sample;
	}

	public void setSample(boolean sample) {
		this.sample = sample;
	}

	public Long getBusinessTypeCode() {
		return this.businessTypeCode;
	}

	public void setBusinessTypeCode(Long businessTypeCode) {
		this.businessTypeCode = businessTypeCode;
	}

	public boolean isMajorInquiry() {
		return this.majorInquiry;
	}

	public void setMajorInquiry(boolean majorInquiry) {
		this.majorInquiry = majorInquiry;
	}

	public boolean isConfirmed() {
		return this.confirmed;
	}

	public void setConfirmed(boolean confirmed) {
		this.confirmed = confirmed;
	}

	public Set<Approval> getApprovals() {
		return this.approvals;
	}

	public void setApprovals(Set<Approval> approvals) {
		this.approvals = approvals;
	}

	public Set<Declaration> getDeclarations() {
		return this.declarations;
	}

	public void setDeclarations(Set<Declaration> declarations) {
		this.declarations = declarations;
	}

}