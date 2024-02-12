package com.web.orbitERP.vo;

public class Lecture {

	private int lecno;
	private String lec_code;
	private String lec_name;
	private String start_date;
	private String end_date;
	private int lec_snum;
	private String lec_num;
	private int tuition_fee;
	private int textbook_fee;
	private String lec_content;
	private String lec_teacher;
	



	public Lecture(int lecno, String lec_code, String lec_name, String start_date, String end_date, int lec_snum,
			String lec_num, int tuition_fee, int textbook_fee, String lec_content, String lec_teacher) {
		this.lecno = lecno;
		this.lec_code = lec_code;
		this.lec_name = lec_name;
		this.start_date = start_date;
		this.end_date = end_date;
		this.lec_snum = lec_snum;
		this.lec_num = lec_num;
		this.tuition_fee = tuition_fee;
		this.textbook_fee = textbook_fee;
		this.lec_content = lec_content;
		this.lec_teacher = lec_teacher;
	}



	public Lecture() {
		// TODO Auto-generated constructor stub
	}
	


	public String getStart_date() {
		return start_date;
	}



	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}



	public String getEnd_date() {
		return end_date;
	}



	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getLec_content() {
		return lec_content;
	}


	public void setLec_content(String lec_content) {
		this.lec_content = lec_content;
	}

	public int getLecno() {
		return lecno;
	}


	public void setLecno(int lecno) {
		this.lecno = lecno;
	}


	public String getLec_code() {
		return lec_code;
	}


	public void setLec_code(String lec_code) {
		this.lec_code = lec_code;
	}


	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}



	public int getLec_snum() {
		return lec_snum;
	}



	public void setLec_snum(int lec_snum) {
		this.lec_snum = lec_snum;
	}



	public String getLec_num() {
		return lec_num;
	}



	public void setLec_num(String lec_num) {
		this.lec_num = lec_num;
	}



	public int getTuition_fee() {
		return tuition_fee;
	}
	public void setTuition_fee(int tuition_fee) {
		this.tuition_fee = tuition_fee;
	}
	public int getTextbook_fee() {
		return textbook_fee;
	}
	public void setTextbook_fee(int textbook_fee) {
		this.textbook_fee = textbook_fee;
	}
	

	public String getLec_teacher() {
		return lec_teacher;
	}

	public void setLec_teacher(String lec_teacher) {
		this.lec_teacher = lec_teacher;
	}
	
	
	
}
