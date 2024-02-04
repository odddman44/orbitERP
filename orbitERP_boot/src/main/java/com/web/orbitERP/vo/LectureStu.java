package com.web.orbitERP.vo;

public class LectureStu {

	 private int sno;
	 private String name;
	 private String birth;
	 private String final_degree;
	 private String phone;
	 private String address;
	 private int count;
	 
	public LectureStu() {
		// TODO Auto-generated constructor stub
	}
	
	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public LectureStu(int sno, String name, String birth, String final_degree, String phone, String address,
			int count) {
		this.sno = sno;
		this.name = name;
		this.birth = birth;
		this.final_degree = final_degree;
		this.phone = phone;
		this.address = address;
		this.count = count;
	}

	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getFinal_degree() {
		return final_degree;
	}
	public void setFinal_degree(String final_degree) {
		this.final_degree = final_degree;
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
	 
}
