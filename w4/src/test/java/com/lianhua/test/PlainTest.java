package com.lianhua.test;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.math.NumberUtils;
import org.junit.Test;

import com.rootrip.platform.mapper.JsonMapper;
import com.rootrip.platform.util.MathUtil;

public class PlainTest {

	@Test
	public void test() {
//		String path = "/102/123";
//		String[] paths = path.split("/");
//		for (int i = 0; i < paths.length; i++) {
//			System.out.println(paths[i]);
//		}
		
//		JsonMapper mapper = JsonMapper.nonEmptyMapper();
//		Map<String, Object> parent1 = new HashMap<>();
//		parent1.put("id", 1);
//		parent1.put("label", "体育");
//		parent1.put("level", 1);
//		
//		Map<String, Object> child1 = new HashMap<>();
//		child1.put("id", 2);
//		child1.put("label", "羽毛球");
//		child1.put("level", 2);
//		
//		Map<String, Object> child2 = new HashMap<>();
//		child2.put("id", 3);
//		child2.put("label", "乒乓球");
//		child2.put("level", 2);
//		
//		List<Map<String, Object>> children = new ArrayList<>();
//		children.add(child1);
//		children.add(child2);
//		parent1.put("children", children);
//		
//		Map<String, Object> parent2 = new HashMap<>();
//		parent2.put("id", 4);
//		parent2.put("label", "场馆");
//		parent2.put("level", 1);
//		
//		List<Map<String, Object>> roots = new ArrayList<>();
//		roots.add(parent1);
//		roots.add(parent2);
//		
//		System.out.println(mapper.toJson(roots));
		
//		String s = "你好_123";
//		String[] arr = s.split("_");
//		for (int i = 0; i < arr.length; i++) {
//			System.out.println(arr[i]);
//		}
//		
//		s = "你好~123";
//		arr = s.split("~");
//		for (int i = 0; i < arr.length; i++) {
//			System.out.println(arr[i]);
//		}
		
		String s = "121.2";
		System.out.println(NumberUtils.isDigits(s));
		System.out.println(NumberUtils.isNumber(s));
		
		BigDecimal b = new BigDecimal(s);
		System.out.println(b.setScale(2, RoundingMode.HALF_UP).toString());
		System.out.println(String.valueOf(MathUtil.round(Double.parseDouble(s), 2)));
	}
	
}
