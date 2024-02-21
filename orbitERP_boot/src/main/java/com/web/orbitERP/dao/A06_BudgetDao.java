package com.web.orbitERP.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.web.orbitERP.vo.MBudget;


// orbitERP.a03_dao.A06_BudgetDao
@Mapper
public interface A06_BudgetDao {
	List<MBudget> getBudgetByDeptAndYear(@Param("deptno") int deptno, @Param("year") int year);
}
