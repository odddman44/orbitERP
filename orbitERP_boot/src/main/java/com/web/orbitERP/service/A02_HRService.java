package com.web.orbitERP.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.web.orbitERP.dao.A02_HRDao;
import com.web.orbitERP.vo.Attendance;
import com.web.orbitERP.vo.AttendanceSch;
import com.web.orbitERP.vo.Dept;
import com.web.orbitERP.vo.EmpProfile;
import com.web.orbitERP.vo.EmpSch;
import com.web.orbitERP.vo.Employee;
import com.web.orbitERP.vo.Erpmem;
import com.web.orbitERP.vo.Paystub;
import com.web.orbitERP.vo.Salary;
import com.web.orbitERP.vo.SalarySch;
import com.web.orbitERP.vo.StuProfile;
import com.web.orbitERP.vo.Student;
import com.web.orbitERP.vo.StudentSch;

@Service
public class A02_HRService {

	@Autowired(required = false)
	private A02_HRDao dao;
	@Value("${file.upload2}")
	private String path2;


	// 부서 리스트 조회
	public List<Dept> getDeptList(Dept sch) {
		if (sch.getDname() == null)
			sch.setDname("");
		System.out.println("서비스단 데이터 개수:" + dao.getDeptList(sch).size());
		return dao.getDeptList(sch);
	}

	// 부서 등록
	public int insertDept(Dept ins) {
		return dao.insertDept(ins);

	}

	// 부서 상세 정보
	public Dept detailDept(int deptno) {
		return dao.deptDetail(deptno);
	}

	// 부서 삭제
	public int deleteDept(int deptno) {
		return dao.deleteDept(deptno);
	}

	// 부서번호 중복검사
	public int checkExistDept(int deptno) {
		return dao.checkExistDept(deptno);
	}

	// 부서 수정
	public int updateDept(Dept upt) {
		return dao.updateDep(upt);
	}

	// 학생리스트 조회
	public List<Student> getStudentList(StudentSch sch) {
		if (sch.getName() == null)
			sch.setName("");
		if (sch.getFinal_degree() == null)
			sch.setFinal_degree("");

		// 페이징 처리
		int tot = dao.totStudent(sch);
		// 전체 학생 수
		sch.setCount(tot);
		if (sch.getPageSize() == 0)
			sch.setPageSize(10);
		// 3. 총페이지수 [1][2][3][4][5][6]
		sch.setPageCount((int) Math.ceil(sch.getCount() / (double) sch.getPageSize()));
		// 4. 클릭한 현재 페이지 번호(초기화면에는 default로 1로 설정)
		// 마지막페이지에서 next를 눌렀을 때, 더이상 curpage가 증가하지 않게 처리
		if (sch.getCurPage() > sch.getPageCount())
			sch.setCurPage(sch.getPageCount());
		if (sch.getCurPage() == 0)
			sch.setCurPage(1);
		// 5. 페이지의 마지막 번호는 현재 클릭한 페이지번호 * 페이지당 보일 데이터 건수
		sch.setEnd(sch.getCurPage() * sch.getPageSize());
		if (sch.getEnd() > sch.getCount()) {
			sch.setEnd(sch.getCount());
		}
		// 6. 페이지의 시작 번호는 (현재클릭한 페이지번호 -1) * 페이지당 보일 데이터건수 +1
		sch.setStart((sch.getCurPage() - 1) * sch.getPageSize() + 1);

		// 7. 블럭사이즈 지정(고정)
		sch.setBlockSize(5);
		// 8. 클릭한 현재 페이지번호 기준으로 블럭번호 처리
		int blockNum = (int) Math.ceil((double) sch.getCurPage() / sch.getBlockSize());
		// 9. 마지막 블럭번호
		sch.setEndBlock(blockNum * sch.getBlockSize());
		if (sch.getEndBlock() > sch.getPageCount()) {
			sch.setEndBlock(sch.getPageCount());
		}
		// 10. 시작블럭번호
		sch.setStartBlock((blockNum - 1) * sch.getBlockSize() + 1);

		return dao.getStudentList(sch);

	}

