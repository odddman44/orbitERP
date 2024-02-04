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
						<h1 class="h3 mb-0 text-gray-800">☆ 직원 근태정보 조회</h1>
					</div>
					<!-- 테이블 -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">날짜로 직원 근태 조회</h6>
							<form id="frm01" class="form" method="POST">
								시작날짜 : <input type="date" name="start_date" value="${attendanceSch.start_date}" /> ~ 마지막날짜
								:<input type="date" name="end_date" value="${attendanceSch.end_date}" />
								<nav class="navbar navbar-expand-sm navbar-light bg-light">
									<select name="empno" class="form-control form-control-user">
										<option value="">사원번호</option>
										<c:forEach var="empno" items="${empnoList}">
											<option>${empno}</option>
										</c:forEach>
									</select> <select name="deptno" class="form-control form-control-user">
										<option value="0">부서선택</option>
										<c:forEach var="dept" items="${dlist}">
											<option value="${dept.deptno}">${dept.dname}(${dept.deptno})</option>
										</c:forEach>
									</select>
									

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

	<!-- 모달 창 -->
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog"
		aria-labelledby="registerModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="registerModalLabel">전표 등록</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="frm02" method="POST" class="text-left">
						<div class="form-group row">
							<div class="col-md-4">
								<!-- 전표일자 입력 -->
								<label for="voucerDate">전표일자</label> <input type="date"
									class="form-control" id="voucher_date" name="voucher_dateStr"
									required />
								<!-- 거래처명 표시 -->
								<label for="accCode">거래처명</label> <input type="text"
									class="form-control" id="trans_cname" name="trans_cname"
									placeholder="거래(처)명 입력.." required>
							</div>
							<div class="col-md-4">
								<!-- 전표번호 입력 -->
								<label for="voucherNo">전표번호</label> <input type="number"
									class="form-control" id="voucher_no" name="voucher_no"
									placeholder="전표 No. 입력" required>
								<!-- 부서명 표시 -->
								<label for="accName">부서명</label>
								<!--input type="text" class="form-control" id="dname" name="dname" placeholder="부서명 선택" required-->
								<select name="deptno" class="form-control">
									<c:forEach var="dept" items="${dlist}">
										<option value="${dept.deptno}">${dept.dname}[${dept.deptno}]</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<!-- 적요 입력/숨은 총계창 -->
						<div class="form-group">
							<label for="remarks">적요</label> <input type="text"
								class="form-control underlined-input" id="remarks"
								name="remarks" placeholder="적요를 입력하세요"> <input
								type="hidden" id="total_amount" name="total_amount" />
						</div>
						<hr>
						<span>분개 상세 입력</span>
						<!-- 테이블 행 추가 버튼 -->
						<button type="button" class="btn btn-secondary" id="addRowBtn">추가</button>
						<div class="table-responsive">
							<table class="table table-hover table-striped table-bordered"
								style="width: 100%;">
								<thead>
									<tr class="table-primary text-center">
										<th>계정코드</th>
										<th>차변</th>
										<th>계정명</th>
										<th>대변</th>
										<th>거래(처)명</th>
										<th>적요</th>
									</tr>
								</thead>
								<tbody id="modalTable">

									</tr>

								</tbody>
							</table>
						</div>
					</form>
				</div>
				<hr style="border-color: #46bcf2;">
				<div class="modal-footer d-flex justify-content-between">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
					<button type="button" id="regFrmBtn" form="registerForm"
						class="btn btn-primary">등록</button>
					<button type="button" id="uptBtn" form="registerForm"
						class="btn btn-info">수정</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 모달창 종료 -->
	<!-- 계정과목 조회 모달창 -->
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
	<script
		src="${path}/a00_com/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
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