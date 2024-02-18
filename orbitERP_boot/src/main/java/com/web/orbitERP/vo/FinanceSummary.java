package com.web.orbitERP.vo;

import java.math.BigDecimal;

public class FinanceSummary {
	private int month;
	private BigDecimal sales;
    private BigDecimal purchases;
    private BigDecimal netincomes; 
	public FinanceSummary() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public FinanceSummary(int month, BigDecimal sales, BigDecimal purchases, BigDecimal netincomes) {
		super();
		this.month = month;
		this.sales = sales;
		this.purchases = purchases;
		this.netincomes = netincomes;
	}
	public FinanceSummary(int month, BigDecimal sales, BigDecimal purchases) {
		super();
		this.month = month;
		this.sales = sales;
		this.purchases = purchases;
	}
	
	public BigDecimal getNetincomes() {
		return netincomes;
	}

	public void setNetincomes(BigDecimal netincomes) {
		this.netincomes = netincomes;
	}

	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public BigDecimal getSales() {
		return sales;
	}
	public void setSales(BigDecimal sales) {
		this.sales = sales;
	}
	public BigDecimal getPurchases() {
		return purchases;
	}
	public void setPurchases(BigDecimal purchases) {
		this.purchases = purchases;
	}
    
    
}
