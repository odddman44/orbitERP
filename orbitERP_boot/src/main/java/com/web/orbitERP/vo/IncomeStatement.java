package com.web.orbitERP.vo;

// com.web.orbitERP.vo.IncomeStatement
public class IncomeStatement {
	private Integer acc_code;
    private Long basicYearSum;
    private Long compYearSum;
	public IncomeStatement() {
		super();
		// TODO Auto-generated constructor stub
	}
	public IncomeStatement(Integer acc_code, Long basicYearSum, Long compYearSum) {
		super();
		this.acc_code = acc_code;
		this.basicYearSum = basicYearSum;
		this.compYearSum = compYearSum;
	}
	public Integer getAcc_code() {
		return acc_code;
	}
	public void setAcc_code(Integer acc_code) {
		this.acc_code = acc_code;
	}
	public Long getBasicYearSum() {
		return basicYearSum;
	}
	public void setBasicYearSum(Long basicYearSum) {
		this.basicYearSum = basicYearSum;
	}
	public Long getCompYearSum() {
		return compYearSum;
	}
	public void setCompYearSum(Long compYearSum) {
		this.compYearSum = compYearSum;
	}
    
    
}
