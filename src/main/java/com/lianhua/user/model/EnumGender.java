package com.lianhua.user.model;


/**
 * 
 * @author liubin
 *
 */
public enum EnumGender {

	/**
	 * 男性
	 */
	MALE(0),
	
	/**
	 * 女性
	 */
	FEMALE(1);
	
	public Byte value;
	
	EnumGender(int value) {
		this.value = (byte)value;
	}
	
	/**
	 * 根据值取枚举
	 * @param value
	 * @return
	 */
	public static EnumGender valueOf(Integer value) {
		if(value == null) {
			return null;
		}
		for(EnumGender enumValue : values()) {
			if(value.intValue() == enumValue.value.intValue()) {
				return enumValue;
			}
		}
		return null;
	}
}
