package com.web.orbitERP.vo;

public class InsertLecCal {

	private int lecno;
	private String backgroundColor;
	public InsertLecCal() {
		// TODO Auto-generated constructor stub
	}
	public InsertLecCal(int lecno, String backgroundColor) {
		this.lecno = lecno;
		this.backgroundColor = backgroundColor;
	}
	public int getLecno() {
		return lecno;
	}
	public void setLecno(int lecno) {
		this.lecno = lecno;
	}
	public String getBackgroundColor() {
		return backgroundColor;
	}
	public void setBackgroundColor(String backgroundColor) {
		this.backgroundColor = backgroundColor;
	}
 	
	
}
