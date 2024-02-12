package com.web.orbitERP.vo;

public class LectureCalendar {
 	private int id; //시퀀스
 	private int lecno;
 	private String lec_code;
 	private String title; //강의명
 	private String start; //개강일
 	private String end; //종강일
 	private int lec_snum; //학생수
 	private String lec_num; //강의실
 	private String lec_teacher; //강사명
 	private String backgroundColor;
 	private String textColor;
 	private boolean allDay=true; //항상 종일로표시
 	
	public LectureCalendar() {
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






	public LectureCalendar(int id, int lecno, String lec_code, String title, String start, String end, int lec_snum,
			String lec_num, String lec_teacher, String backgroundColor, String textColor, boolean allDay) {
		super();
		this.id = id;
		this.lecno = lecno;
		this.lec_code = lec_code;
		this.title = title;
		this.start = start;
		this.end = end;
		this.lec_snum = lec_snum;
		this.lec_num = lec_num;
		this.lec_teacher = lec_teacher;
		this.backgroundColor = backgroundColor;
		this.textColor = textColor;
		this.allDay = allDay;
	}


	public boolean isAllDay() {
		return allDay;
	}
	
	public void setAllDay(boolean allDay) {
		this.allDay = allDay;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
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

	public String getLec_teacher() {
		return lec_teacher;
	}

	public void setLec_teacher(String lec_teacher) {
		this.lec_teacher = lec_teacher;
	}

	public String getBackgroundColor() {
		return backgroundColor;
	}

	public void setBackgroundColor(String backgroundColor) {
		this.backgroundColor = backgroundColor;
	}

	public String getTextColor() {
		return textColor;
	}

	public void setTextColor(String textColor) {
		this.textColor = textColor;
	}


	
 	
}
