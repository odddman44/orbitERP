package com.web.orbitERP.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.orbitERP.service.A03_PRService;
import com.web.orbitERP.vo.Calendar;
import com.web.orbitERP.vo.Enrollment;
import com.web.orbitERP.vo.InsertLecCal;
import com.web.orbitERP.vo.Lecture;
import com.web.orbitERP.vo.LectureStu;
import com.web.orbitERP.vo.LectureTch;

@Controller
public class A03_PRController {

	@Autowired(required = false)
	private A03_PRService service;
	//http://localhost:4444/lectureList
	//http://211.63.89.67:4444/lectureList
	// 강의조회
	@RequestMapping("lectureList")
	public String lectureList(Lecture sch,Model d) {
		d.addAttribute("lecList",service.lectureList(sch));
		return"a03_planResource\\lectureList";
	}
	//강의등록창 열기
	@RequestMapping("lectureInsertFrm")
	public String lectureInsert() {
		return "a03_planResource\\lectureInsert";
	}
	
	//강의등록
	@RequestMapping("lectureInsert")
	public String insertLecture(Lecture ins, Model d) {
		d.addAttribute("msg", 
				service.insertLecture(ins)>0?"등록완료":"등록실패");
		d.addAttribute("lecno",service.getlecno()); //수강테이블에 등록할 강의번호
		return "pageJsonReport";
	}
	//수강테이블 등록
	@RequestMapping("insertEnroll")
	public ResponseEntity<?> insertEnroll(Enrollment ins){
		return ResponseEntity.ok(service.insertEnroll(ins));
	}
	
	// 강의상세
	@RequestMapping("lectureDetail")
	public String lectureDetail(@RequestParam("lecno") int lecno,Model d) {
		d.addAttribute("lecture",service.getLecture(lecno));
		d.addAttribute("tch",service.getTch(lecno));//강의의 강사
		d.addAttribute("stuList",service.getStuList(lecno));//수강중인 학생들
		return"a03_planResource\\lectureDetail";
	}
	//강의수정
	@RequestMapping("lectureUpdate")
	public String lectureUpdate(Lecture upt, Model d) {
		d.addAttribute("msg", 
				service.updateLecture(upt)>0?"수정완료":"수정실패");
		d.addAttribute("msg2", 
				service.deleteEnroll(upt.getLecno())>0?"수강삭제":"삭제실패");
		return "pageJsonReport";
	}
	
	//강의삭제
	@RequestMapping("lectureDelete")
	public String lectureDelete(@RequestParam("lecno") int lecno, Model d) {
		d.addAttribute("msg2", 
				service.deleteEnroll(lecno)>0?"수강삭제":"삭제실패");
		d.addAttribute("msg3",
				service.delLecCal(lecno)>0?"강의스케줄삭제":"강의스케줄삭제실패");
		d.addAttribute("msg", 
				service.deleteLecture(lecno)>0?"강의삭제완료":"삭제실패");
		return "pageJsonReport";
	}
	
	
	
	//학생테이블 검색
	//http://localhost:4444/stuSch	
	@RequestMapping("stuSch")
	public ResponseEntity<?> stuSch(@ModelAttribute("sch") LectureStu sch) {
		//d.addAttribute("studentList", service.getStus(sch));
		return ResponseEntity.ok(service.getStus(sch));
	}
	
	//http://localhost:4444/schTch
	//강사테이블 검색
	@RequestMapping("schTch")
	public String schTch(@ModelAttribute("schT") LectureTch sch, Model d) {
		d.addAttribute("teacherList", service.schTch(sch));
		return "pageJsonReport";
	}
	// 강사 과목리스트
	@ModelAttribute("subjects")
	public List<String> getSubjects(){
		return service.getSubjects();
	}
	// 강사 세션 확인
	//@RequestMapping("sessCk")
	//public ResponseEntity<?> sessCk(String empno){
	//	System.out.println(empno);
	//	return ResponseEntity.ok(service.sessCk(empno));
	//}
	
	/*--강의 캘린더*------------------------------------------------------------------*/
	//http://localhost:4444/lectureCalendar
	//강의캘린더조회
	@GetMapping("lectureCalendar")
	public String lectureCalendar() {
		return"a03_planResource\\lectureCalendar";
	}
	//일정리스트
	//http://localhost:4444/lecCalList
	@GetMapping("lecCalList")
	public String lecCalList(Model d) {
		d.addAttribute("lecCalList",service.lecCalList());
		return "pageJsonReport";
	}
	//캘린더에 강의등록
	@RequestMapping("insLecCal")
	public String insLecCal(InsertLecCal ins,Model d) {
		d.addAttribute("msg",service.insLecCal(ins));
		return "pageJsonReport";
	}
	
	
	
	
	
	
	
	/*--캘린더 컨트롤러-------------------------------------------------------------*/
	//http://localhost:7080/orbitERP/calendar.do
	//http://211.36.89.67:4444/orbitERP/calendar.do
	//캘린더조회
	@RequestMapping("planCalendar")
	public String planCalendar() {
		return"a03_planResource\\planCalendar";
	}
	//일정리스트
	//http://localhost:7080/orbitERP/calList.do
	@GetMapping("calList")
	public String calList(Model d) {
		d.addAttribute("callist",service.getCalList());
		return "pageJsonReport";
	}
	//일정등록
	//http://localhost:7080/springweb/insertCalendar.do
		@GetMapping("insertCalendar")
		public String insertCalendarFrm() {
			return "a01_start\\a17_calendarInsForm";
		}
		@PostMapping("insertCalendar")
		public String insertCalendar(Calendar ins, Model d) {
			// 입력후 등록/성공실패 msg로 가지고 있고.
			d.addAttribute("msg", service.insertCalendar(ins));
			// 등록 후, 전체 데이터 json데이터로 가지고 있음..
			d.addAttribute("callist", service.getCalList());
			return  "pageJsonReport";
		}
		//일정수정
		@PostMapping("updateCalendar")
		public String updateCalendar(Calendar upt, Model d) {
			System.out.println("수정");
			d.addAttribute("msg", service.updateCalendar(upt));
			d.addAttribute("callist", service.getCalList());
			return "pageJsonReport";
		}
		//일정삭제
		@PostMapping("deleteCalendar")
		public String deleteCalendar(int id,Model d) {
			d.addAttribute("msg", service.deleteCalendar(id));
			d.addAttribute("callist", service.getCalList());
			return "pageJsonReport";
		}
		
		
		
		
		
		
		//알람조회
		//http://localhost:4444/alram
		@GetMapping("alram")
		public String alram(String empno,Model d) {
			d.addAttribute("alList",service.alList(empno));
			return"a03_planResource\\alram";
		}
}