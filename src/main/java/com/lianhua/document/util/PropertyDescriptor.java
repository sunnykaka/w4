package com.lianhua.document.util;

public class PropertyDescriptor {

	//属性名称
	private String name;
	
	//属性文本
	private String label;
	
	//属性类型
	private EnumPropertyDescriptorType type;
	
	//额外信息,如果type是2即数据字典的话,该值存放数据字典类型
	private String extroInfo;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public EnumPropertyDescriptorType getType() {
		return type;
	}

	public void setType(EnumPropertyDescriptorType type) {
		this.type = type;
	}

	public String getExtroInfo() {
		return extroInfo;
	}

	public void setExtroInfo(String extroInfo) {
		this.extroInfo = extroInfo;
	}

	/**
	 * 根据properties的一条内容构造元属性对象
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public static PropertyDescriptor forNameAndValue(String propertyName,
			String value) {
		PropertyDescriptor propertyDescriptor = new PropertyDescriptor();
		propertyDescriptor.name = propertyName;
		String[] values = value.split("~");
		if(values.length > 1) {
			//第二个字段为类型
			propertyDescriptor.type = EnumPropertyDescriptorType.valueOf(Integer.parseInt(values[1]));
			if(EnumPropertyDescriptorType.CODE_ID.equals(propertyDescriptor.type)) {
				propertyDescriptor.extroInfo = values[2];
			}
		} else {
			propertyDescriptor.type = EnumPropertyDescriptorType.TEXT;
		}
		propertyDescriptor.label = values[0];
		
		return propertyDescriptor;
	}
	
}
