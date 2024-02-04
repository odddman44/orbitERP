package com.web.orbitERP.vo;

public class Accsub {
	private int acc_code;
	private String acc_name;
	private String debit_credit;
	private String acc_type;
	private String active_status;
	private String remarks;
	private String base_acc;
	
	public Accsub() {
		// TODO Auto-generated constructor stub
	}
	
	public Accsub(int acc_code, String acc_name, String debit_credit, String acc_type, String active_status,
			String remarks, String base_acc) {
		this.acc_code = acc_code;
		this.acc_name = acc_name;
		this.debit_credit = debit_credit;
		this.acc_type = acc_type;
		this.active_status = active_status;
		this.remarks = remarks;
		this.base_acc = base_acc;
	}

	public Accsub(int acc_code, String acc_name, String debit_credit, String acc_type, String active_status,
			String remarks) {
		this.acc_code = acc_code;
		this.acc_name = acc_name;
		this.debit_credit = debit_credit;
		this.acc_type = acc_type;
		this.active_status = active_status;
		this.remarks = remarks;
	}
	public String getBase_acc() {
		return base_acc;
	}
	public void setBase_acc(String base_acc) {
		this.base_acc = base_acc;
	}
	
	public int getAcc_code() {
		return acc_code;
	}
	public void setAcc_code(int acc_code) {
		this.acc_code = acc_code;
	}
	public String getAcc_name() {
		return acc_name;
	}
	public void setAcc_name(String acc_name) {
		this.acc_name = acc_name;
	}
	public String getDebit_credit() {
		/*
		if("D".equals(debit_credit)) {
			return "차변";
		} else {
			return "대변";
		}
		*/
		return debit_credit;
	}
	public void setDebit_credit(String debit_credit) {
		this.debit_credit = debit_credit;
	}
	public String getAcc_type() {
		return acc_type;
	}
	public void setAcc_type(String acc_type) {
		this.acc_type = acc_type;
	}
	public String getActive_status() {
		return active_status;
	}
	public void setActive_status(String active_status) {
		this.active_status = active_status;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	
}
