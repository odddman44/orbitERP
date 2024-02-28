package com.web.orbitERP.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.web.orbitERP.vo.ActualExpense;
import com.web.orbitERP.vo.MBudget;


// orbitERP.a03_dao.A07_BudgetDao
@Mapper
public interface A07_BudgetDao {
	List<MBudget> getBudgetList(@Param("deptno") int deptno, @Param("year") int year);
	
	// 월별 예산 데이터 삽입
	int insertMonthlyBudget(MBudget ins);
	
	// 예산 수정
    int updateBudget(MBudget upt);
    // 예산 삭제
    int deleteBudget(int year, int deptno);
    
    // 실제 지출 정보 조회
    List<ActualExpense> getActualExpense(int year, int deptno);
}
