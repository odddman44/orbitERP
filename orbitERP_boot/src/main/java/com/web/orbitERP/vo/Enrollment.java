package com.web.orbitERP.vo;

public class Enrollment {

	private int enno;
	private int sno;
	private int lecno;
	private String empno;
	private String grade;
	public Enrollment() {
		// TODO Auto-generated constructor stub
	}
	public Enrollment(int enno, int sno, int lecno, String empno, String grade) {
		this.enno = enno;
		this.sno = sno;
		this.lecno = lecno;
		this.empno = empno;
		this.grade = grade;
	}
	public int getEnno() {
		return enno;
	}
	public void setEnno(int enno) {
		this.enno = enno;
	}
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	public int getLecno() {
		return lecno;
	}
	public void setLecno(int lecno) {
		this.lecno = lecno;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	
	
}
