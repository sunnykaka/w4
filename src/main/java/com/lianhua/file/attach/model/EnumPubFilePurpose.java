package com.lianhua.file.attach.model;


/**
 * 
 * @author liubin
 *
 */
public enum EnumPubFilePurpose {

	/**
	 * 附件
	 */
	ATTACH(0),
	
	/**
	 * 图片
	 */
	IMAGE(1),
	
	/**
	 * 索引图片
	 */
	INDEX_IMAGE(2), 
	
	/**
	 * 文本编辑器使用的图片
	 */
	TEXT_EDITOR_IMAGE(3),
	
	/**
	 * 用户头像
	 */
	USER_AVATAR(4);
	
	public Byte value;
	
	EnumPubFilePurpose(int value) {
		this.value = (byte)value;
	}
	
	/**
	 * 根据值取枚举
	 * @param value
	 * @return
	 */
	public static EnumPubFilePurpose valueOf(Integer value) {
		if(value == null) {
			return null;
		}
		for(EnumPubFilePurpose enumValue : values()) {
			if(value.intValue() == enumValue.value.intValue()) {
				return enumValue;
			}
		}
		return null;
	}
}
