package com.web.orbitERP.vo;

// com.web.orbitERP.vo.MBudget
public class MBudget {
    private int year;
    private int month;
    private int deptno;
    private double month_amount;
    private String dname; // DEPT 테이블에서 조인하여 가져올 부서명
	public MBudget() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public MBudget(int year, int month, int deptno, double month_amount, String dname) {
		super();
		this.year = year;
		this.month = month;
		this.deptno = deptno;
		this.month_amount = month_amount;
		this.dname = dname;
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
	public double getMonth_amount() {
		return month_amount;
	}
	public void setMonth_amount(double month_amount) {
		this.month_amount = month_amount;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
    
}
