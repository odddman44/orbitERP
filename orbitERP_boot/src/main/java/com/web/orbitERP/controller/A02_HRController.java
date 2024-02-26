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

import com.web.orbitERP.service.A02_HRService;
import com.web.orbitERP.vo.AttendanceSch;
import com.web.orbitERP.vo.Dept;
import com.web.orbitERP.vo.EmpProfile;
import com.web.orbitERP.vo.EmpSch;
import com.web.orbitERP.vo.Employee;
import com.web.orbitERP.vo.Paystub;
import com.web.orbitERP.vo.Salary;
import com.web.orbitERP.vo.SalarySch;
import com.web.orbitERP.vo.StuProfile;
import com.web.orbitERP.vo.Student;
import com.web.orbitERP.vo.StudentSch;

@Controller
public class A02_HRController {
	@Autowired(required = false)
	private A02_HRService service;
	// 부서 정보 조회 ㅎㅎ

	// http://localhost:4444/deptList
	// http://211.63.89.67:4444/deptList.do

	@RequestMapping("deptList")
	public String deptList(Dept sch, Model d) {
		d.addAttribute("deptList", service.getDeptList(sch));
		return "a02_humanResource\\a01_deptList2";
	}
	
	@ModelAttribute("dlist")
	public List<Dept> getDeptList(){
		return service.getDeptList(new Dept());
	}
	
	// http://localhost:4444/elist
	@GetMapping("elist")
	public ResponseEntity<?> getEmpListByDeptno(int deptno){
		System.out.println("전달받은 deptno"+deptno);
		return ResponseEntity.ok(service.getEmpListByDeptno(deptno));
	}


	// 부서 상세 정보
	// http://localhost:4444/deptDetail
	@RequestMapping("deptDetail")
	public String deptDetail(@RequestParam(name = "deptno", defaultValue = "0") int deptno, Model d) {
		d.addAttribute("dept", service.detailDept(deptno));
		System.out.println("전달받은 deptno값:" + deptno);
		return "a02_humanResource\\a02_deptDetail";
	}

	// 부서 등록
	// http://localhost:4444/orbitERP/insertDept
	@RequestMapping("insertDept")
	public String insetDept(@ModelAttribute("ins") Dept ins,
			@RequestParam(name = "isChecked", defaultValue = "N") String isChecked, Model d) {
		d.addAttribute("isInsert", service.insertDept(ins));
		return "pageJsonReport";
	}

	// teplete test용
	// http://localhost:4444/test
	@RequestMapping("test")
	public String test() {
		return "a02_humanResource\\a10_buttons";
	}

	// http://localhost:4444/duplicateDeptno.
	@GetMapping("duplicateDeptno")
	public String dupCheckDeptno(@RequestParam(name = "deptno", defaultValue = "0") int deptno, Model d) {
		d.addAttribute("isExist", service.checkExistDept(deptno));
		return "pageJsonReport";
	}

	@GetMapping("deleteDept")
	public String deleteDept(@RequestParam(name = "deptno", defaultValue = "0") int deptno, Model d) {
		d.addAttribute("isDel", service.deleteDept(deptno));
		return "pageJsonReport";
	}

	// 부서정보 수정
	// http://localhost:4444/updateDept
	@RequestMapping("updateDept")
	public String updateDept(Dept upt, Model d) {
		d.addAttribute("isUpt", service.updateDept(upt));
		return "pageJsonReport";
	}

	// http://localhost:4444/studentList
	@RequestMapping("studentList")
	public String studentList(@ModelAttribute("sch") StudentSch sch, Model d,
			@RequestParam(value = "msg", required = false) String msg) {
		d.addAttribute("msg", msg);
		d.addAttribute("studentList", service.getStudentList(sch));

		return "a02_humanResource\\a03_studentList";
	}

	// http://localhost:4444/detailStudent
	@RequestMapping("detailStudent")
	public String studentList(@RequestParam("sno") int sno, Model d) {

		if (service.getStuProfile(sno) != null) {
			StuProfile profile = service.getStuProfile(sno);
			d.addAttribute("fname", profile.getFname());
		}
		d.addAttribute("student", service.studentDetail(sno));

		return "a02_humanResource\\a04_studentDetail";
	}

	@GetMapping("insertStudent")
	public String insertStudentGet() {

		return "a02_humanResource\\a03_studentList";
	}

