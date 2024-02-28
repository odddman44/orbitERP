package com.web.orbitERP.vo;

public class Enrollment {

   private int enno;
   private int sno;
   private int lecno;
   private int sscore;
   private String empno;
   private String grade;
   public Enrollment() {
      // TODO Auto-generated constructor stub
   }
   
   public Enrollment(int enno, int sno, int lecno, int sscore, String empno, String grade) {
      super();
      this.enno = enno;
      this.sno = sno;
      this.lecno = lecno;
      this.sscore = sscore;
      this.empno = empno;
      this.grade = grade;
   }

   public int getSscore() {
      return sscore;
   }

   public void setSscore(int sscore) {
      this.sscore = sscore;
   }

   public int getEnno() {
      return enno;
   }
   public void setEnno(int enno) {
      this.enno = enno;
   }
   public int getSno() {
      return sno;
   }
   public void setSno(int sno) {
      this.sno = sno;
   }
   public int getLecno() {
      return lecno;
   }
   public void setLecno(int lecno) {
      this.lecno = lecno;
   }
   public String getEmpno() {
      return empno;
   }
   public void setEmpno(String empno) {
      this.empno = empno;
   }
   public String getGrade() {
      return grade;
   }
   public void setGrade(String grade) {
      this.grade = grade;
   }
   
   
   
}