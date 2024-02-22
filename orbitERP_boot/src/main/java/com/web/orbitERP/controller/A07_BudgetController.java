package com.web.orbitERP.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.orbitERP.service.A02_HRService;
import com.web.orbitERP.service.A07_BudgetService;
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
    
//    // http://localhost:4444/budgetSch
//    @GetMapping("budgetSch")
//    public String getBudgetList(@ModelAttribute("sch") MBudget sch, Model d) {
//    	List<MBudget> budgetList = service.getBudgetList(sch);
//    	d.addAttribute("budgetList", budgetList);
//    	return "pageJsonReport"; 
//    }
    // http://localhost:4444/budgetSch?deptno=10&year=2023
    @GetMapping("budgetSch")
    public ResponseEntity<?> getBudgetList(@RequestParam("deptno") int deptno, @RequestParam("year") int year) {
    	List<MBudget> budgetList = service.getBudgetList(deptno, year);
    	return ResponseEntity.ok(budgetList); 
    }
    
    
}