package com.web.orbitERP.vo;

// orbitERP.vo.Journalizing
public class Journalizing {
	private int journal_id;
	private int voucher_id; // 외래키로서의 voucher_id
	private int acc_code;
	private String acc_name;
	private double debit_amount;
	private double credit_amount;
	private String trans_name;
	private String j_remark;
	public Journalizing() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Journalizing(int journal_id, int voucher_id, int acc_code, String acc_name, double debit_amount,
			double credit_amount, String trans_name, String j_remark) {
		super();
		this.journal_id = journal_id;
		this.voucher_id = voucher_id;
		this.acc_code = acc_code;
		this.acc_name = acc_name;
		this.debit_amount = debit_amount;
		this.credit_amount = credit_amount;
		this.trans_name = trans_name;
		this.j_remark = j_remark;
	}
	public int getJournal_id() {
		return journal_id;
	}
	public void setJournal_id(int journal_id) {
		this.journal_id = journal_id;
	}
	public int getVoucher_id() {
		return voucher_id;
	}
	public void setVoucher_id(int voucher_id) {
		this.voucher_id = voucher_id;
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
	public double getDebit_amount() {
		return debit_amount;
	}
	public void setDebit_amount(double debit_amount) {
		this.debit_amount = debit_amount;
	}
	public double getCredit_amount() {
		return credit_amount;
	}
	public void setCredit_amount(double credit_amount) {
		this.credit_amount = credit_amount;
	}
	public String getTrans_name() {
		return trans_name;
	}
	public void setTrans_name(String trans_name) {
		this.trans_name = trans_name;
	}
	public String getJ_remark() {
		return j_remark;
	}
	public void setJ_remark(String j_remark) {
		this.j_remark = j_remark;
	}
	
	
	
	
	
}
