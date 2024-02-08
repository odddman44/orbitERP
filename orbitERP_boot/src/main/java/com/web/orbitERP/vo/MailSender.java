package com.web.orbitERP.vo;

public class MailSender {
	private String receiver;
	private String sender;
	private String title;
	private String content;
	public MailSender() {
		// TODO Auto-generated constructor stub
	}
	public MailSender(String receiver, String sender, String title, String content) {
		this.receiver = receiver;
		this.sender = sender;
		this.title = title;
		this.content = content;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
