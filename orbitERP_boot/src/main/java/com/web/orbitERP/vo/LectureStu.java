package com.web.orbitERP.vo;

public class LectureStu {

    private int sno;
    private String name;
    private String birth;
    private String final_degree;
    private String phone;
    private String address;
    private String grade; //값을 전달하기 위해 추가함
    private int sscore; //값을 전달하기 위해 추가함
    

   public LectureStu() {
      // TODO Auto-generated constructor stub
   }
   
   public LectureStu(int sno, String name, String birth, String final_degree, String phone, String address) {
      this.sno = sno;
      this.name = name;
      this.birth = birth;
      this.final_degree = final_degree;
      this.phone = phone;
      this.address = address;
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

   public String getGrade() {
      return grade;
   }

   public void setGrade(String grade) {
      this.grade = grade;
   }

   public int getSscore() {
      return sscore;
   }

   public void setSscore(int sscore) {
      this.sscore = sscore;
   }
    
}