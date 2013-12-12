package com.lianhua.declaration.model;


/**
 * 
 * @author liubin
 *
 */
public enum EnumApprovalStep {

	/**
	 * 企业填报
	 */
	ENTERPRISE_COMMIT(0, "企业填报"),
	
	/**
	 * 区审核
	 */
	COUNTY_APPROVE(1, "区审核"),
	
	/**
	 * 市审核
	 */
	CITY_APPROVE(2, "市审核");
	
	public Byte value;
	public String label;
	
	EnumApprovalStep(int value, String label) {
		this.value = (byte)value;
		this.label = label;
	}
	
	/**
	 * 根据值取枚举
	 * @param value
	 * @return
	 */
	public static EnumApprovalStep valueOf(Integer value) {
		if(value == null) {
			return null;
		}
		for(EnumApprovalStep enumValue : values()) {
			if(value.intValue() == enumValue.value.intValue()) {
				return enumValue;
			}
		}
		return null;
	}
}
