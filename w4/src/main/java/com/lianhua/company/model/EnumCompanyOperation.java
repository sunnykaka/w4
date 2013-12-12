package com.lianhua.company.model;


/**
 * 
 * @author liubin
 *
 */
public enum EnumCompanyOperation {

	/**
	 * 新建
	 */
	NEW(0),
	
	/**
	 * 修改
	 */
	UPDATE(1),
	
	/**
	 * 删除
	 */
	DELETE(2);
	
	public Byte value;
	
	EnumCompanyOperation(int value) {
		this.value = (byte)value;
	}
	
	/**
	 * 根据值取枚举
	 * @param value
	 * @return
	 */
	public static EnumCompanyOperation valueOf(Integer value) {
		if(value == null) {
			return null;
		}
		for(EnumCompanyOperation enumValue : values()) {
			if(value.intValue() == enumValue.value.intValue()) {
				return enumValue;
			}
		}
		return null;
	}
}
