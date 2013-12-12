package com.lianhua.test;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.lianhua.common.excel.ExcelReader;
import com.lianhua.company.model.Company;
import com.lianhua.company.util.CompanyImportVO;
import com.rootrip.platform.test.PlatformTest;

public class ReadExcelTest extends PlatformTest {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Test
	public void test() throws FileNotFoundException, IOException {
		String path = "C:\\Users\\liubin\\Desktop\\体育产业总库9207（7806）0820.xlsx";
		ExcelReader reader = new ExcelReader();
		List<String[]> datas = reader.read(new FileInputStream(path), 0, 0, 0);
		int count = 0;
		if(!datas.isEmpty()) {
			for (int i = 1; i < datas.size(); i++) {
				String[] cells = datas.get(i);
				if(cells == null || cells.length < 2 || StringUtils.isBlank(cells[0]) || StringUtils.isBlank(cells[1])) {
					continue;
				}
				count ++;
				if(count % 100 == 0) {
					System.out.println(count);
				}
				CompanyImportVO vo = CompanyImportVO.forRow(cells);
				if(!StringUtils.isBlank(vo.getAreaCode()) && vo.getAreaCode().length() > 4) {
					System.out.println(String.format("area code length %d:%s", vo.getAreaCode().length(), vo.getAreaCode()));
				}
			}
		}
		
	}
	
}
