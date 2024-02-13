package com.web.orbitERP.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.web.orbitERP.vo.Bulletin;
import com.web.orbitERP.vo.BulletinFile;
import com.web.orbitERP.vo.BulletinSch;

@Mapper
public interface A05_BulletinDao {
	
	// 게시판 총 데이터 건수
	   int totBulletin(BulletinSch sch);

	   // 게시판 양식과 페이징 처리
	   List<Bulletin> bulList(BulletinSch sch);

	   // 게시물 상세정보
	   @Select("select * from bulletin where no=#{no}")
	   Bulletin getBulletin(@Param("no") int no);

	   // 조회수 증가
	   @Update("update bulletin set readcnt = readcnt+1 where no=#{no}")
	   void readCntUptBulletin(@Param("no") int no);

	   // 게시물 등록
	   @Insert("INSERT INTO bulletin values(bulletin_seq.nextval,#{auth},#{title},#{content},sysdate,sysdate,0)")
	   int insertBulletin(Bulletin ins);

	   // 게시물 수정
	   int updateBulletin(Bulletin upt);

	   // 게시물 삭제
	   int deleteBulletin(@Param("no") int no);

	   // 파일 업로드, 공개, 삭제
	     @Insert("INSERT INTO bulletinFile\r\n" +
	     "VALUES(bulletin_seq.currval, #{fname}, #{path}, sysdate, sysdate, #{etc})"
	     ) int insertBulletinFile(BulletinFile ins);
	     
	     @Select("SELECT fname FROM bulletinFile WHERE NO = #{no}") List<String>
	     getBulletinFile(int no);
	     
	     @Delete("DELETE FROM bulletinFile WHERE NO = #{no}") int
	     deleteBulletinFile(@Param("no") int no);
}
