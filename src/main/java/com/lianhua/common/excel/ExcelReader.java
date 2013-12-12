package com.lianhua.common.excel;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ExcelReader {
	
	// 日志
	protected Logger log = LoggerFactory.getLogger(this.getClass());
	
	/**
	 * 读取内容
	 * @param in 输入流
	 * @param sheetIndex sheet的索引号
	 * @param startRow 开始行
	 * @param startCell 开始列
	 * @param cellCount 列数
	 * @throws IOException 
	 */
	public List<String[]> read(InputStream in, int sheetIndex, int startRow, int startCell, int cellCount) throws IOException {
		List<String[]> results = new ArrayList<>();
		Workbook workbook = new XSSFWorkbook(in);
		Sheet sheet = workbook.getSheetAt(sheetIndex);
		for(int i = startRow; i <= sheet.getLastRowNum(); i++) {
			String[] rowData = null;
			Row row = sheet.getRow(i);
			if(row != null) {
				int realCellCount = cellCount <= 0 ? row.getLastCellNum() : cellCount;
				rowData = new String[realCellCount];
				for(int j = startCell; j < startCell + realCellCount; j++) {
					int index = j - startCell;
					Cell cell = row.getCell(index);
					
					String content = "";
					if(cell != null) {
						switch (cell.getCellType()) {
						case Cell.CELL_TYPE_STRING:
							content = cell.getRichStringCellValue().getString();
							break;
						case Cell.CELL_TYPE_NUMERIC:
							if (DateUtil.isCellDateFormatted(cell)) {
								content = com.rootrip.platform.util.DateUtil.formatDate(cell.getDateCellValue(), "yyyy-MM-dd HH:mm:ss");
							} else {
								content = String.valueOf(cell.getNumericCellValue());
							}
							break;
						case Cell.CELL_TYPE_BOOLEAN:
							content = String.valueOf(cell.getBooleanCellValue());
							break;
						case Cell.CELL_TYPE_FORMULA:
							content = cell.getCellFormula();
							break;
						default:
						}
					}
					rowData[index] = content.trim();
				}
			}
			results.add(rowData);
		}
		return results;
	}
	
	/**
	 * 读取内容
	 * @param in 输入流
	 * @param sheetIndex sheet的索引号
	 * @param startRow 开始行
	 * @param startCell 开始列
	 * @throws IOException 
	 */
	public List<String[]> read(InputStream in, int sheetIndex, int startRow, int startCell) throws IOException {
		return read(in, sheetIndex, startRow, startCell, 0);
	}
}