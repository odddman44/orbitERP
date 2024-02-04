package com.web.orbitERP.vo;

public class StuProfile {
	private int sno;
	private String fname;
	private String path;
	public StuProfile() {
		super();
		// TODO Auto-generated constructor stub
	}
	public StuProfile(String fname, String path) {
		this.fname = fname;
		this.path = path;
	}
	
	
	public StuProfile(int sno, String fname, String path) {
		this.sno = sno;
		this.fname = fname;
		this.path = path;
	}
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	

}
