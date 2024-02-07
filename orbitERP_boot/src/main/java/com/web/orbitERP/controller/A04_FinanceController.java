package com.web.orbitERP.controller;


import java.nio.file.FileVisitOption;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
import com.web.orbitERP.vo.VoucherDetail;

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

}
