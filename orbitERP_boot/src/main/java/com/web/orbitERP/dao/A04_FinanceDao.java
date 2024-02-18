package com.web.orbitERP.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.web.orbitERP.vo.Accsub;
import com.web.orbitERP.vo.AccsubSch;
import com.web.orbitERP.vo.FinanceSummary;
import com.web.orbitERP.vo.GrossProfit;
import com.web.orbitERP.vo.IncomeStatement;
import com.web.orbitERP.vo.Journalizing;
import com.web.orbitERP.vo.Voucher;
import com.web.orbitERP.vo.VoucherDetail;

// orbitERP.a03_dao.A04_FinanceDao
@Mapper
public interface A04_FinanceDao {
	/***********************
	 *  1. 계정과목관련  *
	 **********************/
	// 검색값 갯수 조회
	int totAccsub(AccsubSch sch);
	// 계정과목 검색값으로 조회(페이징처리 연결)
	List<Accsub> accsubList(AccsubSch sch);
	
	// 계정과목 등록
	int insertAccsub(Accsub ins);
	
	// 계정과목 수정창용 상세조회
	Accsub getAccsub(@Param("acc_code") int acc_code);
	// 수정 처리
	int updateAccsub(Accsub upt);
	// 삭제 처리
	int deleteAccsub(@Param("acc_code") int acc_code);
	
	// 계정코드 중복확인
	int countAccCode(int accCode);
	
	/***********************
	 *  2. 전표관련  *
	 **********************/
	// 전표 조회
	List<Voucher> voucherList(@Param("startDate") String startDate, @Param("endDate") String endDate,
								@Param("voucher_type") String voucher_type);
	
	
	// 전표 상세 조회
    VoucherDetail getVoucherDetail(int voucher_id);
    
    // 모달용 계정리스트
    @Select("SELECT acc_code, acc_name, debit_credit, acc_type\r\n"
    		+ "FROM ACCSUB\r\n"
    		+ "WHERE ACTIVE_STATUS = 'Y'\r\n"
    		+ "ORDER BY acc_code ASC")
    List<Accsub> accsubModal(Accsub acc);
    
    // 전표등록
    int insertVoucher(VoucherDetail ins);
    // 분개 등록
    int insertJournalizing(Journalizing ins);
    
    // 전표 수정
    int updateVoucher(VoucherDetail upt);
    // 분개 수정
    int updateJournalizing(Journalizing upt);
    
    // 선택한 전표들 다중 삭제
    int deleteJournalizings(List<Integer> voucherIds);
    int deleteVouchers(List<Integer> voucherIds);
    
    
	/***********************
	 *  3. 경영보고서관련  *
	 **********************/
    // 매출매입그래프
    List<FinanceSummary> getSalesAndPurchasesSummaryByYear(@Param("year") int year);
    
    List<GrossProfit> getGrossProfit(@Param("deptno") int deptno, @Param("startDate") String startDate, @Param("endDate") String endDate);
    
    // 손익계산서
    List<IncomeStatement> getIncomeStatements(@Param("basicYear") String basicYear,
    										@Param("compYear") String compYear);
    
    // 손익 선그래프
    List<FinanceSummary> getNetIncomeGraph(@Param("year") int year);
}
