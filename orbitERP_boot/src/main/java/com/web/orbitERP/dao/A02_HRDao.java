package com.web.orbitERP.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

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


// ccom.web.orbitERP.dao.A02_HRDao
@Mapper
public interface A02_HRDao {
	
	List<Dept> getDeptList(Dept sch);
	
	
	// 부서 번호 중복체크
	@Select("SELECT count(*) FROM dept WHERE deptno = #{deptno}")
	int checkExistDept(int deptno);
	
	// 부서 정보 등록
	@Insert("INSERT INTO dept values(#{deptno}, #{dname}, #{dcode}, #{etc})")
	int insertDept(Dept ins);
	// 부서정보 조회
	@Select("SELECT * FROM dept WHERE deptno = #{deptno}")
	Dept deptDetail(int deptno);
	
	
	
	@Delete("DELETE FROM dept WHERE deptno = #{deptno}")
	int deleteDept(int deptno);
	
	int updateDep(Dept upt);
	
	List<Student> getStudentList(StudentSch sch);
	
	int totStudent(StudentSch sch);
	
	Student studentDetail(int sno);
	
	
	@Select("SELECT * FROM STUPROFILE WHERE sno = #{sno}")
	StuProfile getStuProfile(int sno);
	
	@Select("SELECT count(*) FROM STUPROFILE WHERE sno = #{sno}")
	int isExistProfile(int sno);
	
	int insertStudent(Student ins);
	
	@Delete("DELETE FROM STUDENT s WHERE sno=#{sno}")
	int deleteStudent(int sno);
	
	@Delete("DELETE FROM stuprofile  WHERE sno=#{sno}")
	int deleleteStuProfile(int sno);
	
	int updateStudent(Student upt);
	
	int insertStuProfile(StuProfile ins);
	
	int insertStuProfileRE(StuProfile ins);
	
	int updateStuProfile(StuProfile upt);
	
	List<EmpSch> getEmpList(EmpSch sch);
	
	int totEmp(EmpSch sch);
	
	Employee empDetail(@Param("empno") String empno);
	
	int empUpdate(Employee upt);
	
	int empInsert(Employee ins);
	
	int empPrfrofileInsert(EmpProfile ins);
	
	EmpProfile getEmpProfie(String empno);
	
	int deleteEmp(String empno);
	
	int deleteEmpProfile(String empno);
	
	int empProfileUpdate(EmpProfile upt);
	
	@Select("SELECT count(*) FROM EMPLOYEE WHERE empno = #{empno}")
	int ckEmpno(@Param("empno") String empno);
	
	@Select("Select empno from employee")
	List<String> getEmpnoList();
	
	List<AttendanceSch> getAttenList(AttendanceSch Sch);
	
	List<AttendanceSch> getAttMine(AttendanceSch Sch);
	
	int insertErpmem(Erpmem ins);
	
	Erpmem getErpmem(@Param("empno") String empno);
	
	int deleteErpmem(@Param("empno") String empno);
	
	int updateErpmem(Erpmem upt);
	
	int deleteAtt(String empno);
	
	int checkIn(@Param("empno") String empno);
	
	int isExitsCheckIn(@Param("work_date") String work_date, @Param("empno") String empno);
	
	int checkOut(@Param("work_date") String work_date, @Param("empno") String empno);
	
	Attendance detailAttendance(@Param("work_date") String work_date, @Param("empno") String empno);
	
	List<Employee> getEmpListModel();
	
	int totSalary(SalarySch sch);
	
	List<SalarySch> getSalaryList(SalarySch sch);
	
	List<Employee> getEmpListByDeptno(@Param("deptno") int deptno);
	
	int insertSalary(Salary ins);
	
	Salary salaryDetail(@Param("empno") String empno, @Param("payment_dateStr") String payment_dateStr);
	
	int updateSalary(Salary upt);
	
	int deleteSalary(@Param("empno") String empno, @Param("payment_dateStr") String payment_dateStr);
	
	int salDuplicationCheck(@Param("empno") String empno, @Param("payment_dateStr") String payment_dateStr);
	
	List<Paystub> getPaystubList(@Param("deptno") int deptno, 
					@Param("month") int month, @Param("year") int year );
	
	int insertPayStub(Paystub ins);
	
	List<Paystub> getPaystubDetail(@Param("payment_dateStr") String payment_dateStr,
								   @Param("deptno") int deptno);
	
	int deletePaystub(@Param("payment_dateStr") String payment_dateStr, @Param("deptno") int deptno);
	
	
	int updatePaystub(Paystub upt);
	
	
	
	
	
	
	
	
	
	

}
