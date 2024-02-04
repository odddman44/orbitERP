package com.web.orbitERP.vo;

public class EmpProfile {
	
	private String empno;
	private String fname;
	private String path;
	
	public EmpProfile() {
		
	}
	
	public EmpProfile(String empno, String fname, String path) {
		super();
		this.empno = empno;
		this.path = path;
		this.fname = fname;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	
	
		
	
	
}
