<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<script src="${path}/a00_com/jquery.min.js"></script>



<script type="text/javascript">
   $(document).ready(function() {
	   var sessionCk="${emem.auth}"
	   var sessionDeptno = "${emem.deptno}"
	   
		   $("#mycal").hide()
	   
	   if(sessionCk !== "총괄관리자" && sessionCk!=="계획관리자"){
		   $("#session1").hide()
		   $("#session2").hide()
		   $("#mycal").show()
	   }
	   
	  var hrmenu =  $('#collapseThree').find('.collapse-item');
	  if(sessionCk !== "총괄관리자" && sessionDeptno!=="10"){
		  
		  hrmenu.each(function() {
	            $(this).click(function(event) {
	                // 기본 클릭 동작을 막습니다.
	                event.preventDefault();
	                // 클릭되지 않음을 알리는 메시지를 표시합니다.
	                alert('인사팀 소속 직원 혹은 총괄관리지만 접근할 수 있는 항목입니다.');
	            });
	        });
	  }
   });

   function goMypage(empno) {
      location.href = "mypage?empno" + empno
   }
   function sendAlram(sender) {
	    window.open("sendAlram?sender=" + sender, "AlramWindow", "width=700 height=600 left=500 top=200");
	}
</script>
<link
   href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
   rel="stylesheet">
