package com.web.orbitERP.vo;

import java.util.Date;

public class Salary {
	private Date payment_date;
	private String payment_dateStr; // 입력용
	private String empno;
	private int base_salary;
	private int allowance;
	private int deduction;
	private int net_pay;
	private Date start_date;
	private String start_dateStr; // 입력용
	private Date end_date;
	private String end_dateStr; // 입력용
	private int deptno;
	private String ename;
	
	public Salary() {
	
	}

	public Salary(Date payment_date, String empno, int base_salary, int allowance, int deduction, int net_pay,
			Date start_date, Date end_date, int deptno) {
		
		this.payment_date = payment_date;
		this.empno = empno;
		this.base_salary = base_salary;
		this.allowance = allowance;
		this.deduction = deduction;
		this.net_pay = net_pay;
		this.start_date = start_date;
		this.end_date = end_date;
		this.deptno = deptno;
	}
	
	public Salary(Date payment_date, String empno, int base_salary, int allowance, int deduction, int net_pay,
			Date start_date, Date end_date, int deptno, String ename) {
		
		this.payment_date = payment_date;
		this.empno = empno;
		this.base_salary = base_salary;
		this.allowance = allowance;
		this.deduction = deduction;
		this.net_pay = net_pay;
		this.start_date = start_date;
		this.end_date = end_date;
		this.deptno = deptno;
		this.ename = ename;
	}

	public Salary(String payment_dateStr, String empno, int base_salary, int allowance, int deduction,
			String start_dateStr, String end_dateStr, int deptno) {
		
		this.payment_dateStr = payment_dateStr;
		this.empno = empno;
		this.base_salary = base_salary;
		this.allowance = allowance;
		this.deduction = deduction;
		this.start_dateStr = start_dateStr;
		this.end_dateStr = end_dateStr;
		this.deptno = deptno;
	}

	public Date getPayment_date() {
		return payment_date;
	}

	public void setPayment_date(Date payment_date) {
		this.payment_date = payment_date;
	}

	public String getPayment_dateStr() {
		return payment_dateStr;
	}

	public void setPayment_dateStr(String payment_dateStr) {
		this.payment_dateStr = payment_dateStr;
	}

	public String getEmpno() {
		return empno;
	}

	public void setEmpno(String empno) {
		this.empno = empno;
	}

	public int getBase_salary() {
		return base_salary;
	}

	public void setBase_salary(int base_salary) {
		this.base_salary = base_salary;
	}

	public int getAllowance() {
		return allowance;
	}

	public void setAllowance(int allowance) {
		this.allowance = allowance;
	}

	public int getDeduction() {
		return deduction;
	}

	public void setDeduction(int deduction) {
		this.deduction = deduction;
	}

	public int getNet_pay() {
		return net_pay;
	}

	public void setNet_pay(int net_pay) {
		this.net_pay = net_pay;
	}

	public Date getStart_date() {
		return start_date;
	}

	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}

	public String getStart_dateStr() {
		return start_dateStr;
	}

	public void setStart_dateStr(String start_dateStr) {
		this.start_dateStr = start_dateStr;
	}

	public Date getEnd_date() {
		return end_date;
	}

	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}

	public String getEnd_dateStr() {
		return end_dateStr;
	}

	public void setEnd_dateStr(String end_dateStr) {
		this.end_dateStr = end_dateStr;
	}

	public int getDeptno() {
		return deptno;
	}

	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	
	
	
	
	
	


}
