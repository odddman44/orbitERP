package com.web.orbitERP.vo;

import java.util.Date;
import java.util.List;

// orbitERP.vo.VoucherDetail
public class VoucherDetail {
	private int voucher_id; // 전표 ID
    private Date voucher_date; // 전표 날짜
    private String voucher_dateStr; // 전표 날짜 문자값
    private String voucher_no; // 전표 번호
    private String voucher_type; // 전표 유형
    private double total_amount; // 분개 총계
    private String trans_cname; // 거래처 이름
    private String remarks; // 비고
    private int deptno; // 부서번호
    private String dname; // 부서 이름
    private List<Journalizing> journalizings; // 분개 항목들을 담을 리스트
    
	public VoucherDetail() {
		// TODO Auto-generated constructor stub
	}
	public VoucherDetail(int voucher_id, Date voucher_date, String voucher_no, String trans_cname, String remarks,
			String dname) {
		this.voucher_id = voucher_id;
		this.voucher_date = voucher_date;
		this.voucher_no = voucher_no;
		this.trans_cname = trans_cname;
		this.remarks = remarks;
		this.dname = dname;
	}
	
	
	public String getVoucher_type() {
		return voucher_type;
	}
	public void setVoucher_type(String voucher_type) {
		this.voucher_type = voucher_type;
	}
	public String getVoucher_dateStr() {
		return voucher_dateStr;
	}
	public void setVoucher_dateStr(String voucher_dateStr) {
		this.voucher_dateStr = voucher_dateStr;
	}
	public double getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(double total_amount) {
		this.total_amount = total_amount;
	}
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
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

	public List<Journalizing> getJournalizings() {
		return journalizings;
	}

	public void setJournalizings(List<Journalizing> journalizings) {
		this.journalizings = journalizings;
	}
    
    
}
