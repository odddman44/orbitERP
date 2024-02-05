package com.web.orbitERP.vo;

public class Erpmem {
	private String empno;
	private String auth;
	private String ename;
	private String pwd;
	private String email;
	private String deptno;
	private String dname;
	
	public Erpmem() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Erpmem(String empno, String auth, String ename, String pwd, String email) {
		super();
		this.empno = empno;
		this.auth = auth;
		this.ename = ename;
		this.pwd = pwd;
		this.email = email;
	}
	
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getDeptno() {
		return deptno;
	}
	public void setDeptno(String deptno) {
		this.deptno = deptno;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
}