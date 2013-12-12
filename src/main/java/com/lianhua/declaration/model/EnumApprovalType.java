package com.lianhua.declaration.model;


/**
 * 
 * @author liubin
 *
 */
public enum EnumApprovalType {

	/**
	 * 企业审批
	 */
	COMPANY(0),
	
	/**
	 * 直报审批
	 */
	DECLARATION(1);
	
	public Byte value;
	
	EnumApprovalType(int value) {
		this.value = (byte)value;
	}
	
	/**
	 * 根据值取枚举
	 * @param value
	 * @return
	 */
	public static EnumApprovalType valueOf(Integer value) {
		if(value == null) {
			return null;
		}
		for(EnumApprovalType enumValue : values()) {
			if(value.intValue() == enumValue.value.intValue()) {
				return enumValue;
			}
		}
		return null;
	}
}
