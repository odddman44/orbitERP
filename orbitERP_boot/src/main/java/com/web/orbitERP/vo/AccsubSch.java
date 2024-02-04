package com.web.orbitERP.vo;

public class AccsubSch {
	// 1. 검색값
	private int acc_code;
	private String acc_name;
	private String acc_type;
	private String base_acc;
	// 2. 페이징처리 1단계
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
	public AccsubSch() {
		// TODO Auto-generated constructor stub
	}
	public AccsubSch(int acc_code, String acc_name, String acc_type, String base_acc, int count, int pageSize,
			int pageCount, int curPage, int start, int end, int blockSize, int startBlock, int endBlock) {
		this.acc_code = acc_code;
		this.acc_name = acc_name;
		this.acc_type = acc_type;
		this.base_acc = base_acc;
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
	
	public String getBase_acc() {
		return base_acc;
	}
	public void setBase_acc(String base_acc) {
		this.base_acc = base_acc;
	}
	public int getAcc_code() {
		return acc_code;
	}
	public void setAcc_code(int acc_code) {
		this.acc_code = acc_code;
	}
	public String getAcc_name() {
		return acc_name;
	}
	public void setAcc_name(String acc_name) {
		this.acc_name = acc_name;
	}
	public String getAcc_type() {
		return acc_type;
	}
	public void setAcc_type(String acc_type) {
		this.acc_type = acc_type;
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
