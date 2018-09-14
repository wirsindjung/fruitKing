	import java.io.*;
	import org.apache.poi.poifs.filesystem.POIFSFileSystem;
	import org.apache.poi.hssf.record.*;
	import org.apache.poi.hssf.model.*;
	import org.apache.poi.hssf.usermodel.*;
	import org.apache.poi.hssf.util.*;
	
public class aas{
	public aas(){
		 String excelFile = "C:\\공부\\한이음\\빅데이터\\ex.xls";		//excel파일의 경로와 파일명
			
		 try{
			 POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(excelFile)); 
			 //엑셀파일의 경로와 이름을 통해 POIFSFileSystem을 생성
				
			 //워크북을 생성!
			 HSSFWorkbook workbook = new HSSFWorkbook(fs);	//파일에 대한 워크북을 생성
			 int sheetNum = workbook.getNumberOfSheets();	//그파일의 워크시트의 수를 가져온다
			 
			 for(int k = 0;k < sheetNum; k++){	//시트를 돌면서 모든 데이터를 얻는다.
				
//				 System.out.println(k+1);						//시트 번호 콘솔에 출력
//				 System.out.println(workbook.getSheetName(k));	//시트의 이름을 콘솔에 출력
				 HSSFSheet sheet = workbook.getSheetAt(k);	 	//한개의 시트에대한 정보를 HSSFSheet형의 변수에 담는다.
				 int rows = sheet.getPhysicalNumberOfRows();	//시트별 몇개의 row가 있는지 알아낸다.
				 
				 for(int r= 0; r < rows; r++){			//시트에 대한 행을 하나씩 추출
					 HSSFRow row = sheet.getRow(r);		//한개의 시트에 몇개의 로우가 있는지 체크	
					 
					 if(row != null){	//로우가 비어있지않다면
						 int cells = row.getPhysicalNumberOfCells();	//한개의 로우마다 몇개의 cell이 있는지 체크
//						 System.out.print(row.getRowNum());		//row의 index를 콘솔에 출력
//						 System.out.println(cells);				//해당 row에 대한 cell의 갯수를 콘솔에 출력
						 
						 for(short c = 0; c < cells; c++){		//셀의 마지막까지 잡는다.
							 //행에대한 셀을 하나씩 추출하여 셀 타입에 따라 처리
							 HSSFCell cell = row.getCell(c);	//cell의 index
							 if(cell != null){
								 String value = null;
								 switch(cell.getCellType()){	//셀의 type에 대해 체크하고 type을 설정해준다.
								 case FORMULA:
									 value = cell.getCellFormula();
									 break;
								 case NUMERIC:
									 value = "" + cell.getNumericCellValue();
									 break;
								 case STRING:
									 value = cell.getStringCellValue();
									 break;
								 case BLANK:
									 value = null;
									 break;
								 case BOOLEAN:
									 value = "" + cell.getBooleanCellValue();
									 break;
								 case ERROR:
									 value = "" + cell.getErrorCellValue();
									 break;
									 default:
								 }
								 System.out.print(value + "\t"); //셀에대한 값을 콘솔에 출력해준다.
								 
								 if(value.equals("email")) {
									 System.out.print("\t\t");
								 }
							 }
						 }
						 System.out.println();
					 }
				 }
			 }
		 }catch(Exception e){
			 e.printStackTrace();
		 }
	}
	public static void main(String[] args)throws Exception{
		aas aas = new aas();
	}
}
