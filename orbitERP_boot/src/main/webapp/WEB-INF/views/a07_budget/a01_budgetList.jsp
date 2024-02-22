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
<!-- vue.js // Axios  -->
<script src="https://unpkg.com/vue"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
 <!-- jQuery -->
<script src="${path}/a00_com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	var deptAuth = parseInt("${emem.deptno}");
	console.log(deptAuth);
	
	$(document).ready(function() {
		// 데이터 조회 및 표시 함수
	    function fetchBudgetData(year, deptno) {
	        $.ajax({
	            url: '${path}/budgetSch',
	            type: 'GET', // GET 메소드 사용을 권장 (단순 조회의 경우)
	            dataType: 'json',
	            data: {
	                year: year,
	                deptno: deptno
	            },
	            success: function(data) {
	                var tbody = $("#budgetData");
	                tbody.empty(); // 기존 테이블 내용 초기화
	                $.each(data, function(i, budget) {
	                    var row = $('<tr></tr>');
	                    row.append($('<td></td>').text(budget.dname)); // 부서명
	                    row.append($('<td></td>').text(budget.year)); // 연도

	                    // 월별 예산액 추가
	                    for (var month = 1; month <= 12; month++) {
	                        var monthAmount = budget.monthData[month - 1] || '0'; // 해당 월의 데이터가 없으면 '0' 표시
	                        row.append($('<td></td>').text(monthAmount));
	                    }

	                    // 예산 총액 (이 예제에서는 서버 응답에 총액 정보를 포함하고 있다고 가정)
	                    row.append($('<td></td>').text(budget.totalAmount));

	                    tbody.append(row);
	                });
	            },
	            error: function(xhr, status, error) {
	                alert("데이터 로드 중 오류 발생: " + error);
	            }
	        });
	    }

	    // 페이지 로드 시 기본 데이터 조회 및 표시
	    var currentYear = $('#yearSelect').val(); // 선택된 연도 또는 현재 연도
	    fetchBudgetData(currentYear, 0); // 전체 부서에 대한 데이터 요청

	    // 검색 버튼 클릭 이벤트
	    $("#schBtn").click(function() {
	        var year = $('#yearSelect').val(); // 선택된 연도
	        var deptno = $('#deptno').val(); // 선택된 부서 번호
	        fetchBudgetData(year, deptno); // 데이터 조회 및 표시
	    });
	}); // $(document).ready 끝
</script>
	<!-- DB테이블 플러그인 추가 -->
    <link rel="stylesheet" href="${path}/a00_com/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="${path}/a00_com/vendor/datatables/dataTables.bootstrap4.css">
    <link rel="stylesheet" type="text/css" href="${path}/a00_com/js/select.dataTables.min.css">
     <!-- Custom fonts for this template-->
    <link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<!-- font -->
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
					<!-- Page Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">※ 예산 현황</h1>
					</div>
					<!-- Content Row -->
					<div class="row">
						<div class="col-xl-12 col-lg-12">
							<div class="card shadow">
								<div class="card-header">
									<h6 class="m-0 font-weight-bold text-primary">예산 편성 현황</h6>
									<form id="frm01" class="form" method="GET">
										<div class="form-row align-items-center">
											<div class="col-auto">
												<select id="yearSelect" class="form-control">
													<option value="2024" selected>2024년</option>
													<option value="2023">2023년</option>
												</select>
											</div>
											<label for="deptno">부서명</label>
											<div class="col-auto">
										        <select id="deptno" name="deptno" class="form-control">
										        		<option value="0">전체</option>
										        	<c:forEach var="dept" items="${dlist}">
										        		<option value="${dept.deptno}">${dept.dname}[${dept.deptno}]</option>
										        	</c:forEach>
										        </select>
										    </div>
											<div class="col-auto">
												<button type="button" id="schBtn" class="btn btn-secondary">검색</button>
											</div>
										</div>
									</form>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table class="table table-bordered" id="dataTable">
											<thead>
												<tr>
													<th>부서명</th>
													<th>연도</th>
													<th>1월</th>
													<th>2월</th>
													<th>3월</th>
													<th>4월</th>
													<th>5월</th>
													<th>6월</th>
													<th>7월</th>
													<th>8월</th>
													<th>9월</th>
													<th>10월</th>
													<th>11월</th>
													<th>12월</th>
												</tr>
											</thead>
											<tbody id="budgetData">
											
											</tbody>
										</table>
									</div>
								</div>
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

<!-- 추가 plugins:js -->
<script src="${path}/a00_com/vendor/datatables/jquery.dataTables.js"></script>
<script src="${path}/a00_com/vendor/datatables/dataTables.bootstrap4.js"></script>
<script src="${path}/a00_com/js/dataTables.select.min.js"></script>
<!-- Chart JS API -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</body>
</html>