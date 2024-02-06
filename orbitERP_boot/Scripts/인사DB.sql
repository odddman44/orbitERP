-- 부서 정보 테이블
CREATE TABLE dept(
	deptno number(2,0) PRIMARY KEY, -- 부서번호
	dname varchar2(100) NOT null, -- 부서이름
	dcode varchar2(100) NOT NULL, -- 부서 영문약자
	etc varchar2(1000) -- 부서에 대한 설명
);
-- 부서 내용
INSERT INTO dept values(10, '인사팀', 'HR', '인사관리팀');
INSERT INTO dept values(20, '재무팀', 'FN', '재무관리팀');
INSERT INTO dept values(30, '개발팀', 'PR', '프로그래밍 개발팀');
INSERT INTO dept values(40, '일정계획팀', 'PN', '학원의 연간계획을 담당하는 팀');
INSERT INTO dept values(50, '교육팀', 'ED', '학원 강사진들이 소속된 팀');
-- 부서 정보 조회
SELECT * FROM dept;
-- 부서 정보 수정
UPDATE dept
SET dname='수정했어요', DCODE = 'CC', etc = ' '
WHERE deptno = 12;
/*

 * */
-- 학생 테이블 만들기
CREATE TABLE STUDENT (
	sno	number	PRIMARY KEY,
	name	varchar2(30)	NULL,
	birth	date	NULL,
	FINAL_degree	varchar2(100)	NULL,
	phone	varchar2(100)	NULL,
	address	varchar2(500)	NULL
);

SELECT * FROM STUDENT;
-- 학생 정보 입력
/*
 private int sno;
 private String name;
 private Date birth
 private String final_degree
 private String phone;
 private String address;
 private String account;
 private Date reg_date;
 * */
INSERT INTO STUDENT values(6, '구자민', TO_DATE('2002-07-12', 'YYYY-MM-DD'), '4년제 대학 재학중', '010-1234-1234',
'서울특별시 강남구 테헤란로', '123-110-122222-222(기업은행)', sysdate );
ALTER TABLE student ADD reg_date date DEFAULT sysdate;
UPDATE STUDENT SET account = '110-11111-11111(신한은행)' WHERE sno = 1;

SELECT * FROM STUDENT s ;
-- 학생 정보 리스트 조회
SELECT sno, name, final_degree, reg_date
FROM STUDENT
WHERE name LIKE '%'||''||'%'
AND FINAL_DEGREE  LIKE '%'||''||'%';
-- 학생 정보 상세 조회
SELECT * FROM STUDENT
WHERE sno = 1;

	SELECT *
		FROM(
			SELECT ROWNUM cnt, s.*
			FROM STUDENT s 
			WHERE 1=1
			   AND name LIKE '%'||''||'%' 
			   AND FINAL_degree LIKE '%'||''||'%'
			ORDER BY sno ASC
		)WHERE cnt between 1 AND 10;
SELECT count(*)
FROM STUDENT
WHERE 1=1
AND name LIKE '%'||''||'%' 
AND FINAL_degree LIKE '%'||''||'%';

CREATE TABLE stuprofile(
	sno NUMBER,
	CONSTRAINT sno foreign key(sno) references Student (sno),
	fname varchar2(200),
	PATH varchar2(200)
);

SELECT * FROM stuprofile;
SELECT * FROM STUPROFILE WHERE sno = 1;
INSERT INTO STUPROFILE values(1, '톰덩이.png','C:\Users\user\eclipse-workspace\orbitERP\src\main\webapp\WEB-INF\z01_upload' );
	
);
CREATE SEQUENCE stuno_seq
INCREMENT BY 1
START WITH 6;
INSERT INTO STUDENT values(stuno_seq.nextval, '김한성', to_date('1998-01-01', 'YYYY-MM-DD'),
'대학 졸업', '010-5678-7890', '서울특별시 서초구 방배로', '010-1111-3333(기업은행)',
to_date('2023-01-31', 'YYYY-MM-DD'));
)

SELECT * FROM STUDENT s ;

SELECT * FROM ERPMEM e ;
-- 사원 테이블 만들기
CREATE TABLE EMPLOYEE (
    empno VARCHAR2(20) PRIMARY KEY,
    deptno NUMBER(2,0),
    ename VARCHAR2(50),
    job VARCHAR2(50),
    hiredate date,
    email VARCHAR2(100),
    phone VARCHAR2(100),
    address varchar2(500),
    account VARCHAR2(100),
    ssnum VARCHAR2(50),
    CONSTRAINT fk_dept FOREIGN KEY (deptno) REFERENCES DEPT(deptno)
);
SELECT * FROM EMPLOYEE ;
INSERT INTO EMPLOYEE values(
	'PM0001', 40, '정서라', '팀장',
	to_date('2013-05-30','YYYY-MM-DD'),
	'orbit_pm@gmail.com', '010-XXXX-XXXX',
	'서울특별시 성북구', '110-XXXX-XXXX-XXXX(신한은행)',
	'910530-2XXXXXX'
);




SELECT * FROM STUDENT s ;
-- 학생 프로필 파일 업로드
INSERT INTO STUPROFILE s values(33, '톰.png', '');
-- 학생 프로필 파일 수정
UPDATE STUPROFILE SET
fname = '톰.jpg',
PATH = 'dd'
WHERE sno = 45;


