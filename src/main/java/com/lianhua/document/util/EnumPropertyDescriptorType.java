package com.lianhua.document.util;


/**
 * 
 * @author liubin
 *
 */
public enum EnumPropertyDescriptorType {

	/**
	 * NULL
	 */
	NULL(0),
	
	/**
	 * String
	 */
	TEXT(1),
	
	/**
	 * 数据字典
	 */
	CODE_ID(2),
	
	/**
	 * 百分比
	 */
	PERCENT(3),
	
	/**
	 * 不显示的属性
	 */
	INVISIBLE(4);
	
	public Byte value;
	
	EnumPropertyDescriptorType(int value) {
		this.value = (byte)value;
	}
	
	/**
	 * 根据值取枚举
	 * @param value
	 * @return
	 */
	public static EnumPropertyDescriptorType valueOf(Integer value) {
		if(value == null) {
			return null;
		}
		for(EnumPropertyDescriptorType enumValue : values()) {
			if(value.intValue() == enumValue.value.intValue()) {
				return enumValue;
			}
		}
		return null;
	}
}
