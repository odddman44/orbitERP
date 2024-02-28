package com.web.orbitERP.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.orbitERP.service.A02_HRService;
import com.web.orbitERP.service.A07_BudgetService;
import com.web.orbitERP.vo.ActualExpense;
import com.web.orbitERP.vo.Dept;
import com.web.orbitERP.vo.MBudget;

@Controller
public class A07_BudgetController {
	@Autowired(required = false)
	private A07_BudgetService service;
	
	@Autowired(required = false)
	private A02_HRService hrService;
	
	
    // 부서리스트
    @ModelAttribute("dlist")
    public List<Dept> getDeptList(){
    	return hrService.getDeptList(new Dept());
    }
    
    // 예산 정보 조회 및 결과 페이지로 이동
    // http://localhost:4444/budgetList
    @RequestMapping("budgetList")
    public String budgetList() {
        return "a07_budget\\a01_budgetList"; 
    }
    
    // http://localhost:4444/budgetSch?deptno=10&year=2023
    @GetMapping("budgetSch")
    public ResponseEntity<?> getBudgetList(@RequestParam("deptno") int deptno, @RequestParam("year") int year) {
    	List<MBudget> budgetList = service.getBudgetList(deptno, year);
    	return ResponseEntity.ok(budgetList); 
    }
    
    // 월별 예산 데이터 일괄 삽입 처리
    @PostMapping("budgetInsert")
    public ResponseEntity<?> insertMonthlyBudgets(@RequestBody List<MBudget> budgets) {
        int insertCount = service.insertMonthlyBudgets(budgets);
        Map<String, Object> response = new HashMap<>();
        response.put("insertCount", insertCount);
        return ResponseEntity.ok(response); // 성공 응답과 함께 삽입된 행의 수를 반환
    }
    
    // http://localhost:4444/budgetDetails?deptno=10&year=2023
    // 예산안 상세조회 (조회쿼리문 재활용)
    @GetMapping("budgetDetails")
    public ResponseEntity<?> budgetDetails(@RequestParam("year") int year, @RequestParam("deptno") int deptno) {
        List<MBudget> budgetDetails = service.getBudgetList(deptno, year);
        if (budgetDetails != null && !budgetDetails.isEmpty()) {
            return ResponseEntity.ok(budgetDetails);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
    // 예산 수정 처리
    @PostMapping("updateBudget")
    public ResponseEntity<?> updateMonthlyBudgets(@RequestBody List<MBudget> budgets) {
        int updateCount = service.updateBudget(budgets);
        Map<String, Object> response = new HashMap<>();
        response.put("updateCount", updateCount);
        if(updateCount > 0) {
            return ResponseEntity.ok(response); // 성공 응답과 함께 업데이트된 행의 수를 반환
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("예산 데이터 업데이트 실패");
        }
    }

    // 예산 삭제
    @PostMapping("deleteBudget")
    public ResponseEntity<?> deleteBudget(@RequestParam("year") int year, @RequestParam("deptno") int deptno) {
        int result = service.deleteBudget(year, deptno);
        if(result > 0) {
            return ResponseEntity.ok().body("예산 삭제 성공");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("예산 삭제 실패");
        }
    }
    
    // 예산 정보 조회 및 결과 페이지로 이동
    // http://localhost:4444/budgetComp
    @RequestMapping("budgetComp")
    public String budgetComp() {
        return "a07_budget\\a02_budgetComp"; 
    }
    
    // 실제 지출 데이터 조회
    // http://localhost:4444/actualExpense?year=2023&deptno=0
    @GetMapping("actualExpense")
    public ResponseEntity<?> getActualExpenses(@RequestParam(value = "year", required = false) int year, 
    										@RequestParam(value="deptno", required = false) int deptno) {
        List<ActualExpense> actualExpenses = service.getActualExpenses(year, deptno);
        return ResponseEntity.ok(actualExpenses); 
    }
    
}
