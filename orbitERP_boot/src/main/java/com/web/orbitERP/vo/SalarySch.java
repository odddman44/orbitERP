package com.web.orbitERP.vo;

import java.util.Date;

public class SalarySch {
	private Date payment_date;
	private String payment_dateStr;
	private String year;
	private String month;
	private String empno;
	private int base_salary;
	private int allowance;
	private int deduction;
	private int net_pay;
	private int deptno;
	private String dname;
	private String ename;
	
	// 페이징 처리를 위한 필드값
	

	private int count; // 전체 데이터 건수
	private int pageSize; // 한페이지에 보여줄 데이터 건수
	private int pageCount; // 총페이지수
	private int curPage; // 클릭한 현재 페이지 번호
	private int start; // 현재 시작번호
	private int end; // 현재 마지막번호
	// 3. 페이징처리 2단계(페이징블럭)
	private int blockSize; // 한번에 보여줄 block의 크기
	private int startBlock; // block시작번호
	private int endBlock; // block 마지막번호
	
	public SalarySch() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SalarySch(Date payment_date, String empno, int base_salary, int allowance, int deduction, int net_pay,
			int deptno, String dname, int count, int pageSize, int pageCount, int curPage, int start, int end, int blockSize,
			int startBlock, int endBlock, String ename) {
		super();
		this.payment_date = payment_date;
		this.empno = empno;
		this.base_salary = base_salary;
		this.allowance = allowance;
		this.deduction = deduction;
		this.net_pay = net_pay;
		this.deptno = deptno;
		this.dname = dname;
		this.count = count;
		this.pageSize = pageSize;
		this.pageCount = pageCount;
		this.curPage = curPage;
		this.start = start;
		this.end = end;
		this.blockSize = blockSize;
		this.startBlock = startBlock;
		this.endBlock = endBlock;
		this.ename = ename;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public Date getPayment_date() {
		return payment_date;
	}

	public void setPayment_date(Date payment_date) {
		this.payment_date = payment_date;
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

	public int getDeptno() {
		return deptno;
	}

	public String getDname() {
		return dname;
	}

	public void setDname(String dname) {
		this.dname = dname;
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

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public int getStartBlock() {
		return startBlock;
	}

	public void setStartBlock(int startBlock) {
		this.startBlock = startBlock;
	}

	public int getEndBlock() {
		return endBlock;
	}

	public void setEndBlock(int endBlock) {
		this.endBlock = endBlock;
	}

	public String getPayment_dateStr() {
		return payment_dateStr;
	}

	public void setPayment_dateStr(String payment_dateStr) {
		this.payment_dateStr = payment_dateStr;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}
	
	
	
	
	
	
	
}
