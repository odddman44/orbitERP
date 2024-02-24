package com.web.orbitERP.vo;

import java.math.BigDecimal;

// com.web.orbitERP.vo.ActualExpense
public class ActualExpense {
	private int year;
    private int month;
    private int deptno;
    private BigDecimal totalDebitAmount;
	public ActualExpense() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ActualExpense(int year, int month, int deptno, BigDecimal totalDebitAmount) {
		super();
		this.year = year;
		this.month = month;
		this.deptno = deptno;
		this.totalDebitAmount = totalDebitAmount;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	public BigDecimal getTotalDebitAmount() {
		return totalDebitAmount;
	}
	public void setTotalDebitAmount(BigDecimal totalDebitAmount) {
		this.totalDebitAmount = totalDebitAmount;
	}
    
}
