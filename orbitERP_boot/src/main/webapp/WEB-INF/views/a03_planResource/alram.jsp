<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<%@ page import="jakarta.servlet.http.HttpSession"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>:: Orbit ERP ::</title>
<link href="${path}/a00_com/img/logo.svg" rel="icon" type="image/x-icon" />
<%--
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
 --%>
 <style>
   .navbar {
    background-color: #4E7CD9; /* 네비게이션 바 배경 색상 */
    padding: 10px; /* 네비게이션 바 안쪽 여백 */
  }

  .nav_menu {
    list-style-type: none; /* 리스트 스타일 제거 */
    margin: 0;
    padding: 0;
    text-align: center; /* 텍스트 가운데 정렬 */
  }

  .nav_menu li {
    display: inline-block; /* 항목을 옆으로 나란히 표시 */
    margin-right: 20px; /* 각 항목 사이 여백 */
  }

  .nav_menu li a {
    text-decoration: none; /* 링크 밑줄 제거 */
    color: #ffffff; /* 링크 텍스트 색상 */
    font-weight: bold; /* 링크 텍스트 굵게 표시 */
    font-size: 16px; /* 링크 텍스트 크기 */
  }

 </style>
 <!-- jQuery -->
<script src="${path}/a00_com/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(document).ready(function() {
      if('${alListAll}.length' == 0) {
        alert('알림이 없습니다.');
        $("#nulls").html("알림이 없습니다.");
    }
    
    $('#sendMsgg').click(function() {
        sendAlram('${emem.empno}');
    })
    $('#alhiden2').hide();// 초기에 숨김처리
    
    $('#toggleAlhiden1').click(function() {
       $('#alhiden1').show();
       $('#alhiden2').hide();
       location.reload(true);
    });
    $('#toggleAlhiden2').click(function() {
       $('#alhiden1').hide();
       $('#alhiden2').show();
    });
});

</script>
     <!-- Custom fonts for this template-->
    <link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <!-- 
    기존 font
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    -->
   <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
   
    <!-- Custom styles for this template-->
    <link href="${path}/a00_com/css/sb-admin-2.min.css" rel="stylesheet">
    <link href="${path}/a00_com/css/custom-style.css" rel="stylesheet">
