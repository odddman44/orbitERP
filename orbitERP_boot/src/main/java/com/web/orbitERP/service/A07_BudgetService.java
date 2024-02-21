package com.web.orbitERP.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.orbitERP.dao.A07_BudgetDao;
import com.web.orbitERP.vo.MBudget;



@Service
public class A07_BudgetService {
	@Autowired(required = false)
	private A07_BudgetDao dao;
    
	// 특정 부서와 연도에 대한 예산 정보 조회
    public List<MBudget> getBudgetByDeptAndYear(int deptno, int year) {
        return dao.getBudgetByDeptAndYear(deptno, year);
    }
	
}