	// 학생 상세 조회
	public Student studentDetail(int sno) {
		Student student = dao.studentDetail(sno);
		return student;
	}

	public StuProfile getStuProfile(int sno) {
		return dao.getStuProfile(sno);
	}

	@Value("${file.upload1}")
	private String path;

	public String insertStudent(Student ins) {
		int ck01 = dao.insertStudent(ins);
		String msg = ck01 > 0 ? "기본정보 등록성공" : "등록 실패";
		msg += "\\n";
		int ck02 = 0;

		MultipartFile mpf = ins.getProfile();
		if (mpf != null) {
			String fname = mpf.getOriginalFilename();
			try {
				// 파일을 물리적으로 저장하는 코드
				mpf.transferTo(new File(path + fname));
				// DB에 파일 정보를 저장하는 코드
				ck02 = dao.insertStuProfile(new StuProfile(fname, path));
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				System.out.println("예외:" + e.getMessage());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				System.out.println("file 입출력에러" + e.getMessage());

			} catch (Exception e) {
				System.out.println("#기타 예외3:" + e.getMessage());
				e.printStackTrace();
			}
		}
		msg += "프로필 사진 " + ck02 + "건 등록 완료";
		return msg;

	}

	public int deleteStudent(int sno) {
		// 저장된 프로필 사진이 있으면
		if (dao.isExistProfile(sno) > 0) {
			// 프로필 정보 삭제
			String fname = dao.getStuProfile(sno).getFname();
			System.out.println(sno + "의 프로필 파일명: " + fname);
			File fileToDelete = new File(path + fname);
			if (fileToDelete.exists())
				fileToDelete.delete();
			dao.deleleteStuProfile(sno);
		}
		return dao.deleteStudent(sno);
	}

	public String updateStudent(Student upt) {
		String msg = "";
		int sno = upt.getSno();
		System.out.println("학생번호: " + sno);
		int ck01 = dao.updateStudent(upt);
		int ck02 = 0;
		msg = ck01 > 0 ? "기본 학생 정보 수정 성공" : "수정실패";
		MultipartFile mpf = upt.getProfile();
		if (mpf != null && dao.isExistProfile(sno) < 1) { // 업로드한 파일이 존재하고 현재 프로필 사진이 없으면
			String fname = mpf.getOriginalFilename();
			try {
				// 파일을 물리적으로 저장하는 코드
				mpf.transferTo(new File(path + fname));
				// DB에 파일 정보를 저장하는 코드
				ck02 = dao.insertStuProfileRE(new StuProfile(sno, fname, path));
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				System.out.println("#기타 예외3:" + e.getMessage());
				e.printStackTrace();
			}
			msg += "프로필 사진 " + ck02 + "건 수정 완료";

		} else if (mpf != null && dao.isExistProfile(sno) >= 1 && mpf.getOriginalFilename() != null) { // 첨부파일이 존재하고, 현재
																										// 프로필 사진이 있으면

			// 기존 프로필 파일명 가져와서 물리적으로 삭제
			String deleteFname = dao.getStuProfile(sno).getFname();
			System.out.println(sno + "의 프로필 파일명: " + deleteFname);
			File fileToDelete = new File(path + deleteFname);
			if (fileToDelete.exists())
				fileToDelete.delete();

			String fname = mpf.getOriginalFilename(); // 새로 저장할 프로필 파일명
			System.out.println(sno + " 새로 저장될 프로필 파일명: " + fname);
			try {
				// 파일을 물리적으로 저장하는 코드
				mpf.transferTo(new File(path + fname));
				// DB에 파일 정보를 저장하는 코드
				StuProfile stuProfile = new StuProfile(fname, path);
				stuProfile.setSno(sno);
				ck02 = dao.updateStuProfile(stuProfile);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				System.out.println("#기타 예외3:" + e.getMessage());
				e.printStackTrace();
			}
			msg += "\\n";
			msg += "프로필 사진 " + ck02 + "건 수정 완료";

		}

		return msg;

	}