</head>
<body id="page-top">

   <!-- Page Wrapper -->
   <div id="wrapper">

      <!-- Sidebar -->
      <%@ include file="/WEB-INF/views/a00_module/a02_sliderBar.jsp" %>
      <!-- End of Sidebar -->

      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column">

         <!-- Main Content -->
         <div id="content">
            <!-- Topbar  -->
            <%@ include file="/WEB-INF/views/a00_module/a03_topBar.jsp" %> 
            <!-- End of Topbar -->
            <!-- Begin Page Content (여기서부터 페이지 내용 입력) -->
            <div class="container-fluid">
               <!-- 여기서부터 알림창 구현 -->
               <div class="d-sm-flex align-items-center justify-content-between mb-4">
                  <h1 class="h3 mb-0 text-gray-800">☆ 알림</h1>
                  <div style="text-align: right;">
                        <input type="button" class="btn btn-info" value="알림보내기" id="sendMsgg"/>
                     </div>
               </div>
               
            <div class="card shadow mb-4">
               <div class="card-body">
               <nav class="navbar">
                  <ul class="nav_menu">
                    <li><a id="toggleAlhiden1">받은 알람</a></li>
                    <li><a id="toggleAlhiden2">보낸 알람</a></li>
                  </ul>
                </nav>
                <!-- 전체알람출력 -->
                <div id="alhiden1">
                     <c:forEach var="alram" items="${alListAll}">
                        <a class="dropdown-item d-flex align-items-center"
                        onclick="checkUp(${alram.idx})" id="ck1_${alram.idx }"
                        style="${alram.checked eq 'Y' ? 'background-color: #f0f0f0;' : ''}">
                        <h3 id="nulls"></h3>
                        <!-- 클릭시 모달창으로 상세정보 보여줄예정 -->
                           <div class="mr-3" style="min-height: 60px; display: flex; align-items: center;">
                              <div class="icon-circle bg-${alram.color}">
                              <!-- bg-secondary //색상-->
                                 <i class="text-white fas fa-${alram.icon}"></i>
                                 <!-- fa-bell //안에 아이콘 -->
                              </div>
                           </div>
                           <div>
                           <div class="small text-gray-500">
                              ${alram.sender }&nbsp;&nbsp;&nbsp;&nbsp;
                              ${alram.create_date }&nbsp;&nbsp;
                              <span class="badge badge-secondary ml-2" id="ck2_${alram.idx }">
                               <c:choose>
                                   <c:when test="${alram.checked eq 'Y'}">
                                       읽음
                                   </c:when>
                                   <c:otherwise>
                                       안읽음
                                   </c:otherwise>
                               </c:choose>
                              </span>
                              
                           </div>
                              <span class="font-weight-bold">${alram.altitle }</span>
                           </div>
                        </a>
                     </c:forEach>
                     </div>
                <!-- 보낸알람출력 -->
                <div id="alhiden2">
                     <c:forEach var="alram2" items="${alListAll2}">
                        <a class="dropdown-item d-flex align-items-center"
                        onclick="alDtail(${alram2.idx})" id="ck1_${alram2.idx }"
                        style="${alram2.checked eq 'Y' ? 'background-color: #f0f0f0;' : ''}">
                        <h3 id="nulls"></h3>
                        <!-- 클릭시 모달창으로 상세정보 보여줄예정 -->
                           <div class="mr-3" style="min-height: 60px; display: flex; align-items: center;">
                              <div class="icon-circle bg-${alram2.color}">
                              <!-- bg-secondary //색상-->
                                 <i class="text-white fas fa-${alram2.icon}"></i>
                                 <!-- fa-bell //안에 아이콘 -->
                              </div>
                           </div>
                           <div>
                           <div class="small text-gray-500">
                              받은 사람: ${alram2.receiver }&nbsp;&nbsp;&nbsp;&nbsp;
                              읽은 시간: ${alram2.check_date }&nbsp;&nbsp;
                              <span class="badge badge-secondary ml-2" id="ck2_${alram2.idx }">
                               <c:choose>
                                   <c:when test="${alram2.checked eq 'Y'}">
                                       열람함
                                   </c:when>
                                   <c:otherwise>
                                       열람안함
                                   </c:otherwise>
                               </c:choose>
                              </span>
                              
                           </div>
                              <span class="font-weight-bold">${alram2.altitle }</span>
                           </div>
                        </a>
                     </c:forEach>
                     </div>
            </div>
         </div>
               
      </div>
            <!-- /.container-fluid (페이지 내용 종료) -->
   </div>
         <!-- End of Main Content -->

         <!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; Orbit ERP presented by TEAM FOUR</span>
					</div>
				</div>
			</footer>
         <!-- End of Footer -->

      </div>
      <!-- End of Content Wrapper -->

   </div>
   <!-- End of Page Wrapper -->

   <!-- Scroll to Top Button-->
   <a class="scroll-to-top rounded" href="#page-top"> 
      <i class="fas fa-angle-up"></i>
   </a>
   <!-- Logout Modal-->
   <%@ include file="/WEB-INF/views/a00_module/a08_logout_modal.jsp" %>
   
<!-- Bootstrap core JavaScript-->
<script src="${path}/a00_com/vendor/jquery/jquery.min.js"></script>
<script src="${path}/a00_com/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="${path}/a00_com/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${path}/a00_com/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="${path}/a00_com/vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts -->
<script src="${path}/a00_com/js/demo/chart-area-demo.js"></script>
<script src="${path}/a00_com/js/demo/chart-pie-demo.js"></script>   
</body>
</html>