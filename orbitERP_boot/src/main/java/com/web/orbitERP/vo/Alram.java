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
	private String sender;
	private String receiver;
	private String content;
	private String title;
	private String create_date;
	public Alram() {
		// TODO Auto-generated constructor stub
	}
	public Alram(String sender, String receiver, String content, String title, String create_date) {
		super();
		this.sender = sender;
		this.receiver = receiver;
		this.content = content;
		this.title = title;
		this.create_date = create_date;
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