	public List<EmpSch> getEmpList(EmpSch sch) {
		// 페이징 처리
		int tot = dao.totEmp(sch);
		// 전체 학생 수
		sch.setCount(tot);
		if (sch.getPageSize() == 0)
			sch.setPageSize(10);
		// 3. 총페이지수 [1][2][3][4][5][6]
		sch.setPageCount((int) Math.ceil(sch.getCount() / (double) sch.getPageSize()));
		// 4. 클릭한 현재 페이지 번호(초기화면에는 default로 1로 설정)
		// 마지막페이지에서 next를 눌렀을 때, 더이상 curpage가 증가하지 않게 처리
		if (sch.getCurPage() > sch.getPageCount())
			sch.setCurPage(sch.getPageCount());
		if (sch.getCurPage() == 0)
			sch.setCurPage(1);
		// 5. 페이지의 마지막 번호는 현재 클릭한 페이지번호 * 페이지당 보일 데이터 건수
		sch.setEnd(sch.getCurPage() * sch.getPageSize());
		if (sch.getEnd() > sch.getCount()) {
			sch.setEnd(sch.getCount());
		}
		// 6. 페이지의 시작 번호는 (현재클릭한 페이지번호 -1) * 페이지당 보일 데이터건수 +1
		sch.setStart((sch.getCurPage() - 1) * sch.getPageSize() + 1);

		// 7. 블럭사이즈 지정(고정)
		sch.setBlockSize(5);
		// 8. 클릭한 현재 페이지번호 기준으로 블럭번호 처리
		int blockNum = (int) Math.ceil((double) sch.getCurPage() / sch.getBlockSize());
		// 9. 마지막 블럭번호
		sch.setEndBlock(blockNum * sch.getBlockSize());
		if (sch.getEndBlock() > sch.getPageCount()) {
			sch.setEndBlock(sch.getPageCount());
		}
		// 10. 시작블럭번호
		sch.setStartBlock((blockNum - 1) * sch.getBlockSize() + 1);

		return dao.getEmpList(sch);
	}

	public Employee empDetail(String empno) {
		System.out.println("#사원 정보 상세");
		return dao.empDetail(empno);
	}

	public EmpProfile getEmpProfie(String empno) {
		return dao.getEmpProfie(empno);
	}

	public String empUpdate(Employee upt) {
		String msg = "";
		String empno = upt.getEmpno();
		int ck01 = dao.empUpdate(upt);
		if (upt.getPwd() != null && !upt.getPwd().isEmpty() && upt.getPwd() != "") {
			dao.updateErpmem(new Erpmem(empno, upt.getPwd()));
		}

		int ck02 = 0;
		msg = ck01 > 0 ? "기본 사원 정보 수정 성공" : "수정실패";
		MultipartFile mpf = upt.getProfile();
		System.out.println("파일명: " + upt.getProfile());
		if (mpf != null && dao.getEmpProfie(empno) == null) { // 업로드한 파일이 존재하고 현재 프로필 사진이 없으면
			String fname = mpf.getOriginalFilename();
			try {
				// 파일을 물리적으로 저장하는 코드
				mpf.transferTo(new File(path2 + fname));
				// DB에 파일 정보를 저장하는 코드
				ck02 = dao.empPrfrofileInsert(new EmpProfile(empno, fname, path2));
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				System.out.println("#기타 예외3:" + e.getMessage());
				e.printStackTrace();
			}
			msg += "프로필 사진 " + ck02 + "건 수정 완료";

		} else if (mpf != null && dao.getEmpProfie(empno) != null
				&& (mpf.getOriginalFilename() != null || !mpf.getOriginalFilename().equals(""))) { // 첨부파일이 존재하고, 현재 프로필
																									// 사진이 있으면(프로필 사진의
																									// fname이 null이면 기존
																									// 사진 유지)

			// 기존 프로필 파일명 가져와서 물리적으로 삭제
			String deleteFname = dao.getEmpProfie(empno).getFname();
			System.out.println(empno + "의 프로필 파일명: " + deleteFname);

			String fname = mpf.getOriginalFilename(); // 새로 저장할 프로필 파일명
			System.out.println(empno + " 새로 저장될 프로필 파일명: " + fname);
			try {
				// 파일을 물리적으로 저장하는 코드
				mpf.transferTo(new File(path2 + fname));
				// DB에 파일 정보를 저장하는 코드
				ck02 = dao.empProfileUpdate(new EmpProfile(empno, fname, path2));
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				System.out.println("#기타 예외3:" + e.getMessage());
				e.printStackTrace();
			}
			msg += "\\n";
			msg += "프로필 사진 " + ck02 + "건 수정 완료";

		}
		return msg;
	}

