package com.web.orbitERP.vo;

public class Alram {
/*
 * idx number primary key,
   sender varchar2(50) not null,
   receiver varchar2(50) not null,
   checked varchar(10) default 'N',
   content varchar(500),
   title varchar2(200),
   create_date date
 */
   private int idx;
   private String sender;
   private String receiver;
   private String alcontent;
   private String altitle;
   private String create_date;
   private String color;
   private String icon;
   private String checked;
   private String alcategory;
   private String check_date;
   
   public Alram() {
      // TODO Auto-generated constructor stub
   }


   public Alram(int idx, String sender, String receiver, String alcontent, String altitle, String create_date,
         String color, String icon, String checked, String alcategory) {
      super();
      this.idx = idx;
      this.sender = sender;
      this.receiver = receiver;
      this.alcontent = alcontent;
      this.altitle = altitle;
      this.create_date = create_date;
      this.color = color;
      this.icon = icon;
      this.checked = checked;
      this.alcategory = alcategory;
   }



   public String getAlcontent() {
      return alcontent;
   }


   public void setAlcontent(String alcontent) {
      this.alcontent = alcontent;
   }


   public String getAltitle() {
      return altitle;
   }


   public void setAltitle(String altitle) {
      this.altitle = altitle;
   }


   public String getAlcategory() {
      return alcategory;
   }


   public void setAlcategory(String alcategory) {
      this.alcategory = alcategory;
   }


   public String getChecked() {
      return checked;
   }



   public void setChecked(String checked) {
      this.checked = checked;
   }

   public String getColor() {
      return color;
   }
   
   public void setColor(String color) {
      this.color = color;
   }
   
   public String getIcon() {
      return icon;
   }
   
   public void setIcon(String icon) {
      this.icon = icon;
   }
   
   public int getIdx() {
      return idx;
   }

   public void setIdx(int idx) {
      this.idx = idx;
   }

   public String getSender() {
      return sender;
   }
   public void setSender(String sender) {
      this.sender = sender;
   }
   public String getReceiver() {
      return receiver;
   }
   public void setReceiver(String receiver) {
      this.receiver = receiver;
   }
   public String getCreate_date() {
      return create_date;
   }
   public void setCreate_date(String create_date) {
      this.create_date = create_date;
   }


   public String getCheck_date() {
      return check_date;
   }


   public void setCheck_date(String check_date) {
      this.check_date = check_date;
   }

   
}