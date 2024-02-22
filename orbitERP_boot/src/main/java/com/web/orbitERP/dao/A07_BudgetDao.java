package com.web.orbitERP.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.web.orbitERP.vo.MBudget;


// orbitERP.a03_dao.A07_BudgetDao
@Mapper
public interface A07_BudgetDao {
	List<MBudget> getBudgetList(@Param("deptno") int deptno, @Param("year") int year);
}
