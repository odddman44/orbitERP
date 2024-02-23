package com.web.orbitERP.vo;

import java.util.Date;

public class Paystub {
	// insert 할때는 payment_dateStr, stub_name, empno, net_pay, deptno
	private Date payment_date;
	private String payment_dateStr;
	private String stub_name;
	private String empno;
	private int net_pay;
	private int deptno;
	// join을 활용해 가져오는 필드값들
	private int count;
	private int total_net_pay;
	private String ename;
	private String job;
	
	public Paystub(Date payment_date, String payment_dateStr, String stub_name, String empno, int net_pay, int deptno,
			String ename, String job) {
		super();
		this.payment_date = payment_date;
		this.payment_dateStr = payment_dateStr;
		this.stub_name = stub_name;
		this.empno = empno;
		this.net_pay = net_pay;
		this.deptno = deptno;
		this.ename = ename;
		this.job = job;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public Paystub() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Paystub(Date payment_date, String payment_dateStr, String stub_name, String empno, int net_pay, int deptno) {
		super();
		this.payment_date = payment_date;
		this.payment_dateStr = payment_dateStr;
		this.stub_name = stub_name;
		this.empno = empno;
		this.net_pay = net_pay;
		this.deptno = deptno;
	}

	public Paystub(Date payment_date, String payment_dateStr, String stub_name, String empno, int net_pay, int deptno,
			int count, int total_net_pay) {
		super();
		this.payment_date = payment_date;
		this.payment_dateStr = payment_dateStr;
		this.stub_name = stub_name;
		this.empno = empno;
		this.net_pay = net_pay;
		this.deptno = deptno;
		this.count = count;
		this.total_net_pay = total_net_pay;
	}
	
	

	public Paystub(String payment_dateStr, String stub_name, String empno, int net_pay, int deptno) {
		super();
		this.payment_dateStr = payment_dateStr;
		this.stub_name = stub_name;
		this.empno = empno;
		this.net_pay = net_pay;
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

	public String getStub_name() {
		return stub_name;
	}

	public void setStub_name(String stub_name) {
		this.stub_name = stub_name;
	}

	public String getEmpno() {
		return empno;
	}

	public void setEmpno(String empno) {
		this.empno = empno;
	}

	public int getNet_pay() {
		return net_pay;
	}

	public void setNet_pay(int net_pay) {
		this.net_pay = net_pay;
	}

	public int getDeptno() {
		return deptno;
	}

	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getTotal_net_pay() {
		return total_net_pay;
	}

	public void setTotal_net_pay(int total_net_pay) {
		this.total_net_pay = total_net_pay;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}
	
	
	
	
	
	
}
