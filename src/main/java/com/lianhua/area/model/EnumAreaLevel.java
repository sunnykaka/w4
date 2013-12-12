package com.lianhua.area.model;


/**
 * 
 * @author liubin
 *
 */
public enum EnumAreaLevel {

	/**
	 * 占位而已,无意义
	 */
	NONE(0),
	
	/**
	 * 省级
	 */
	PROVINCE(1),
	
	/**
	 * 地级
	 */
	CITY(2),
	
	/**
	 * 县级
	 */
	COUNTY(3),
	
	/**
	 * 乡级
	 */
	VILLAGE(4);
	
	public Byte value;
	
	EnumAreaLevel(int value) {
		this.value = (byte)value;
	}
	
	/**
	 * 根据值取枚举
	 * @param value
	 * @return
	 */
	public static EnumAreaLevel valueOf(Integer value) {
		if(value == null) {
			return null;
		}
		for(EnumAreaLevel enumValue : values()) {
			if(value.intValue() == enumValue.value.intValue()) {
				return enumValue;
			}
		}
		return null;
	}
}
