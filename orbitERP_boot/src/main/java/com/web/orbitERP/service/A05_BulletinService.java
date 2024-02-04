package com.web.orbitERP.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.web.orbitERP.dao.A05_BulletinDao;
import com.web.orbitERP.vo.Bulletin;
import com.web.orbitERP.vo.BulletinFile;
import com.web.orbitERP.vo.BulletinSch;

@Service
public class A05_BulletinService {
	@Autowired(required = false)
	private A05_BulletinDao dao;

	// 게시판 리스트
		public List<Bulletin> bulList(BulletinSch sch) {
			if (sch.getTitle() == null)
				sch.setTitle("");
			
			  sch.setCount(dao.totBulletin(sch));
			  
			  if(sch.getPageSize()==0) sch.setPageSize(5);
			  
			  sch.setPageCount((int)Math.ceil(sch.getCount()/(double)sch.getPageSize()));
			  
			  if(sch.getCurPage()==0) sch.setCurPage(1);
			  
			  if(sch.getCurPage()>sch.getPageCount()) sch.setCurPage(sch.getPageCount());
			  
			  sch.setEnd(sch.getCurPage()*sch.getPageSize());
			  
			  if(sch.getEnd()>sch.getCount()) { sch.setEnd(sch.getCount() ); }
			  
			  sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
			  
			  sch.setBlockSize(5);
			  
			  int blockNum = (int)Math.ceil(sch.getCurPage()/ (double)sch.getBlockSize());
			  
			  sch.setEndBlock(blockNum*sch.getBlockSize());
			  
			  if(sch.getEndBlock()>sch.getPageCount()) {
			  sch.setEndBlock(sch.getPageCount()); }
			  
			  sch.setStartBlock((blockNum-1)*sch.getBlockSize()+1);
			
			return dao.bulList(sch);
		}

		// 클릭시 출력 상세정보
		public Bulletin getBulletin(int no) {
			Bulletin bulletin = dao.getBulletin(no);
			return bulletin;
		}

		// 상세정보 출력
		public Bulletin getDetailBulletin(int no) {
			// 조회수 증가
			dao.readCntUptBulletin(no);
			return getBulletin(no);
		}

		// 게시물 등록
		public String insertBulletin(Bulletin ins) {
			int ck01 = dao.insertBulletin(ins);
			String msg = ck01 > 0 ? "게시판 등록성공" : "게시판 등록실패";
			return msg;
		}

		// 게시물 수정
		public String updateBulletin(Bulletin upt) {
			return dao.updateBulletin(upt) > 0 ? "수정성공" : "수정실패";
		}

		// 게시물 삭제
		public String deleteBulletin(@Param("no") int no) {
			return dao.deleteBulletin(no) + "건 삭제처리";
		}

}
