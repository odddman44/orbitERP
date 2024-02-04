package com.web.orbitERP.vo;

public class LectureTch {

	private String empno;
	private String ename;
	private String job;
	private String email;
	private String subject;
	public LectureTch() {
		// TODO Auto-generated constructoㄷr stub
	}
	
	public LectureTch(String empno, String ename, String job, String email, String subject) {
		this.empno = empno;
		this.ename = ename;
		this.job = job;
		this.email = email;
		this.subject = subject;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}

	
}
