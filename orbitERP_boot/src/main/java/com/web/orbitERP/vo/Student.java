package com.web.orbitERP.vo;



import org.springframework.web.multipart.MultipartFile;

public class Student {
	 private int sno;
	 private String name;
	 private String birth;
	 private String final_degree;
	 private String phone;
	 private String address;
	 private String account;
	 private String reg_date;
	 private MultipartFile profile;
	
	

	public MultipartFile getProfile() {
		return profile;
	}
	public void setProfile(MultipartFile profile) {
		this.profile = profile;
	}
	public Student() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Student(int sno, String name, String birth, String final_degree, String phone, String address, String account,
			String reg_date) {
		this.sno = sno;
		this.name = name;
		this.birth = birth;
		this.final_degree = final_degree;
		this.phone = phone;
		this.address = address;
		this.account = account;
		this.reg_date = reg_date;
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
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	
	
	 
	 
}
