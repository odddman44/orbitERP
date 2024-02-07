package com.web.orbitERP.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.web.orbitERP.vo.Calendar;
import com.web.orbitERP.vo.Enrollment;
import com.web.orbitERP.vo.Lecture;
import com.web.orbitERP.vo.LectureStu;
import com.web.orbitERP.vo.LectureTch;
@Mapper
public interface A03_PRDao {

	List<Lecture> lectureList(Lecture sch);
	Lecture getLecture(@Param("lecno") int lecno);
	LectureTch getTch(@Param("lecno") int lecno); // 강사조회
	List<LectureStu> getStuList(@Param("lecno") int lecno);//학생조회
	int insertLecture(Lecture ins);
	int updateLecture(Lecture upt);
	int deleteLecture(@Param("lecno") int lecno);
	int deleteEnroll(@Param("lecno") int lecno);
	
	
	//학생정보 불러오기	
	List<LectureStu> getStus(LectureStu sch);
	//int totStudent(LectureStu sch);
	//강사정보 불러오기	
	List<LectureTch> schTch(LectureTch sch);
	//강사 과목리스트
	@Select("SELECT  DISTINCT subject\r\n"
			+ "FROM EMPLOYEE\r\n"
			+ "WHERE JOB LIKE '강사'\r\n"
			+ "ORDER BY subject")
	List<String> getSubjects();
	
	//수강테이블 등록
	int insertEnroll(Enrollment ins);
	//강의번호 추출
	@Select("SELECT lecno_seq.CURRVAL FROM DUAL")
	int getlecno();
	
	/*--캘린더 dao-------------------------------------------------------------*/
	List<Calendar> getCalList();
	int insertCalendar(Calendar ins);
	int updateCalendar(Calendar upt);
	@Delete("delete from calendar where id = #{id}")
	int deleteCalendar(int id);
}
