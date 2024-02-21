package com.web.orbitERP.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.orbitERP.service.A02_HRService;
import com.web.orbitERP.service.A06_BudgetService;
import com.web.orbitERP.vo.Dept;
import com.web.orbitERP.vo.MBudget;

@Controller
public class A06_BudgetController {
	@Autowired(required = false)
	private A06_BudgetService service;
	
	@Autowired(required = false)
	private A02_HRService hrService;
	
	
    // 부서리스트
    @ModelAttribute("dlist")
    public List<Dept> getDeptList(){
    	return hrService.getDeptList(new Dept());
    }
    
    // 예산 정보 조회 및 결과 페이지로 이동
    @GetMapping("budgetList")
    public String getBudgetList(@RequestParam("deptno") int deptno, @RequestParam("year") int year, Model model) {
        List<MBudget> budgetList = service.getBudgetByDeptAndYear(deptno, year);
        model.addAttribute("budgetList", budgetList);
        return "budget/budgetList"; // 예산 정보를 보여줄 뷰 페이지의 경로
    }
    
}