	@PostMapping("insertStudent")
	public String insertStudent(Student ins, Model d) {
		d.addAttribute("msg", service.insertStudent(ins));

		return "a02_humanResource\\a03_studentList";
	}

	@RequestMapping("deleteStudent")
	public String deleteStudet(@RequestParam("sno") int sno, Model d) {
		d.addAttribute("isDel", service.deleteStudent(sno));
		return "pageJsonReport";

	}

	@GetMapping("updateStudent")
	public String updateStudentGet() {
		return "a02_humanResource\\a04_studentDetail";
	}

	@PostMapping("updateStudent")
	public String updateStudent(Student upt, Model d) {

		d.addAttribute("msg", service.updateStudent(upt));
		return "a02_humanResource\\a04_studentDetail";

	}

	// http://localhost:4444/empList
	@RequestMapping("empList")
	public String empList(@ModelAttribute("sch") EmpSch sch, Model d) {
		d.addAttribute("empList", service.getEmpList(sch));
		return "a02_humanResource\\a05_empList_copy";
	}
	

	
	// http://localhost:4444/detailEmp
	@GetMapping("detailEmp")
	public String detailEmp(String empno, Model d) {
		d.addAttribute("employee", service.empDetail(empno));
		d.addAttribute("dept", service.detailDept(service.empDetail(empno).getDeptno()));
		if (service.getEmpProfie(empno) != null) {
			EmpProfile profile = service.getEmpProfie(empno);
			d.addAttribute("fname", profile.getFname());
			System.out.println(profile.getEmpno()+"사원의 파일명"+profile.getFname());
		}
		System.out.println("사원정보 상세");
		return "a02_humanResource\\a06_empDetail";

	}
	
	@PostMapping("empUpdate")
	public String empUpdate(Employee upt, Model d) {
		d.addAttribute("proc", "upt");
		d.addAttribute("msg", service.empUpdate(upt));
		d.addAttribute("employee", service.empDetail(upt.getEmpno()));
		d.addAttribute("dept", service.detailDept(service.empDetail(upt.getEmpno()).getDeptno()));
		return "a02_humanResource\\a06_empDetail";
	}
	
	@PostMapping("empInsert")
	public String empInsert(Employee ins, 
	                        @RequestParam(name = "ckempno", defaultValue = "N") String ckempno,
	                        Model d) {
	    d.addAttribute("msg", service.empInsert(ins));
	    return "a02_humanResource/a05_empList_copy"; // 슬래시(\) 대신 슬래시(/)를 사용합니다.
	}
	
	@GetMapping("deleteEmp")
	public String deleteEmp(@RequestParam("empno") String empno, Model d) {
		d.addAttribute("proc", "del");
		d.addAttribute("msg", service.deleteEmp(empno));
		return "a02_humanResource\\a06_empDetail";
	}
	
	@GetMapping("checkEmpno")
	public ResponseEntity<?> checkEmpno(@RequestParam("empno") String empno){
		return ResponseEntity.ok(service.ckEmpno(empno));
	}
	
	// http://localhost:4444/attendanceList
	@RequestMapping("attendanceList")
	public String attendanceList(AttendanceSch sch, Model d) {
		System.out.println("근태 데이터 건수: "+service.getAttenList(sch).size());
		d.addAttribute("attendanceList", service.getAttenList(sch));
		return "a02_humanResource\\a07_attendanceManagement";
	}
	
	@ModelAttribute("empnoList")
	public List<String> getEmpnoList(){
		return service.getEmpnoList();
	}
	
	
	@RequestMapping("checkIn")
	public ResponseEntity<?> checkIn(@RequestParam("empno") String empno) {
		return ResponseEntity.ok(service.checkIn(empno));
	}
	
	@RequestMapping("isExitsCheckIn")
	public ResponseEntity<?> isExitsCheckIn(@RequestParam("work_date") String work_date, @RequestParam("empno") String empno) {
		return ResponseEntity.ok(service.isExitsCheckIn(work_date, empno));
	}
	
	@RequestMapping("checkOut")
	public ResponseEntity<?> checkOut(@RequestParam("work_date") String work_date, @RequestParam("empno") String empno) {
		return ResponseEntity.ok(service.checkOut(work_date, empno));
		
	}
	
