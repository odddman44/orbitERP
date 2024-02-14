package com.web.orbitERP.vo;

import org.springframework.web.multipart.MultipartFile;

// orbitERP.vo.Employee
public class Employee {


	private String empno;
	private int deptno;
	private String ename;
	private String job;
	private String hiredate;
	private String email;
	private String phone;
	private String address;
	private String account;
	private String ssnum;
	private int salary;
	private String subject;
	
	private MultipartFile profile;
	private String pwd;
	
	public Employee() {
		
	}
	
	public Employee(String empno, int deptno, String ename, String job, String hiredate, String email, String phone,
			String address, String account, String ssnum) {
		this.empno = empno;
		this.deptno = deptno;
		this.ename = ename;
		this.job = job;
		this.hiredate = hiredate;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.account = account;
		this.ssnum = ssnum;
		
	}
	
	

	public Employee(String empno, int deptno, String ename, String job, String hiredate, String email, String phone,
			String address, String account, String ssnum, int salary) {
		this.empno = empno;
		this.deptno = deptno;
		this.ename = ename;
		this.job = job;
		this.hiredate = hiredate;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.account = account;
		this.ssnum = ssnum;
		this.salary = salary;
	}
	
	public Employee(String empno, int deptno, String ename, String job, String hiredate, String email, String phone,
			String address, String account, String ssnum, int salary, String subject) {
		super();
		this.empno = empno;
		this.deptno = deptno;
		this.ename = ename;
		this.job = job;
		this.hiredate = hiredate;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.account = account;
		this.ssnum = ssnum;
		this.salary = salary;
		this.subject = subject;
		
	}
	

	public String getEmpno() {
		return empno;
	}

	public void setEmpno(String empno) {
		this.empno = empno;
	}

	public int getDeptno() {
		return deptno;
	}

	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getHiredate() {
		return hiredate;
	}

	public void setHiredate(String hiredate) {
		this.hiredate = hiredate;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getSsnum() {
		return ssnum;
	}

	public void setSsnum(String ssnum) {
		this.ssnum = ssnum;
	}

	public int getSalary() {
		return salary;
	}

	public void setSalary(int salary) {
		this.salary = salary;
	}

	public MultipartFile getProfile() {
		return profile;
	}

	public void setProfile(MultipartFile profile) {
		this.profile = profile;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	
	
}
