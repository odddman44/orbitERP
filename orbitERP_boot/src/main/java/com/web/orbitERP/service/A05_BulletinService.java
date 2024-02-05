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
	      if (sch.getPageSize() == 0)
	         sch.setPageSize(5);
	      sch.setPageCount((int) Math.ceil(sch.getCount() / (double) sch.getPageSize()));
	      if (sch.getCurPage() == 0)
	         sch.setCurPage(1);
	      if (sch.getCurPage() > sch.getPageCount())
	         sch.setCurPage(sch.getPageCount());
	      sch.setEnd(sch.getCurPage() * sch.getPageSize());
	      if (sch.getEnd() > sch.getCount()) {
	         sch.setEnd(sch.getCount());
	      }
	      sch.setStart((sch.getCurPage() - 1) * sch.getPageSize() + 1);
	      sch.setBlockSize(5);
	      int blockNum = (int) Math.ceil(sch.getCurPage() / (double) sch.getBlockSize());
	      sch.setEndBlock(blockNum * sch.getBlockSize());
	      if (sch.getEndBlock() > sch.getPageCount()) {
	         sch.setEndBlock(sch.getPageCount());
	      }
	      sch.setStartBlock((blockNum - 1) * sch.getBlockSize() + 1);
	      return dao.bulList(sch);
	   }

	   // 클릭시 출력 상세정보
	   public Bulletin getBulletin(int no) {
	      Bulletin bulletin = dao.getBulletin(no);
	      bulletin.setFnames(dao.getBulletinFile(no));
	      return bulletin;
	   }

	   // 상세정보 출력
	   public Bulletin getDetailBulletin(int no) {
	      // 조회수 증가
	      dao.readCntUptBulletin(no);
	      return getBulletin(no);
	   }

	   // 게시물 등록
	   @Value("${file.upload3}")
	   private String path;
	   

	   public String insertBulletin(Bulletin ins) {
	      int ck01 = dao.insertBulletin(ins);
	      String msg = ck01 > 0 ? "게시판 등록성공" : "게시판 등록실패";
	      
	      int ck02 = 0;
	      MultipartFile[] mpfs = ins.getReports();

	      if (mpfs != null && mpfs.length > 0) {

	         try {
	            for (MultipartFile mpf : mpfs) {
	               String fname = mpf.getOriginalFilename();
	               mpf.transferTo(new File(path + fname));
	               ck02 += dao.insertBulletinFile(new BulletinFile(fname,path,ins.getTitle()));
	            }
	         } catch (IllegalStateException e) {
	            System.out.println("#파일업로드 예외1:" + e.getMessage());
	            msg += "#파일업로드 예외1:" + e.getMessage() + "\\n";
	         } catch (IOException e) {
	            System.out.println("#파일업로드 예외2:" + e.getMessage());
	            msg += "#파일업로드 예외2:" + e.getMessage() + "\\n";
	         } catch (Exception e) {
	            System.out.println("#기타 예외3:" + e.getMessage());
	            msg += "#기타 예외3:" + e.getMessage() + "\\n";
	         }
	         msg += "파일 " + ck02 + "건 등록 완료";
	      }
	      
	      return msg;
	   }

	   // 게시물 수정
	   public String updateBulletin(Bulletin upt) {
	      return dao.updateBulletin(upt) > 0 ? "수정성공" : "수정실패";
	   }

	   // 게시물 삭제
	   public String deleteBulletin(@Param("no") int no) {
	      
	      List<String> delFnames = dao.getBulletinFile(no);
	      for(String fname:delFnames) {
	         // 2. 경로명과 파일명과 함께 파일 객체 생성
	         File fileToDelete = new File(path+fname);
	         // 3. 파일이 존재할 때, 물리적으로 해당 파일 삭제처리..
	         if(fileToDelete.exists()) fileToDelete.delete();
	      }
	      
	      int ck01 = dao.deleteBulletin(no);
	      int ck02 = dao.deleteBulletinFile(no);
	      String msg = ck01>0?"게시판번호 "+no+" 삭제 성공":"삭제 실패"; 
	      
	      if( ck02>0 ) {
	         msg+="\\n";
	         msg+="등록 파일 "+ck02+"건 삭제";
	      }
	      
	      return msg;
	   }

}