-- 프로필 삭제
DELETE FROM STUPROFILE s WHERE sno = 8;
SELECT * FROM EMPLOYEE ;



CREATE TABLE ERPMEM (
    empno VARCHAR2(20) PRIMARY KEY,
    auth VARCHAR2(50),
    ename VARCHAR2(50),
    pwd VARCHAR2(50),
    email VARCHAR2(200),
    CONSTRAINT fk_employee FOREIGN KEY (empno) REFERENCES EMPLOYEE(empno)
);
SELECT * FROM EMPLOYEE
WHERE deptno = ''
AND ename LIKE '%'||''||'%';

SELECT * FROM (
	SELECT ROWNUM cnt, e.empno, e.ename, e.job, d.dname
	FROM EMPLOYEE e, DEPT d
	WHERE 1=1 
	AND e.DEPTNO = d.DEPTNO
	AND e.ename LIKE '%'||''||'%'
	AND e.deptno = 10
	ORDER BY empno
	)WHERE cnt BETWEEN 1 AND 10;

ALTER TABLE EMPLOYEE 
ADD salary NUMBER DEFAULT 0;

SELECT * FROM EMPLOYEE e ;

SELECT count(*)
		FROM EMPLOYEE e 
		WHERE 1=1
		AND ename LIKE '%'||''||'%'
		AND DEPTNO = 10;
SELECT * FROM DEPT d ;

SELECT * FROM employee;

INSERT INTO EMPLOYEE values(
	'HR23002', 10, '양정인', '사원', sysdate, 'orbit_hm02@gmail.com', '010-1234-1234',
	'부산광역시', '110-xxxx-xxxxx(카카오뱅크)', '010208-3xxxxxx', 3000
);

/*
 	INSERT INTO EMPLOYEE values(
	#{empno}, #{deptno}, #{ename}, #{job}, to_date('#{hiredate}, 'yyyy-MM-dd'), #{email}, #{phone},
	#{address}, #{account}, #{ssum}, #{salary}
)
 * */

SELECT * FROM DEPT d ;

SELECT * FROM EMPLOYEE e ;

SELECT * FROM STUDENT s ;

CREATE TABLE ATTENDANCE (
    empno VARCHAR2(20), -- 사원번호
    work_date DATE, -- 근무일자
    arr_time DATE, -- 출근시간
    dep_time DATE, -- 퇴근시간
    late VARCHAR2(1), -- 지각 여부
    early_leave VARCHAR2(1), -- 조퇴 여부
    tot_workhours INTERVAL DAY TO SECOND, -- 총 근무시간
    remark VARCHAR2(500), -- 기타 세부사항
    PRIMARY KEY (empno, work_date),
    CONSTRAINT late_check CHECK (late IN ('Y', 'N')),
    CONSTRAINT early_leave_check CHECK (early_leave IN ('Y', 'N')),
    CONSTRAINT fk_empno FOREIGN KEY (empno) REFERENCES EMPLOYEE(empno)
);



CREATE OR REPLACE TRIGGER check_late_arrival
BEFORE INSERT OR UPDATE ON ATTENDANCE
FOR EACH ROW
BEGIN
    -- 출근시간이 오전 9시 이후인 경우 late에 'Y'를 설정
    IF TO_CHAR(:NEW.arr_time, 'HH24:MI') > '09:00' THEN
        :NEW.late := 'Y';
    ELSE
        :NEW.late := 'N';
    END IF;
END;

CREATE OR REPLACE TRIGGER check_early_leave
BEFORE INSERT OR UPDATE ON ATTENDANCE
FOR EACH ROW
BEGIN
    -- 퇴근시간이 오후 6시 이전인 경우 early_leave에 'Y'를 설정
    IF TO_CHAR(:NEW.dep_time, 'HH24:MI') < '18:00' THEN
        :NEW.early_leave := 'Y';
    ELSE
        :NEW.early_leave := 'N';
    END IF;
END;


INSERT INTO ERPMEM e values('ERP')

UPDATE ATTENDANCE SET
dep_time = TO_DATE('2024-01-31 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
WHERE empno = 'HR0001'
AND TRUNC(WORK_DATE) = TO_DATE('2024-01-31', 'YYYY-MM-DD');

SELECT * FROM ATTENDANCE a ;

SELECT 
    a.*,
    TO_CHAR(TRUNC((DEP_TIME - ARR_TIME) * 24) - 1, 'FM00') || '시간 ' || 
    TO_CHAR(ROUND(MOD((DEP_TIME - ARR_TIME) * 24 * 60, 60)), 'FM00') || '분' AS tot_workhours
FROM 
    ATTENDANCE a;
   
-- erpmem insert
 INSERT INTO ERPMEM e values(
 	'ED0002', '사원', '5555'
 );
/*
  INSERT INTO ERPMEM e values(
 	#{empno}, #{auth}, #{pwd}
 )
 * */
SELECT * FROM ERPMEM e ;

DELETE FROM ERPMEM e WHERE empno = 'HR0004';

SELECT * FROM ERPMEM e WHERE empno = 'HR0001';

SELECT * FROM EMPPROFILE e ;

SELECT * FROM ERPMEM e ;

UPDATE ERPMEM SET
pwd = '5555'
WHERE empno = 'HR0001';

SELECT * FROM ERPMEM e ;
    




