	public String empInsert(Employee ins) {

		int ck01 = dao.empInsert(ins);
		int ck02 = 0;
		Erpmem erpmem = new Erpmem();
		erpmem.setEmpno(ins.getEmpno()); // 사원번호 세팅
		erpmem.setPwd(ins.getPwd()); // 비밀번호 세팅
		// 권한 설정
		// 팀장이면 auth는 부서명+관리자
		String dname = dao.deptDetail(ins.getDeptno()).getDname();
		if (ins.getJob().equals("팀장")) {
			erpmem.setAuth(dname + "관리자");
		} else if (ins.getJob().equals("이사")) {
			erpmem.setAuth("총괄관리자");
		} else {
			erpmem.setAuth("사원");
		}
		// erpmem insert
		dao.insertErpmem(erpmem);
		String msg = ck01 > 0 ? "기본정보 등록성공" : "등록 실패";
		MultipartFile mpf = ins.getProfile();
		if (mpf != null) {
			String fname = mpf.getOriginalFilename();
			try {
				// 파일을 물리적으로 저장하는 코드
				mpf.transferTo(new File(path2 + fname));
				// DB에 파일 정보를 저장하는 코드
				ck02 = dao.empPrfrofileInsert(new EmpProfile(ins.getEmpno(), fname, path2));
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				System.out.println("#기타 예외3:" + e.getMessage());
				e.printStackTrace();
			}
		}
		msg += "프로필 사진 " + ck02 + "건 등록 완료";
		return msg;
	}

	public String deleteEmp(String empno) {
		dao.deleteAtt(empno); // 근태 정보 지우기

		if (dao.getEmpProfie(empno) != null) {

			String fname = dao.getEmpProfie(empno).getFname();
			System.out.println(empno + "의 프로필 파일명: " + fname);
			dao.deleteEmpProfile(empno);

		}
		if (dao.getErpmem(empno) != null) {
			dao.deleteErpmem(empno);
		}
		return dao.deleteEmp(empno) > 0 ? "삭제성공" : "삭제 실패";
	}

	public int ckEmpno(String empno) {
		return dao.ckEmpno(empno);
	}

	public List<String> getEmpnoList() {
		return dao.getEmpnoList();
	}

	public List<AttendanceSch> getAttenList(AttendanceSch Sch) {
		return dao.getAttenList(Sch);
	}

	public List<AttendanceSch> getAttMine(AttendanceSch Sch) {
		return dao.getAttMine(Sch);
	}

	public int checkIn(String empno) {
		return dao.checkIn(empno);
	}

	public int isExitsCheckIn(String work_date, String empno) {
		return dao.isExitsCheckIn(work_date, empno);
	}

	public int checkOut(String work_date, String empno) {
		return dao.checkOut(work_date, empno);
	}

	public List<Employee> getEmpListModel() {
		return dao.getEmpListModel();
	}
	
