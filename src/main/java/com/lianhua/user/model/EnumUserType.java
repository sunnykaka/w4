package com.lianhua.user.model;


/**
 * 
 * @author liubin
 *
 */
public enum EnumUserType {

	/**
	 * 企业
	 */
	ENTERPRISE(0),
	
	/**
	 * 区管理人员
	 */
	COUNTY_MANAGER(1),
	
	/**
	 * 市管理人员
	 */
	CITY_MANAGER(2);
	
	public Byte value;
	
	EnumUserType(int value) {
		this.value = (byte)value;
	}
	
	/**
	 * 根据值取枚举
	 * @param value
	 * @return
	 */
	public static EnumUserType valueOf(Integer value) {
		if(value == null) {
			return null;
		}
		for(EnumUserType enumValue : values()) {
			if(value.intValue() == enumValue.value.intValue()) {
				return enumValue;
			}
		}
		return null;
	}
}
