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
	private String content;
	private String title;
	private String create_date;
	private String color;
	private String icon;
	private String checked;
	private String category;
	public Alram() {
		// TODO Auto-generated constructor stub
	}
	


	public Alram(int idx, String sender, String receiver, String content, String title, String create_date,
			String color, String icon, String checked, String category) {
		super();
		this.idx = idx;
		this.sender = sender;
		this.receiver = receiver;
		this.content = content;
		this.title = title;
		this.create_date = create_date;
		this.color = color;
		this.icon = icon;
		this.checked = checked;
		this.category = category;
	}



	public String getChecked() {
		return checked;
	}



	public void setChecked(String checked) {
		this.checked = checked;
	}



	public String getCategory() {
		return category;
	}



	public void setCategory(String category) {
		this.category = category;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}

	
}