	public List<SalarySch> getSalaryList(SalarySch sch){
		
		// 페이징 처리
				int tot = dao.totSalary(sch);
				// 전체 학생 수
				sch.setCount(tot);
				sch.setCurPage(0);
				if (sch.getPageSize() == 0)
					sch.setPageSize(10);
				// 3. 총페이지수 [1][2][3][4][5][6]
				sch.setPageCount((int) Math.ceil(sch.getCount() / (double) sch.getPageSize()));
				// 4. 클릭한 현재 페이지 번호(초기화면에는 default로 1로 설정)
				// 마지막페이지에서 next를 눌렀을 때, 더이상 curpage가 증가하지 않게 처리
				if (sch.getCurPage() > sch.getPageCount())
					sch.setCurPage(sch.getPageCount());
				if (sch.getCurPage() == 0)
					sch.setCurPage(1);
				// 5. 페이지의 마지막 번호는 현재 클릭한 페이지번호 * 페이지당 보일 데이터 건수
				sch.setEnd(sch.getCurPage() * sch.getPageSize());
				if (sch.getEnd() > sch.getCount()) {
					sch.setEnd(sch.getCount());
				}
				// 6. 페이지의 시작 번호는 (현재클릭한 페이지번호 -1) * 페이지당 보일 데이터건수 +1
				sch.setStart((sch.getCurPage() - 1) * sch.getPageSize() + 1);

				// 7. 블럭사이즈 지정(고정)
				sch.setBlockSize(5);
				// 8. 클릭한 현재 페이지번호 기준으로 블럭번호 처리
				int blockNum = (int) Math.ceil((double) sch.getCurPage() / sch.getBlockSize());
				// 9. 마지막 블럭번호
				sch.setEndBlock(blockNum * sch.getBlockSize());
				if (sch.getEndBlock() > sch.getPageCount()) {
					sch.setEndBlock(sch.getPageCount());
				}
				// 10. 시작블럭번호
				sch.setStartBlock((blockNum - 1) * sch.getBlockSize() + 1);

				
		
		return dao.getSalaryList(sch);
	}
	
	public List<Employee> getEmpListByDeptno(int deptno) {
		return dao.getEmpListByDeptno(deptno); 
	}
	
	public int insertSalary(Salary ins) {
		return dao.insertSalary(ins);
	}
	
	public Salary salaryDetail(@Param("empno") String empno, @Param("payment_dateStr") String payment_dateStr) {
		return dao.salaryDetail(empno, payment_dateStr);
	}
	
	public Attendance detailAttendance(@Param("work_date") String work_date, @Param("empno") String empno) {
		return dao.detailAttendance(work_date, empno);
	}
	
	public int updateSalary(Salary upt) {
		return dao.updateSalary(upt);
	}
	
	public int deleteSalary(@Param("empno") String empno, @Param("payment_dateStr") String payment_dateStr) {
		return dao.deleteSalary(empno, payment_dateStr);
		
	}
	
	public int salDuplicationCheck(@Param("empno") String empno, @Param("payment_dateStr") String payment_dateStr) {
		return dao.salDuplicationCheck(empno, payment_dateStr);
	}
	
	public List<Paystub> getPaystubList(@Param("deptno") int deptno, 
			@Param("year") int year ,@Param("month") int month  ) {
		return dao.getPaystubList(deptno, month, year);
	}
	
	public int insertPaystub(Paystub ins) {
		return dao.insertPayStub(ins);
	}
	
	public List<Paystub> getPaystubDetail(@Param("payment_dateStr") String payment_dateStr,
			   @Param("deptno") int deptno){
		return dao.getPaystubDetail(payment_dateStr, deptno);
	}
	
	public int deletePaystub(@Param("payment_dateStr") String payment_dateStr, @Param("deptno") int deptno) {
		return dao.deletePaystub(payment_dateStr, deptno);
	}
	
	public int updatePaystub(Paystub upt) {
		return dao.updatePaystub(upt);
	}

}
