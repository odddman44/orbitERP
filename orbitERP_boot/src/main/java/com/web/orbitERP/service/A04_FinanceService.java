package com.web.orbitERP.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.orbitERP.dao.A04_FinanceDao;
import com.web.orbitERP.vo.Accsub;
import com.web.orbitERP.vo.AccsubSch;
import com.web.orbitERP.vo.FinanceSummary;
import com.web.orbitERP.vo.GrossProfit;
import com.web.orbitERP.vo.IncomeStatement;
import com.web.orbitERP.vo.Journalizing;
import com.web.orbitERP.vo.Voucher;
import com.web.orbitERP.vo.VoucherDetail;


@Service
public class A04_FinanceService {
	@Autowired(required = false)
	private A04_FinanceDao dao;
	
	public List<Accsub> accsubList(AccsubSch sch){
		if(sch.getAcc_name()==null) sch.setAcc_name("");
		if(sch.getAcc_type()==null) sch.setAcc_type("");
		if(sch.getBase_acc()==null) sch.setBase_acc("");
		// 1. 전체데이터 건수 설정
		sch.setCount(dao.totAccsub(sch));
		// 2. 한번에 보여줄 페이지 크기 지정
		// (화면에서 요청값을 지정하지 않으면 5건이 한페이지 단위)
		if(sch.getPageSize()==0) sch.setPageSize(10);
		// 3. 총페이지수 [1][2][3][4][5][6]
		sch.setPageCount((int)Math.ceil(sch.getCount()/(double)sch.getPageSize()));
		// 4. 클릭한 현재 페이지 번호(초기화면에는 default로 1로 설정)
		//		마지막페이지에서 next를 눌렀을 때, 더이상 curpage가 증가하지 않게 처리
		if(sch.getCurPage()>sch.getPageCount())
			sch.setCurPage(sch.getPageCount());
		if(sch.getCurPage()==0) sch.setCurPage(1);
		// 5. 페이지의 마지막 번호는 현재 클릭한 페이지번호 * 페이지당 보일 데이터 건수
		sch.setEnd(sch.getCurPage()*sch.getPageSize());
		if(sch.getEnd()>sch.getCount()) {
			sch.setEnd(sch.getCount());
		}
		// 6. 페이지의 시작 번호는 (현재클릭한 페이지번호 -1) * 페이지당 보일 데이터건수 +1
		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1); 
		
		// 7. 블럭사이즈 지정(고정)
		sch.setBlockSize(5);
		// 8. 클릭한 현재 페이지번호 기준으로 블럭번호 처리
		int blockNum = (int)Math.ceil((double)sch.getCurPage()/
				sch.getBlockSize());
		// 9. 마지막 블럭번호
		sch.setEndBlock(blockNum * sch.getBlockSize());
		if(sch.getEndBlock()>sch.getPageCount()) {
			sch.setEndBlock(sch.getPageCount());
		}
		// 10. 시작블럭번호
		sch.setStartBlock((blockNum-1)*sch.getBlockSize()+1);
		
		return dao.accsubList(sch);
	}
	
	// 계정과목 등록
	public String insertAccsub(Accsub ins) {
		String msg ="";
		int result = dao.insertAccsub(ins);
		if(result>0) {
			msg = "계정과목 등록 성공";
		}else {
			msg = "계정과목 등록 실패";
		}
		return msg;
	}
	
	// 계정과목 상세화면
	public Accsub getAccsub(int acc_code) {
		Accsub accsub = dao.getAccsub(acc_code);
		return accsub;
	}
	// 계정과목 수정
	public String updateAccsub(Accsub upt) {
		return dao.updateAccsub(upt)>0?"수정성공":"수정실패";
	}
	// 계정과목 삭제
	public String deleteAccsub(int acc_code) {
		return dao.deleteAccsub(acc_code)>0?"과목코드 "+acc_code+"번 삭제 성공":"삭제 실패";
	}
	// 계정코드 중복 확인
	public boolean checkAccCodeDuplication(int accCode) {
	    return dao.countAccCode(accCode) > 0;
	}
	
	/*
	 * 2. 전표 조회 관련
	 * */
	public List<Voucher> voucherList(String startDate, String endDate, String voucher_type){
		// 현재 날짜를 'YYYY-MM-DD' 형식의 문자열로 변환
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    String currentDate = sdf.format(new Date());

	    // 시작 날짜가 설정되지 않은 경우 전체 검색을 위해 적당한 초기값 설정
	    if (startDate == null || startDate.isEmpty()) {
	        startDate = "2023-01-01";
	    }

	    // 종료 날짜가 설정되지 않은 경우 현재 날짜를 기본값으로 설정
	    if (endDate == null || endDate.isEmpty()) {
	        endDate = currentDate;
	    }
	    if(voucher_type == null) voucher_type = "";
	    
	    return dao.voucherList(startDate, endDate, voucher_type);
	}
	
	
	// 전표 상세조회
	public VoucherDetail getVoucherDetail(int voucher_id) {
		System.out.println("조회:"+dao.getVoucherDetail(voucher_id));
        return dao.getVoucherDetail(voucher_id);
    }
	
	// 모달용 계정리스트
    public List<Accsub> accsubModal(Accsub acc){
    	return dao.accsubModal(acc);
    }
	
    // 전표 등록
    @Transactional
    public void insertVoucher(VoucherDetail ins) {
    	dao.insertVoucher(ins); // 전표 등록
    	for (Journalizing j : ins.getJournalizings()) {
            j.setVoucher_id(ins.getVoucher_id()); // 새로 삽입된 전표의 ID를 설정
            dao.insertJournalizing(j);
        }
    }
    
    // 전표 및 분개 수정
    @Transactional
    public void updateVoucher(VoucherDetail upt) {
        dao.updateVoucher(upt); // 전표 수정
        for (Journalizing j : upt.getJournalizings()) {
            dao.updateJournalizing(j); // 분개 수정
        }
    }
    // 전표 다중 삭제
    @Transactional
    public void deleteVouchers(List<Integer> voucherIds) {
    	// 먼저 연결된 분개 삭제
    	dao.deleteJournalizings(voucherIds);
    	// 그 다음 전표 삭제
        dao.deleteVouchers(voucherIds);
    }
    
	/*
	 * 3. 경영자보고서 관련
	 * */
    // 매출매입 그래프
    public List<FinanceSummary> getSalesAndPurchasesSummaryByYear(int year) {
    	List<FinanceSummary> summary = dao.getSalesAndPurchasesSummaryByYear(year);
    	// System.out.println("조회된 금융 요약 데이터: " + summary);
        return summary;
    }
    
    // 매출총이익 테이블
    public List<GrossProfit> getGrossProfit(int deptno, String startDate, String endDate){
    	return dao.getGrossProfit(deptno, startDate, endDate);
    }
    
    // 손익계산서
    public List<IncomeStatement> getIncomeStatements(String basicYear, String compYear){
    	return dao.getIncomeStatements(basicYear, compYear);
    }
    
    // 손익 선그래프
    public List<FinanceSummary> getNetIncomeGraph(int year) {
        return dao.getNetIncomeGraph(year);
    }
    
}
