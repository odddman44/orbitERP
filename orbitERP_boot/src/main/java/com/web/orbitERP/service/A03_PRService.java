package com.web.orbitERP.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.orbitERP.dao.A03_PRDao;
import com.web.orbitERP.vo.Alram;
import com.web.orbitERP.vo.Calendar;
import com.web.orbitERP.vo.Employee;
import com.web.orbitERP.vo.Enrollment;
import com.web.orbitERP.vo.InsertLecCal;
import com.web.orbitERP.vo.Lecture;
import com.web.orbitERP.vo.LectureCalendar;
import com.web.orbitERP.vo.LectureStu;
import com.web.orbitERP.vo.LectureTch;

@Service
public class A03_PRService {

   @Autowired(required = false)
   private A03_PRDao dao;
   
   public List<Lecture> lectureList(Lecture sch){
      return dao.lectureList(sch);
   }
   public Lecture getLecture(int lecno) {
      return dao.getLecture(lecno);
   }
   public LectureTch getTch(int lecno) {
      return dao.getTch(lecno);
   }
   public List<LectureStu> getStuList(int lecno){
      return dao.getStuList(lecno);
   }
   public int insertLecture(Lecture ins) {
      return dao.insertLecture(ins);
   }
   //수강테이블
   public String insertEnroll(Enrollment ins) {
      return dao.insertEnroll(ins)>0?"등록성공":"등록실패";
   }
   //강의번호 추출
   public int getlecno() {
      return dao.getlecno();
   }
   
   //강의 수정
   public int updateLecture(Lecture upt) {
      return dao.updateLecture(upt);
   }
   //성적 등록
   public String setSscore(Enrollment upt) {
      return dao.setSscore(upt)>0?"등록성공":"등록실패";
   }
   // 수강삭제
   public int deleteEnroll(int lecno) {
      return dao.deleteEnroll(lecno);
   }
   // 강의 삭제
   public int deleteLecture(int lecno) {
      return dao.deleteLecture(lecno);
   }
   
   
   //학생 불러오기
   public List<LectureStu> getStus(LectureStu sch){
      if(sch.getName()==null) sch.setName("");
      if(sch.getFinal_degree()==null) sch.setFinal_degree("");
      //int count=dao.totStudent(sch);
      //sch.setCount(count);
      return dao.getStus(sch);
   }
   //강사 불러오기
   public List<LectureTch> schTch(LectureTch sch){
      if(sch.getEname()==null) sch.setEname("");
      if(sch.getSubject()==null) sch.setSubject("");
      return dao.schTch(sch);
   }
   //강사 과목리스트
   public List<String> getSubjects(){
      return dao.getSubjects();
   }
   // 강사 세션 확인
   //public int sessCk(String empno) {
   //   return dao.sessCk(empno);
   //}
   
   
   
   /*--캘린더 서비스----------------------------------------*/
   public List<Calendar> getCalList() {
      return dao.getCalList();
   }
   public String insertCalendar(Calendar ins) {
      return dao.insertCalendar(ins)>0?"등록성공":"등록실패";
   }
   public String updateCalendar(Calendar upt) {
      return dao.updateCalendar(upt)>0?"수정성공":"수정실패";
   }
   public String deleteCalendar(int id) {
      return dao.deleteCalendar(id)>0?"삭제성공":"삭제실패";
   }
   /*--강의 캘린더 서비스----------------------------------------*/
   public List<LectureCalendar> lecCalList() {
      return dao.lecCalList();
   }
   public int delLecCal(int lecno) {
      return dao.delLecCal(lecno);
   }
   public String insLecCal(InsertLecCal ins) {
      return dao.insLecCal(ins)>0?"캘린더 등록완료":"등록실패";
      
   }
   /*--알림 서비스----------------------------------------*/
   public List<Alram> alList(String receiver) {
      return dao.alList(receiver);
   }
   public List<Alram> alListAll(String receiver) {
      return dao.alListAll(receiver);
   }
   public List<Alram> alListAll2(String sender) {
      return dao.alListAll2(sender);
   }
   public int checkUp(int idx) {
      return dao.checkUp(idx);
   }
   public Alram alDtail(int idx) {
      return dao.alDtail(idx);
   }
   public Employee getSender(String sender) {
      return dao.getSender(sender);
   }
   public List<Employee> empList(Employee sch) {
      if(sch.getEname()==null) sch.setEname("");
      return dao.empList(sch);
   }
   public String sendAlramGo(Alram ins) {
      return dao.sendAlramGo(ins)>0?"전송완료":"전송실패";
   }
   public List<Calendar> myCalList(String writer) {
      return dao.myCalList(writer);
   }
}