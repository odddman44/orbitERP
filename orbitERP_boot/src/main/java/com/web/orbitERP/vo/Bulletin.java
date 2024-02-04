package com.web.orbitERP.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Bulletin {
	private int cnt;
	private int no;
	private String auth;
	private String title;
	private String content;
	private Date regdte;
	private Date uptdte;
	private int readcnt;
	private MultipartFile[] reports;
	private List<String> fnames;
	
	public MultipartFile[] getReports() {
		return reports;
	}
	public void setReports(MultipartFile[] reports) {
		this.reports = reports;
	}
	public List<String> getFnames() {
		return fnames;
	}
	public void setFnames(List<String> fnames) {
		this.fnames = fnames;
	}
	public Bulletin() {
		// TODO Auto-generated constructor stub
	}
	public Bulletin(int no, String auth, String title, String content, Date regdte, Date uptdte, int readcnt) {
		this.no = no;
		this.auth = auth;
		this.title = title;
		this.content = content;
		this.regdte = regdte;
		this.uptdte = uptdte;
		this.readcnt = readcnt;
	}
	
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
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
	public Date getRegdte() {
		return regdte;
	}
	public void setRegdte(Date regdte) {
		this.regdte = regdte;
	}
	public Date getUptdte() {
		return uptdte;
	}
	public void setUptdte(Date uptdte) {
		this.uptdte = uptdte;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
		
}