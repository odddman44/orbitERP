package com.web.orbitERP.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.orbitERP.dao.A07_BudgetDao;
import com.web.orbitERP.vo.ActualExpense;
import com.web.orbitERP.vo.MBudget;



@Service
public class A07_BudgetService {
	@Autowired(required = false)
	private A07_BudgetDao dao;
    
	// 특정 부서와 연도에 대한 예산 정보 조회
    public List<MBudget> getBudgetList(int deptno, int year) {
    	System.out.println("##전달된 부서번호 : "+deptno);
    	System.out.println("##전달된 연도 : "+year);
        return dao.getBudgetList(deptno, year);
    }
    
    // 월별 예산 데이터 일괄 삽입
    public int insertMonthlyBudgets(List<MBudget> budgets) {
        int insertCount = 0;
        for (MBudget budget : budgets) {
            insertCount += dao.insertMonthlyBudget(budget);
        }
        return insertCount; // 삽입된 행의 수를 반환
    }

    // 여러 개의 예산 데이터를 업데이트하는 메서드
    public int updateBudget(List<MBudget> upt) {
        int updateCount = 0;
        for (MBudget budget : upt) {
            updateCount += dao.updateBudget(budget);
        }
        return updateCount;
    }

    // 예산 삭제
    public int deleteBudget(int year, int deptno) {
        return dao.deleteBudget(year, deptno);
    }
    
    // 실제 지출 정보 조회
    public List<ActualExpense> getActualExpenses(int year, int deptno) {
        return dao.getActualExpense(year, deptno);
    }
}
