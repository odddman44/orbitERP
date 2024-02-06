<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
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
<!-- jQuery -->
<script src="${path}/a00_com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

		var empno = "${emem.empno}"
		// 현재 URL에서 empno 값 가져오기
		var urlParams = new URLSearchParams(window.location.search);
		var empnoFromURL = urlParams.get('empno');

		if (empnoFromURL !== empno) {
			alert("올바르지 않은 접근입니다.")
			window.location.href = "${path}/main"
		}

		$("#arrBtn").click(function() {
			alert("출근하기!")
			event.preventDefault();
		})
		$("#depBtn").click(function() {
			alert("퇴근하기!")
			event.preventDefault();
		})

		$('#dataTable').DataTable({
			"paging" : true,
			"searching" : false,
			"ordering" : true,
			"info" : true,
			"pagingType" : "full_numbers",
			"pageLength" : 10
		});

	});
</script>
<!-- DB테이블 플러그인 추가 -->
<link rel="stylesheet" href="${path}/a00_com/css/vendor.bundle.base.css">
<link rel="stylesheet"
	href="${path}/a00_com/vendor/datatables/dataTables.bootstrap4.css">
<link rel="stylesheet" type="text/css"
	href="${path}/a00_com/js/select.dataTables.min.css">
<!-- Custom fonts for this template-->
<link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<!-- 
    기존 font
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${path}/a00_com/css/sb-admin-2.min.css" rel="stylesheet">
<link href="${path}/a00_com/css/custom-style.css" rel="stylesheet">
</head>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="/WEB-INF/views/a00_module/a02_sliderBar.jsp"%>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">
				<!-- Topbar  -->
				<%@ include file="/WEB-INF/views/a00_module/a03_topBar.jsp"%>
				<!-- End of Topbar -->
				<!-- Begin Page Content (여기서부터 페이지 내용 입력) -->
				<div class="container-fluid">
					<!-- Page Heading -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">나의 근태 정보 조회</h1>
					</div>
					<!-- 테이블 -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">날짜별로 조회</h6>
							<form id="frm01" class="form" method="POST">
								시작날짜 : <input type="date" name="start_date"
									value="${attendanceSch.start_date}" /> ~ 마지막날짜 :<input
									type="date" name="end_date" value="${attendanceSch.end_date}" />
								<nav class="navbar navbar-expand-sm navbar-light bg-light">
									<button class="btn btn-info" type="submit">Search</button>
								</nav>


							</form>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable">
									<thead>
										<tr>

											<th>근태일</th>
											<th>사원번호</th>
											<th>부서명</th>
											<th>출근시간</th>
											<th>퇴근시간</th>
											<th>지각여부</th>
											<th>조퇴여부</th>
											<th>총 근무시간</th>

										</tr>
									</thead>
									<tbody>
										<c:forEach var="att" items="${attendanceList}">
											<tr>
												<td>${att.work_date}</td>
												<td>${att.empno}</td>
												<td>${att.dname}</td>
												<td>${att.arr_time}</td>
												<td>${att.dep_time}</td>
												<td>${att.late}</td>
												<td>${att.early_leave}</td>
												<td>${att.tot_workhours}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>

							</div>
						</div>
					</div>

				</div>
				<div class="text-center">
					<a href="#" class="btn btn-primary btn-icon-split btn-lg"
						id="arrBtn"> <span class="icon text-white-50"> <i
							class="fas fa-flag"></i>
					</span> <span class="text">출근하기</span>
					</a> <a href="#" class="btn btn-danger btn-icon-split btn-lg"
						id="depBtn"> <span class="icon text-white-50"> <i
							class="fas fa-flag"></i>
					</span> <span class="text">퇴근하기</span>
					</a>
				</div>

				<!-- /.container-fluid (페이지 내용 종료) -->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Orbit ERP presented by TEAM FOUR</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->


	<%@ include
		file="/WEB-INF/views/a04_financeResource/z01_modalAccsub.jsp"%>


	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>
	<!-- Logout Modal-->
	<%@ include file="/WEB-INF/views/a00_module/a08_logout_modal.jsp"%>
	<!-- Bootstrap core JavaScript-->
	<script src="${path}/a00_com/vendor/jquery/jquery.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="${path}/a00_com/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${path}/a00_com/js/sb-admin-2.min.js"></script>

	<!-- 추가 plugins:js -->
	<script src="${path}/a00_com/vendor/js/vendor.bundle.base.js"></script>
	<script src="${path}/a00_com/vendor/datatables/jquery.dataTables.js"></script>
	<script
		src="${path}/a00_com/vendor/datatables/dataTables.bootstrap4.js"></script>
	<script src="${path}/a00_com/js/dataTables.select.min.js"></script>
</body>
</html>