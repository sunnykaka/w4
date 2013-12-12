package com.lianhua.declaration.model;


/**
 * 
 * @author liubin
 *
 */
public enum EnumApprovalState {

	/**
	 * 提交申报
	 */
	COMMIT(0, "提交申报"),
	
	/**
	 * 已审核
	 */
	APPROVED(1, "已审核"),
	
	/**
	 * 退回修改
	 */
	BACK(2, "退回修改"),
	
	/**
	 * 退回修改
	 */
	CANCEL(3, "撤回");
	
	public Byte value;
	public String label;
	
	EnumApprovalState(int value, String label) {
		this.value = (byte)value;
		this.label = label;
	}
	
	/**
	 * 根据值取枚举
	 * @param value
	 * @return
	 */
	public static EnumApprovalState valueOf(Integer value) {
		if(value == null) {
			return null;
		}
		for(EnumApprovalState enumValue : values()) {
			if(value.intValue() == enumValue.value.intValue()) {
				return enumValue;
			}
		}
		return null;
	}
}
