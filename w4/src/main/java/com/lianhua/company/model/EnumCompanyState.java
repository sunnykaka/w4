package com.lianhua.company.model;


/**
 * 
 * @author liubin
 *
 */
public enum EnumCompanyState {

	/**
	 * 暂存
	 */
	TEMP(0),
	
	/**
	 * 正常
	 */
	NORMAL(1),
	
	/**
	 * 已删除
	 */
	DELETED(2);
	
	public Byte value;
	
	EnumCompanyState(int value) {
		this.value = (byte)value;
	}
	
	/**
	 * 根据值取枚举
	 * @param value
	 * @return
	 */
	public static EnumCompanyState valueOf(Byte value) {
		if(value == null) {
			return null;
		}
		for(EnumCompanyState enumValue : values()) {
			if(value.intValue() == enumValue.value.intValue()) {
				return enumValue;
			}
		}
		return null;
	}
}
