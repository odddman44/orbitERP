package com.web.orbitERP.vo;

// com.web.orbitERP.vo.GrossProfit
public class GrossProfit {
	private int deptno;
    private String trans_cname;
    private String yearMonth;
    private double netSalesProfit;
	public GrossProfit() {
		super();
		// TODO Auto-generated constructor stub
	}
	public GrossProfit(int deptno, String trans_cname, String yearMonth, double netSalesProfit) {
		super();
		this.deptno = deptno;
		this.trans_cname = trans_cname;
		this.yearMonth = yearMonth;
		this.netSalesProfit = netSalesProfit;
	}
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	public String getTrans_cname() {
		return trans_cname;
	}
	public void setTrans_cname(String trans_cname) {
		this.trans_cname = trans_cname;
	}
	public String getYearMonth() {
		return yearMonth;
	}
	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}
	public double getNetSalesProfit() {
		return netSalesProfit;
	}
	public void setNetSalesProfit(double netSalesProfit) {
		this.netSalesProfit = netSalesProfit;
	}
	
    
}
