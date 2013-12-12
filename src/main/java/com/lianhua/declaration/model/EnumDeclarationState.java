package com.lianhua.declaration.model;


/**
 * 
 * @author liubin
 *
 */
public enum EnumDeclarationState {

	/**
	 * 未报
	 */
	UNCOMMIT(0, "未报"),
	
	/**
	 * 待审核
	 */
	APPROVING(1, "待审核"),
	
	/**
	 * 待区审核
	 */
	COUNTY_APPROVING(2, "待区审核"),
	
	/**
	 * 已审核
	 */
	APPROVED(3, "已审核"),
	
	/**
	 * 退回
	 */
	BACK(4, "退回"),
	
	/**
	 * 取消填报(企业不配合)
	 */
	CANCELD_R1(5, "取消填报(企业不配合)"),
	
	/**
	 * 取消填报(已停业/注销)
	 */
	CANCELD_R2(6, "取消填报(已停业/注销)"),
	
	/**
	 * 取消填报(无法联系)
	 */
	CANCELD_R3(7, "取消填报(无法联系)"),
	
	/**
	 * 取消填报(非体育产业)
	 */
	CANCELD_R4(8, "取消填报(非体育产业)");
	
	public Byte value;
	public String label;
	
	EnumDeclarationState(int value, String label) {
		this.value = (byte)value;
		this.label = label;
	}
	
	/**
	 * 根据值取枚举
	 * @param value
	 * @return
	 */
	public static EnumDeclarationState valueOf(Byte value) {
		if(value == null) {
			return null;
		}
		for(EnumDeclarationState enumValue : values()) {
			if(value.intValue() == enumValue.value.intValue()) {
				return enumValue;
			}
		}
		return null;
	}
}
