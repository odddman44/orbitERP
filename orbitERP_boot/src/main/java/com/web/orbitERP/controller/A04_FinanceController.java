package com.web.orbitERP.controller;


import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.web.orbitERP.service.A02_HRService;
import com.web.orbitERP.service.A04_FinanceService;
import com.web.orbitERP.vo.Accsub;
import com.web.orbitERP.vo.AccsubSch;
import com.web.orbitERP.vo.Dept;
import com.web.orbitERP.vo.FinanceSummary;
import com.web.orbitERP.vo.GrossProfit;
import com.web.orbitERP.vo.IcStmtSch;
import com.web.orbitERP.vo.IncomeStatement;
import com.web.orbitERP.vo.Journalizing;
import com.web.orbitERP.vo.VoucherDetail;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class A04_FinanceController {
	@Autowired(required = false)
	private A04_FinanceService service;
	
	@Autowired(required = false)
	private A02_HRService hrService;
	
	/*계정과목 리스트 조회*/
	// http://localhost:4444/accList
	//  http://211.63.89.67:4444/accList
	//  브랜치 테스트 완료
	@RequestMapping("accList")
	public String accsubList(@ModelAttribute("sch") AccsubSch sch, Model d) {
		d.addAttribute("accList", service.accsubList(sch));
		return "a04_financeResource\\a01_accsubList";
	}
	/* 계정과목 등록*/
	@PostMapping("insertAccsub")
	public String insertAccsub(Accsub ins, Model d) {
		d.addAttribute("msg", service.insertAccsub(ins));
		return "a04_financeResource\\a01_accsubList";
	}
	/* 계정과목 상세보기*/
	// http://localhost:4444/accsubDetail
	@GetMapping("accsubDetail")
	public String getAccsub(@RequestParam("acc_code") int acc_code, Model d) {
		d.addAttribute("accsub", service.getAccsub(acc_code));
		return "pageJsonReport";
	}
	/*계정과목 수정*/
	@PostMapping("updateAccsub")
	public String updateAccsub(Accsub upt, Model d) {
		d.addAttribute("proc", "upt");
		d.addAttribute("msg",service.updateAccsub(upt));
		// 수정 후
		d.addAttribute("accsub", service.getAccsub(upt.getAcc_code()));
		return "pageJsonReport";
	}
	/*계정과목 삭제*/
	@PostMapping("deleteAccsub")
	public String deleteAccsub(@RequestParam("acc_code") int acc_code, Model d) {
		d.addAttribute("proc", "del");
		d.addAttribute("msg", service.deleteAccsub(acc_code));
		return "pageJsonReport";
	}
	 // 계정코드 중복 확인
    @GetMapping("checkAccCodeDuplication")
    public String checkAccCodeDuplication(@RequestParam("acc_code") int accCode, Model d) {
        boolean isDuplicate = service.checkAccCodeDuplication(accCode);
        d.addAttribute("isDuplicate", isDuplicate);
        return "pageJsonReport"; 
    }
	
	/*
	 * 2. 전표 관련
	 * */
	// http://localhost:4444/voucherList
    @RequestMapping("voucherList")
    public String voucherList(
    	    @RequestParam(value = "startDate", required = false) String startDate,
    	    @RequestParam(value = "endDate", required = false) String endDate, 
    	    @RequestParam(value = "voucher_type", required = false) String voucher_type, 
    	    Model d) {
    	d.addAttribute("selectedStartDate", startDate);
    	d.addAttribute("selectedEndDate", endDate);
    	d.addAttribute("selectedType", voucher_type);
        d.addAttribute("vlist", service.voucherList(startDate, endDate, voucher_type));
        return "a04_financeResource\\a02_voucherSch";
    }
    
    // 전표 상세조회
    @RequestMapping("getVoucherDetail")
    public String getVoucherDetail(@RequestParam("voucher_id") int voucher_id, Model d) {
        VoucherDetail voucherDetail = service.getVoucherDetail(voucher_id);
        d.addAttribute("voucherDetail", voucherDetail);
        return "pageJsonReport";
    }
    // 부서리스트
    @ModelAttribute("dlist")
    public List<Dept> getDeptList(){
    	return hrService.getDeptList(new Dept());
    }
    @ModelAttribute("aList")
    public List<Accsub> accsubModal(){
    	return service.accsubModal(new Accsub());
    }
    
    // 전표 등록
    @PostMapping("insertVoucher")
    public String insertVoucher(@RequestBody VoucherDetail ins, Model d) {
    	System.out.println("Received Data: " + ins); // 수신 데이터 출력
    	try {
    		service.insertVoucher(ins);
    		d.addAttribute("status","success");
    		d.addAttribute("message", "전표 및 분개 등록 완료!");
    	}catch (Exception e) {
    		e.printStackTrace();
    		d.addAttribute("status", "error");
    		d.addAttribute("message","등록 중 오류 발생:"+e.getMessage());
		}
    	return "pageJsonReport";
    }
    
    // 전표 및 분개 수정 처리
    @PostMapping("updateVoucher")
    public ModelAndView updateVoucher(@RequestBody VoucherDetail upt) {
    	ModelAndView mav = new ModelAndView();
    	mav.setView(new MappingJackson2JsonView());
        try {
            service.updateVoucher(upt);
            mav.addObject("status", "success");
            mav.addObject("message", "전표 및 분개 수정 완료");
        } catch (Exception e) {
            e.printStackTrace();
            mav.addObject("status", "error");
            mav.addObject("message", "수정 중 오류 발생: " + e.getMessage());
        }
        return mav;
    }
    
    // 전표 다중 삭제 처리
    @PostMapping("deleteVouchers")
    public ResponseEntity<?> deleteVouchers(@RequestBody List<Integer> voucherIds) {
        try {
            service.deleteVouchers(voucherIds);
            return ResponseEntity.ok().body
            		(Map.of("status", "success", "message", "Selected rows deleted successfully"));
        } catch (Exception e) {
            return ResponseEntity.status
            		(HttpStatus.INTERNAL_SERVER_ERROR).body
            		(Map.of("status", "error", "message", e.getMessage()));
        }
    }
    
    // 전표 엑셀로 다운로드!
    @GetMapping("downloadExcel")
    public void downloadExcel(HttpServletResponse response, @RequestParam("voucher_id") int voucher_id) {
        try {
            // voucherId를 사용하여 데이터베이스에서 전표 상세 정보와 분개 정보를 조회
        	VoucherDetail voucherDetail = service.getVoucherDetail(voucher_id);
            List<Journalizing> journalizings = voucherDetail.getJournalizings();

            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("전표 상세 조회");
            
            // 셀 스타일 설정
            CellStyle headerCellStyle = workbook.createCellStyle();
            CellStyle infoCellStyle = workbook.createCellStyle();
            CellStyle normalCellStyle = workbook.createCellStyle();

            // 헤더 셀 스타일 설정
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setColor(IndexedColors.WHITE.getIndex());
            headerCellStyle.setFont(headerFont);
            headerCellStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
            headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerCellStyle.setAlignment(HorizontalAlignment.CENTER);

            // 데이터 셀 스타일 설정
            Font dataFont = workbook.createFont();
            dataFont.setBold(true);
            infoCellStyle.setFont(dataFont);
            infoCellStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
            infoCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            // 일반 셀 스타일 설정 (하얀 배경)
            Font normalFont = workbook.createFont();
            normalFont.setBold(false);
            normalCellStyle.setFont(normalFont);
            normalCellStyle.setFillForegroundColor(IndexedColors.WHITE.getIndex());
            normalCellStyle.setFillPattern(FillPatternType.NO_FILL);
            
            // 헤더 행 생성
            String[] headerColumns = {"전표번호", "전표 날짜", "전표유형", "금액", "거래(처)명", "적요", "부서"};
            Row headerRow = sheet.createRow(0);
            for (int i = 0; i < headerColumns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headerColumns[i]);
                cell.setCellStyle(headerCellStyle);
                sheet.setColumnWidth(i, 20 * 256); // 셀 너비 설정
            }

            // 전표 상세 정보 행 생성
            Row detailRow = sheet.createRow(1);
            for (int i = 0; i < headerColumns.length; i++) {
                Cell cell = detailRow.createCell(i);
                cell.setCellStyle(infoCellStyle);
            }
            // 데이터 셀 설정 
            detailRow.createCell(0).setCellValue(voucherDetail.getVoucher_id());
            
            // 날짜 포매팅 추가
            CellStyle dateCellStyle = workbook.createCellStyle();
            CreationHelper createHelper = workbook.getCreationHelper();
            dateCellStyle.setDataFormat(createHelper.createDataFormat().getFormat("yyyy-mm-dd"));
            Cell dateCell = detailRow.createCell(1);
            dateCell.setCellValue(voucherDetail.getVoucher_date());
            dateCell.setCellStyle(dateCellStyle);
            detailRow.createCell(2).setCellValue(voucherDetail.getVoucher_type());
            detailRow.createCell(3).setCellValue(voucherDetail.getTotal_amount());
            detailRow.createCell(4).setCellValue(voucherDetail.getTrans_cname());
            detailRow.createCell(5).setCellValue(voucherDetail.getRemarks());
            detailRow.createCell(6).setCellValue(voucherDetail.getDname());
            
            // 금액 데이터에 천단위 콤마 스타일 적용
            CellStyle amountCellStyle = workbook.createCellStyle();
            amountCellStyle.setDataFormat(workbook.createDataFormat().getFormat("#,##0"));
            // 전표 상세 정보에 금액 콤마 스타일 적용
            detailRow.getCell(3).setCellStyle(amountCellStyle);
            
            // 분개 정보 섹션 헤더 생성
            String[] journalColumns = {"계정코드", "계정명", "차변", "대변", "거래명", "분개 적요"};
            int journalRowNum = 5; // 전표 정보 다음 행 번호
            Row journalHeaderRow = sheet.createRow(journalRowNum);
            for (int i = 0; i < journalColumns.length; i++) {
                Cell cell = journalHeaderRow.createCell(i);
                cell.setCellValue(journalColumns[i]);
                cell.setCellStyle(infoCellStyle);
            }

            // 분개 정보 데이터 행 생성
            journalRowNum++;
            for (Journalizing journal : journalizings) {
                Row row = sheet.createRow(journalRowNum++);
                for (int i = 0; i < journalColumns.length; i++) {
                    Cell cell = row.createCell(i);
                    cell.setCellStyle(normalCellStyle);
                }
                // 각 셀에 분개 정보 데이터를 설정합니다...
                row.getCell(0).setCellValue(journal.getAcc_code());
                row.getCell(1).setCellValue(journal.getAcc_name());
                row.getCell(2).setCellValue(journal.getDebit_amount());
                row.getCell(3).setCellValue(journal.getCredit_amount());
                row.getCell(4).setCellValue(journal.getTrans_name());
                row.getCell(5).setCellValue(journal.getJ_remark());
                // 금액 데이터에 천단위 콤마 스타일 적용
                row.getCell(2).setCellStyle(amountCellStyle);
                row.getCell(3).setCellStyle(amountCellStyle);
            }

            // HTTP 헤더 설정 및 엑셀 파일 다운로드
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            // 파일명 랜덤생성.
            String fileName = "Voucher_" + voucher_id + "_" + new SimpleDateFormat("yyyyMMdd").format(new Date()) + ".xlsx";
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            workbook.write(response.getOutputStream());
            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
	/*
	 * 3. 경영자 보고서 관련
	 * */
    // http://localhost:4444/manageReport
    @RequestMapping("manageReport")
    public String manageReport() {
    	return "a04_financeResource\\a03_managementReport";
    }
    
    // http://localhost:4444/salesPurchasesSummary?year=2024
    @GetMapping("salesPurchasesSummary")
    public ResponseEntity<?> getSalesAndPurchasesSummaryByYear(@RequestParam("year") int year) {
        List<FinanceSummary> summary = service.getSalesAndPurchasesSummaryByYear(year);
        return ResponseEntity.ok(summary);
    }
    // http://localhost:4444/grossProfit?deptno=50
    @GetMapping("grossProfit")
    public ResponseEntity<?> getGrossProfit(@RequestParam("deptno") int deptno,
    										@RequestParam(value="startDate", required = false) String startDate,
    										@RequestParam(value="endDate", required = false) String endDate) {
    	// 기본 날짜값 설정
        if (startDate == null || startDate.isEmpty()) {
            startDate = "2023-01"; // 최소한의 기본 시작 날짜
        }
        if (endDate == null || endDate.isEmpty()) {
            endDate = "2024-01"; // 최대한의 기본 종료 날짜
        }
    	List<GrossProfit> grossProfits = service.getGrossProfit(deptno, startDate, endDate);
    	return ResponseEntity.ok(grossProfits);
    }
    
    // 손익계산서
    // json 타입으로 보낼 때
    // http://localhost:4444/incomeStatement?basicYear=2024&compYear=2023
    // http://localhost:4444/incomeStatement
    @PostMapping("incomeStatement")
    public ResponseEntity<?> getIncomeStatements(@RequestBody IcStmtSch sch){
    	String basicYear = sch.getBasicYear();
        String compYear = sch.getCompYear();
    	List<IncomeStatement> incomeStatements = service.getIncomeStatements(basicYear, compYear);
    	return ResponseEntity.ok(incomeStatements);
    }
    
    // http://localhost:4444/netIncomeGraph?year=2024
    @GetMapping("netIncomeGraph")
    public ResponseEntity<?> getNetIncomeGraph(@RequestParam("year") int year){
    	List<FinanceSummary> incomeData = service.getNetIncomeGraph(year);
    	return ResponseEntity.ok(incomeData);
    }
    
    /****
    @GetMapping("/incomeStatement")
    public String getIncomeStatements(@RequestParam(value="basicYear", required = false, defaultValue="2024") String basicYear,
                                      @RequestParam(value="compYear", required = false, defaultValue="2023") String compYear,
                                      Model d) { // Model 객체를 메서드 시그니처에 추가
        // 기본값은 메서드 내에서 설정하지 않고, @RequestParam의 defaultValue로 설정
    	Map<Integer, IncomeStatement> structuredData = service.getIncomeStatements(basicYear, compYear);
        d.addAttribute("icStmt", structuredData); // 모델에 데이터 추가
        d.addAttribute("basicYear", basicYear); // 조회한 기준년도 추가
        d.addAttribute("compYear", compYear); // 조회한 비교년도 추가
        return "z05_incomeStmt"; 
    }
    ****/
}
