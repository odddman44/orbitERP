package com.web.orbitERP.vo;



public class AttendanceSch {
	private String empno;
	private String work_date;
	private String arr_time;
	private String dep_time;
	private String late;
	private String early_leave;
	private String tot_workhours;
	private String dname;
	private String start_date;
	private String end_date;
	private int deptno;
	public AttendanceSch() {
		super();
		// TODO Auto-generated constructor stub
	}
	public AttendanceSch(String empno, String work_date, String arr_time, String dep_time, String late,
			String early_leave, String tot_workhours, String dname, int deptno) {
		super();
		this.empno = empno;
		this.work_date = work_date;
		this.arr_time = arr_time;
		this.dep_time = dep_time;
		this.late = late;
		this.early_leave = early_leave;
		this.tot_workhours = tot_workhours;
		this.dname = dname;
		this.deptno = deptno;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getWork_date() {
		return work_date;
	}
	public void setWork_date(String work_date) {
		this.work_date = work_date;
	}
	public String getArr_time() {
		return arr_time;
	}
	public void setArr_time(String arr_time) {
		this.arr_time = arr_time;
	}
	public String getDep_time() {
		return dep_time;
	}
	public void setDep_time(String dep_time) {
		this.dep_time = dep_time;
	}
	public String getLate() {
		return late;
	}
	public void setLate(String late) {
		this.late = late;
	}
	public String getEarly_leave() {
		return early_leave;
	}
	public void setEarly_leave(String early_leave) {
		this.early_leave = early_leave;
	}
	public String getTot_workhours() {
		return tot_workhours;
	}
	public void setTot_workhours(String tot_workhours) {
		this.tot_workhours = tot_workhours;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
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
	
	
	
	
	
}