	// http://localhost:4444/salaryManage
	@RequestMapping("salaryManage")
	public String salaryManage() {
		return "a02_humanResource\\a11_salaryManagement";
	}
	
	// http://localhost:4444/salaryList
	@RequestMapping("salaryList")
	public ResponseEntity<?> SalaryList(@ModelAttribute("sch") SalarySch sch) {
		List<SalarySch> salary = service.getSalaryList(sch);
		return ResponseEntity.ok(salary);
	}
	
	@PostMapping("insertSalary")
	public ResponseEntity<?> insertSalary(Salary ins){
		return ResponseEntity.ok(service.insertSalary(ins));
	}
	
	@RequestMapping("salaryDetail") 
	public ResponseEntity<?> salaryDetail(@RequestParam("empno") String empno, @RequestParam("payment_dateStr") String payment_dateStr){
		return ResponseEntity.ok(service.salaryDetail(empno, payment_dateStr));
	}
	
	@PostMapping("detailAttendance")
	public ResponseEntity<?> detailAttendance(@RequestParam("work_date") String work_date,
									@RequestParam("empno") String empno){
		return ResponseEntity.ok(service.detailAttendance(work_date, empno));
	}
	
	@PostMapping("updateSalary")
	public ResponseEntity<?> updateSalary(Salary upt){
		
		return ResponseEntity.ok(service.updateSalary(upt));
	}
	
	@PostMapping("deleteSalary")
	public ResponseEntity<?> deleteSalary(@RequestParam("empno") String empno, @RequestParam("payment_dateStr") String payment_dateStr){
		return ResponseEntity.ok(service.deleteSalary(empno, payment_dateStr));
	}
	
	@RequestMapping("salDuplicationCheck")
	public ResponseEntity<?> salDuplicationCheck(@RequestParam("empno") String empno, @RequestParam("payment_dateStr") String payment_dateStr){
	    return ResponseEntity.ok(service.salDuplicationCheck(empno, payment_dateStr));
	}
	
	// http://localhost:4444/paystubList
	@RequestMapping("paystubList")
	public ResponseEntity<?> getPaystubList(@RequestParam("deptno") int deptno, 
	                                         @RequestParam("year") int year ,
	                                         @RequestParam("month") int month){
	    return ResponseEntity.ok(service.getPaystubList(deptno, year, month));
	}
	
	// http://localhost:4444/insertPaystubFrm
	@RequestMapping("insertPaystubFrm")
	public String insertPaystubFrm() {
		return "a02_humanResource\\z04_paystubInsert";
	}
	
	@RequestMapping("insertPayStub")
	public ResponseEntity<?> insertPaystub(Paystub ins){
		
		// 기존 정보 삭제
		String payment_dateStr = ins.getPayment_dateStr();
		int deptno = ins.getDeptno();
		
		service.deletePaystub(payment_dateStr, deptno);
		return ResponseEntity.ok(service.insertPaystub(ins));
	}
	
	// http://localhost:4444/detailPaystubFrm
	// 모델 데이터로 처리
		@RequestMapping("updatePaystubFrm")
		public String updatePaystubFrm(@RequestParam("payment_dateStr") String payment_dateStr,
										@RequestParam("deptno") int deptno, Model d) {
			d.addAttribute("paystubList", service.getPaystubDetail(payment_dateStr, deptno));
			return "a02_humanResource\\z05_paystubUpdate";
		}
	// json 버전으로 데이터 가져오기
		// http://localhost:4444/detailPaystubFrmJson	
	@RequestMapping("updatePaystubFrmJson")
	public ResponseEntity<?> updatePaystubFrmJson(@RequestParam("payment_dateStr") String payment_dateStr,
			@RequestParam("deptno") int deptno){
		return ResponseEntity.ok(service.getPaystubDetail(payment_dateStr, deptno));
	}
	@RequestMapping("deletePaystub")
	public ResponseEntity<?> deletePaystub(@RequestParam("payment_dateStr") String payment_dateStr,
											@RequestParam("deptno") int deptno){
		return ResponseEntity.ok(service.deletePaystub(payment_dateStr, deptno));
	}
	
	@RequestMapping("updatePaystub")
	public ResponseEntity<?> updatePaystub(Paystub upt){
		return ResponseEntity.ok(service.updatePaystub(upt));
	}
	
	
	

	

	

	
	
	
	
	
	

}
