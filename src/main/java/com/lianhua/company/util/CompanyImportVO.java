package com.lianhua.company.util;

/**
 * 
 * @author liubin
 *
 */
public class CompanyImportVO {

	private String code;
	private String name;
	private String principal;
	private String city;
	private String county;
	private String location;
	private String areaCode;
	private String phone;
	private String phoneExt;
	private String fax;
	private String email;
	private String zipCode;
	private String website;
	private String businessType;
	private String product1;
	private String product2;
	private String product3;
	private String category;
	private String register;
	private String accounting;
	private String organization;
	private String employeeNum;
	private String masterNum;
	private String bachelorNum;
	private String collegeNum;
	private String otherNum;
	private String majorInquiry;
	
	public static CompanyImportVO forRow(String[] cells) {
		CompanyImportVO vo = new CompanyImportVO();
		try {
			vo.code = cells[0];
			vo.name = cells[1];
			vo.principal = cells[2];
			vo.city = cells[3];
			vo.county = cells[4];
			vo.location = cells[5];
			vo.areaCode = cells[6];
			vo.phone = cells[7];
			vo.phone = cells[8];
			vo.fax = cells[9];
			vo.email = cells[10];
			vo.zipCode = cells[11];
			vo.website = cells[12];
			vo.businessType = cells[13];
			vo.product1 = cells[14];
			vo.product2 = cells[15];
			vo.product3 = cells[16];
			vo.category = cells[17];
			vo.register = cells[18];
			vo.accounting = cells[19];
			vo.organization = cells[20];
			vo.employeeNum = cells[21];
			vo.masterNum = cells[22];
			vo.bachelorNum = cells[23];
			vo.collegeNum = cells[24];
			vo.otherNum = cells[25];
			vo.majorInquiry = cells[26];
		} catch (ArrayIndexOutOfBoundsException ignore) {}
		return vo;
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
	public String getPrincipal() {
		return principal;
	}
	public void setPrincipal(String principal) {
		this.principal = principal;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCounty() {
		return county;
	}
	public void setCounty(String county) {
		this.county = county;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getBusinessType() {
		return businessType;
	}
	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}
	public String getProduct1() {
		return product1;
	}
	public void setProduct1(String product1) {
		this.product1 = product1;
	}
	public String getProduct2() {
		return product2;
	}
	public void setProduct2(String product2) {
		this.product2 = product2;
	}
	public String getProduct3() {
		return product3;
	}
	public void setProduct3(String product3) {
		this.product3 = product3;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getRegister() {
		return register;
	}
	public void setRegister(String register) {
		this.register = register;
	}
	public String getAccounting() {
		return accounting;
	}
	public void setAccounting(String accounting) {
		this.accounting = accounting;
	}
	public String getOrganization() {
		return organization;
	}
	public void setOrganization(String organization) {
		this.organization = organization;
	}
	public String getEmployeeNum() {
		return employeeNum;
	}
	public void setEmployeeNum(String employeeNum) {
		this.employeeNum = employeeNum;
	}
	public String getMasterNum() {
		return masterNum;
	}
	public void setMasterNum(String masterNum) {
		this.masterNum = masterNum;
	}
	public String getBachelorNum() {
		return bachelorNum;
	}
	public void setBachelorNum(String bachelorNum) {
		this.bachelorNum = bachelorNum;
	}
	public String getCollegeNum() {
		return collegeNum;
	}
	public void setCollegeNum(String collegeNum) {
		this.collegeNum = collegeNum;
	}
	public String getOtherNum() {
		return otherNum;
	}
	public void setOtherNum(String otherNum) {
		this.otherNum = otherNum;
	}
	public String getMajorInquiry() {
		return majorInquiry;
	}
	public void setMajorInquiry(String majorInquiry) {
		this.majorInquiry = majorInquiry;
	}

	public String getPhoneExt() {
		return phoneExt;
	}

	public void setPhoneExt(String phoneExt) {
		this.phoneExt = phoneExt;
	}
	
}
