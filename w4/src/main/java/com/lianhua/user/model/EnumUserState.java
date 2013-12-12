package com.lianhua.user.model;


/**
 * 
 * @author liubin
 *
 */
public enum EnumUserState {

	/**
	 * 正常
	 */
	NORMAL(0),
	
	/**
	 * 暂停
	 */
	FROZEN(1);
	
	public Byte value;
	
	EnumUserState(int value) {
		this.value = (byte)value;
	}
	
	/**
	 * 根据值取枚举
	 * @param value
	 * @return
	 */
	public static EnumUserState valueOf(Integer value) {
		if(value == null) {
			return null;
		}
		for(EnumUserState enumValue : values()) {
			if(value.intValue() == enumValue.value.intValue()) {
				return enumValue;
			}
		}
		return null;
	}
}