<link href="${path}/a00_com/css/custom-style.css" rel="stylesheet">
<ul
   class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
   id="accordionSidebar">

   <!-- Sidebar - Brand -->
   <a
      class="sidebar-brand d-flex align-items-center justify-content-center"
      href="${path}/main">
      <div class="sidebar-brand-icon rotate-n-15">
         <img src="${path}/a00_com/img/logo_colored.png" alt="Orbit ERP Logo"
            style="width: 40px; height: auto;">
      </div>
      <div class="sidebar-brand-text mx-3">
         Orbit ERP <sup>⊙</sup>
      </div>
   </a>

   <!-- Divider -->
   <hr class="sidebar-divider my-0">

   <!-- Nav Item - Dashboard -->
   <li class="nav-item"><a class="nav-link collapsed" href="#"
      data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true"
      aria-controls="collapseTwo"> <i class="fa fa-user-circle"
         style="font-size: 15px"></i> <span style="font-size: 15px">My
            Page</span>
   </a>
      <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
         data-parent="#accordionSidebar">
         <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">My Page:</h6>
            <a class="collapse-item" href="${path}/mypage?empno=${emem.empno}">나의
               정보 관리</a> <a class="collapse-item" href="${path}/myattList?empno=${emem.empno}">나의 근태정보 관리</a>
         </div>
      </div></li>


   <!-- Divider -->
   <hr class="sidebar-divider">
   <!-- Heading -->
   <div class="sidebar-heading">인사관리</div>

   <!-- Nav Item - Pages Collapse Menu -->
   <li class="nav-item"><a class="nav-link collapsed" href="#"
      data-toggle="collapse" data-target="#collapseThree"
      aria-expanded="true" aria-controls="collapseThree"> <i
         class="fas fa-fw fa-cog"></i> <span>직원관리</span>
   </a>
      <div id="collapseThree" class="collapse"
         aria-labelledby="headingThree" data-parent="#accordionSidebar">
         <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">직원관리:</h6>
            <a class="collapse-item" href="empList">직원정보관리</a> <a
               class="collapse-item" href="attendanceList">직원근태정보관리</a> <a
               class="collapse-item" href="salaryManage">급여정보관리</a>
         </div>
      </div></li>


   <!-- Nav Item - Utilities Collapse Menu -->
   <li class="nav-item"><a class="nav-link collapsed" href="#"
      data-toggle="collapse" data-target="#collapseUtilities01"
      aria-expanded="true" aria-controls="collapseUtilities"> <i
         class="fas fa-fw fa-folder"></i> <span>학생관리</span>
   </a>
      <div id="collapseUtilities01" class="collapse"
         aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
         <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">학생관리:</h6>
            <a class="collapse-item" href="studentList">학생정보관리</a>
              
         </div>
      </div></li>
   <li class="nav-item"><a class="nav-link collapsed" href="#"
      data-toggle="collapse" data-target="#collapseUtilities02"
      aria-expanded="true" aria-controls="collapseUtilities"> <i
         class="fas fa-fw fa-folder"></i> <span>부서관리</span>
   </a>
      <div id="collapseUtilities02" class="collapse"
         aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
         <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">부서관리:</h6>
            <a class="collapse-item" href="deptList">부서정보관리</a>
         </div>
      </div></li>

   <!-- Divider -->
   <hr class="sidebar-divider">
   <!-- Heading -->
   <div class="sidebar-heading">영업/계획관리</div>

   <!-- Nav Item - Pages Collapse Menu -->
   <li class="nav-item"><a class="nav-link collapsed" href="#"
      data-toggle="collapse" data-target="#collapseUtilities03"
      aria-expanded="true" aria-controls="collapseUtilities"> <i
         class="fas fa-fw fa-folder"></i> <span>영업계획</span>
   </a>
      <div id="collapseUtilities03" class="collapse"
         aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
         <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">영업계획:</h6>
            <a class="collapse-item" href="planCalendar">연간스케줄조회</a> <a
               class="collapse-item" href="calendar" id="mycal">개인스케줄조회</a> 
               <a class="collapse-item" onclick="sendAlram('${emem.empno}')">알림 보내기</a>
         </div>
      </div></li>
   <li class="nav-item"><a class="nav-link collapsed" href="#"
      data-toggle="collapse" data-target="#collapseUtilities04"
      aria-expanded="true" aria-controls="collapseUtilities"> <i
         class="fas fa-fw fa-folder"></i> <span>강의관리</span>
   </a>
      <div id="collapseUtilities04" class="collapse"
         aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
         <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">강의관리:</h6>
            <a class="collapse-item" href="lectureCalendar">강의스케줄조회</a> <a
               class="collapse-item" href="lectureList">강의조회</a> 
               <a class="collapse-item" href="lectureInsertFrm" id="session1">강의등록</a>
         </div>
      </div></li>
   <!-- Divider -->
   <hr class="sidebar-divider">
   <!-- Heading -->
   <div class="sidebar-heading">재무/예산관리</div>

   <li class="nav-item"><a class="nav-link collapsed" href="#"
      data-toggle="collapse" data-target="#collapseUtilities06"
      aria-expanded="true" aria-controls="collapseUtilities"> <i
         class="fas fa-fw fa-chart-area"></i> <span>재무관리</span>
   </a>
      <div id="collapseUtilities06" class="collapse"
         aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
         <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">재무관리:</h6>
            <a class="collapse-item" href="accList">계정과목 관리</a> <a
               class="collapse-item" href="voucherList">회계전표 관리</a> <a
               class="collapse-item" href="manageReport">경영자 보고서</a>
         </div>
      </div></li>
   <li class="nav-item"><a class="nav-link collapsed" href="#"
      data-toggle="collapse" data-target="#collapseUtilities07"
      aria-expanded="true" aria-controls="collapseUtilities"> <i
         class="fas fa-fw fa-table"></i> <span>예산관리</span>
   </a>
      <div id="collapseUtilities07" class="collapse"
         aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
         <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">예산관리:</h6>
            <a class="collapse-item" href="budgetList">예산 편성</a> <a class="collapse-item"
               href="budgetComp">예산-실적비교</a>
         </div>
      </div></li>

   <!-- Divider -->
   <hr class="sidebar-divider">
   <!-- Heading -->
   <div class="sidebar-heading">공지사항 및 게시판</div>
   <!-- Nav Item - Charts -->
   <li class="nav-item"><a class="nav-link" href="bulList"> <i
         class="fas fa-fw fa-chart-area"></i> <span>공지사항</span>
   </a></li>

   <!-- Nav Item - Tables -->
			<li class="nav-item"><a class="nav-link" href="chatting">
					<i class="fas fa-fw fa-table"></i> <span>메신저</span>
			</a></li>

   <!-- Divider -->
   <hr class="sidebar-divider d-none d-md-block">

   <!-- Sidebar Toggler (Sidebar) -->
   <div class="text-center d-none d-md-inline">
      <button class="rounded-circle border-0" id="sidebarToggle"></button>
   </div>

</ul>

