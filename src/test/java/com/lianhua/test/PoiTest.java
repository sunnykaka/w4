package com.lianhua.test;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.junit.Ignore;
import org.junit.Test;

import com.lianhua.common.excel.ExcelReader;

public class PoiTest {

	@Test
	@Ignore
	public void test() throws IOException {
		String templates = "templates/test.xlsx";
		Workbook workbook = new XSSFWorkbook(Thread.currentThread().getContextClassLoader()
				.getResourceAsStream(templates));
		Sheet sheet = workbook.getSheetAt(0);
		for(Iterator<Row> rowIter = sheet.rowIterator(); rowIter.hasNext();) {
			Row row = rowIter.next();
			int rowNumber = row.getRowNum();
			if(rowNumber == 0) continue;
			for(Iterator<Cell> cellIter = row.cellIterator(); cellIter.hasNext();) {
				Cell cell = cellIter.next();
				int cellNumber = cell.getColumnIndex(); 
				CellReference cellRef = new CellReference(rowNumber, cellNumber);
	            System.out.print(cellRef.formatAsString());
	            System.out.print(" - ");

	            switch (cell.getCellType()) {
	                case Cell.CELL_TYPE_STRING:
	                    System.out.println(cell.getRichStringCellValue().getString());
	                    break;
	                case Cell.CELL_TYPE_NUMERIC:
	                    if (DateUtil.isCellDateFormatted(cell)) {
	                        System.out.println(cell.getDateCellValue());
	                    } else {
	                        System.out.println(cell.getNumericCellValue());
	                    }
	                    break;
	                case Cell.CELL_TYPE_BOOLEAN:
	                    System.out.println(cell.getBooleanCellValue());
	                    break;
	                case Cell.CELL_TYPE_FORMULA:
	                    System.out.println(cell.getCellFormula());
	                    break;
	                default:
	                    System.out.println();
	            }
			}
		}
	}
	
	@Test
	public void test2() throws IOException {
		String templates = "templates/test.xlsx";
		List<String[]> results = new ExcelReader().read(Thread.currentThread().getContextClassLoader()
				.getResourceAsStream(templates), 0, 0, 0);
		for(String[] rowData : results) {
			for (int i = 0; i < rowData.length; i++) {
				System.out.println(rowData[i]);
			}
			System.out.println("===================");
		}
	}
	
}
