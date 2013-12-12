package com.lianhua.company.model;


/**
 * 
 * @author liubin
 *
 */
public enum EnumCompanyApproveState {

	/**
	 * 未提交
	 */
	UNCOMMIT(0),
	
	/**
	 * 待审核
	 */
	APPROVING(1),
	
	/**
	 * 审核通过
	 */
	APPROVED(2),
	
	/**
	 * 已退回
	 */
	BACK(3);
	
	public Byte value;
	
	EnumCompanyApproveState(int value) {
		this.value = (byte)value;
	}
	
	/**
	 * 根据值取枚举
	 * @param value
	 * @return
	 */
	public static EnumCompanyApproveState valueOf(Byte value) {
		if(value == null) {
			return null;
		}
		for(EnumCompanyApproveState enumValue : values()) {
			if(value.intValue() == enumValue.value.intValue()) {
				return enumValue;
			}
		}
		return null;
	}
}
