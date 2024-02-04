package com.web.orbitERP.vo;

import java.util.Date;

// orbitERP.vo.Voucher
public class Voucher {
	private int voucher_id; // 시퀀스, 자동생성 프라이머리 키
	private Date voucher_date;
	private String voucher_dateStr; // 전표날짜 Insert용
	private String voucher_no;
	private String voucher_type; // 전표 유형 추가
	private double total_amount;
	private String trans_cname;
	private String remarks;
	private String dname;
	
	// 조회용
	private String startDate;
	private String endDate;
	public Voucher() {
		// TODO Auto-generated constructor stub
	}
	public Voucher(int voucher_id, Date voucher_date, String voucher_no, double total_amount, String trans_cname,
			String remarks, String dname, String startDate, String endDate) {
		this.voucher_id = voucher_id;
		this.voucher_date = voucher_date;
		this.voucher_no = voucher_no;
		this.total_amount = total_amount;
		this.trans_cname = trans_cname;
		this.remarks = remarks;
		this.dname = dname;
		this.startDate = startDate;
		this.endDate = endDate;
	}
	
	public String getVoucher_dateStr() {
		return voucher_dateStr;
	}
	public void setVoucher_dateStr(String voucher_dateStr) {
		this.voucher_dateStr = voucher_dateStr;
	}
	public String getVoucher_type() {
		return voucher_type;
	}
	public void setVoucher_type(String voucher_type) {
		this.voucher_type = voucher_type;
	}
	public int getVoucher_id() {
		return voucher_id;
	}
	public void setVoucher_id(int voucher_id) {
		this.voucher_id = voucher_id;
	}
	public Date getVoucher_date() {
		return voucher_date;
	}
	public void setVoucher_date(Date voucher_date) {
		this.voucher_date = voucher_date;
	}
	public String getVoucher_no() {
		return voucher_no;
	}
	public void setVoucher_no(String voucher_no) {
		this.voucher_no = voucher_no;
	}
	public double getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(double total_amount) {
		this.total_amount = total_amount;
	}
	public String getTrans_cname() {
		return trans_cname;
	}
	public void setTrans_cname(String trans_cname) {
		this.trans_cname = trans_cname;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	

}
