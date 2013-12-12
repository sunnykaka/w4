package com.lianhua.common.web.tag;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lianhua.area.model.Area;
import com.lianhua.area.model.EnumAreaLevel;
import com.lianhua.area.service.AreaService;
import com.rootrip.platform.Platform;

public class AreaInputTag extends SimpleTagSupport {
	
	protected final Logger log = LoggerFactory.getLogger(this.getClass());

	private String cityName = "cityId";
	
	private String countyName = "countyId";
	
	//选中的区id
	private String value;
	
	private AreaService areaService = Platform.getInstance().getBean(AreaService.class);
	
	//是不是用来当作搜索条件
	private String search = "false";
	
	/*
	 * (non-Javadoc)
	 * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
	 */
	@Override
	public void doTag() throws JspException, IOException {
		Map<Long, Area> areaMap = areaService.getBuffer();
		
		Area city = null;
		Area county = null;
		if(StringUtils.isNumeric(value) && !"-1".equals(value)) {
			county = areaMap.get(Long.parseLong(value));
			city = county.getParent();
		}
		//获取页面输出流
		Writer out = getJspContext().getOut();
		StringBuilder sb = new StringBuilder();
		List<Area> cities = new ArrayList<>();
		List<Area> counties = new ArrayList<>();
		for(Map.Entry<Long, Area> entry : areaMap.entrySet()) {
        	Area area = entry.getValue();
        	if(EnumAreaLevel.CITY.value.equals(area.getLevel())) {
        		cities.add(area);
        	} else if(EnumAreaLevel.COUNTY.value.equals(area.getLevel())) {
        		counties.add(area);
        	}
        }
        
		//市
		sb.append(String.format("<select name='%s'>", cityName));
        for(Area area : cities) {
        	String checked = "";
        	if(city != null) {
        		if(area.getId().equals(city.getId())) {
        			checked = "selected='selected'";
        		}
        	}
        	sb.append(String.format("<option value='%d' %s>%s</option>", area.getId(), checked, area.getName()));
        }
        sb.append("</select>");
        
        //县
        sb.append(String.format("<select name='%s'>", countyName));
        if("true".equalsIgnoreCase(search)) {
        	//当search为true的时候,加上全部这个条件
        	String checked = "";
        	if(StringUtils.isBlank(value) || "-1".equals(value)) {
        		checked = "selected='selected'";
        	}
        	sb.append(String.format("<option value='%d' %s>%s</option>", -1, checked, "全部"));
        }
        for(Area area : counties) {
        	String checked = "";
        	if(county != null) {
        		if(area.getId().equals(county.getId())) {
        			checked = "selected='selected'";
        		}
        	}
        	sb.append(String.format("<option value='%d' %s>%s</option>", area.getId(), checked, area.getName()));
        }
        sb.append("</select>");
        out.write(sb.toString());
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public String getCountyName() {
		return countyName;
	}

	public void setCountyName(String countyName) {
		this.countyName = countyName;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}


}