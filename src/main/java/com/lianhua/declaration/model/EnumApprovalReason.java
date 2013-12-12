package com.lianhua.declaration.model;


/**
 * 
 * @author liubin
 *
 */
public enum EnumApprovalReason {

	/**
	 * 企业入库
	 */
	ENTERPRISE_INPUT(0, "企业入库"),
	
	/**
	 * 删除企业
	 */
	ENTERPRISE_DELETE(1, "删除企业");
	
	public Byte value;
	public String label;
	
	EnumApprovalReason(int value, String label) {
		this.value = (byte)value;
		this.label = label;
	}
	
	/**
	 * 根据值取枚举
	 * @param value
	 * @return
	 */
	public static EnumApprovalReason valueOf(Integer value) {
		if(value == null) {
			return null;
		}
		for(EnumApprovalReason enumValue : values()) {
			if(value.intValue() == enumValue.value.intValue()) {
				return enumValue;
			}
		}
		return null;
	}
}
