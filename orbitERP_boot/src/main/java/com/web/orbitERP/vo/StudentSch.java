package com.web.orbitERP.vo;

import java.util.Date;

public class StudentSch {
	private int sno;
	private String name;
	private String final_degree;
	private Date reg_date;
	
	private int count; // 전체 데이터 건수
	private int pageSize; // 한페이지에 보여줄 데이터 건수
	private int pageCount; // 총페이지수
	private int curPage; // 클릭한 현재 페이지 번호
	private int start; // 현재 시작번호
	private int end; // 현재 마지막번호
	// 3. 페이징처리 2단계(페이징블럭)
	private int blockSize; // 한번에 보여줄 block의 크기
	private int startBlock; // block시작번호
	private int endBlock; // block 마지막번호
	public StudentSch() {
	
	}
	public StudentSch(int sno, String name, String final_degree, Date reg_date, int count, int pageSize, int pageCount,
			int curPage, int start, int end, int blockSize, int startBlock, int endBlock) {
		
		this.sno = sno;
		this.name = name;
		this.final_degree = final_degree;
		this.reg_date = reg_date;
		this.count = count;
		this.pageSize = pageSize;
		this.pageCount = pageCount;
		this.curPage = curPage;
		this.start = start;
		this.end = end;
		this.blockSize = blockSize;
		this.startBlock = startBlock;
		this.endBlock = endBlock;
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
	public String getFinal_degree() {
		return final_degree;
	}
	public void setFinal_degree(String final_degree) {
		this.final_degree = final_degree;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public int getBlockSize() {
		return blockSize;
	}
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
	public int getStartBlock() {
		return startBlock;
	}
	public void setStartBlock(int startBlock) {
		this.startBlock = startBlock;
	}
	public int getEndBlock() {
		return endBlock;
	}
	public void setEndBlock(int endBlock) {
		this.endBlock = endBlock;
	}
	
	
	
}
