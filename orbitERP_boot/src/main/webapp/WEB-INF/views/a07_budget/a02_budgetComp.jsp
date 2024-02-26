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
        // 연도 선택 드롭다운 목록에 옵션 추가
        var currentYear = new Date().getFullYear();
        initializeYearSelect(currentYear);
        // 페이지 로딩 완료 후 자동으로 현재 년도, 모든 부서에 대한 데이터 조회
        fetchDataAndDisplayTable(currentYear, 0);

        // 검색 버튼 이벤트 핸들러
        $("#schBtn").click(function() {
            var selectedYear = $('#yearSelect').val();
            var selectedDeptno = $('#deptno').val();
            fetchDataAndDisplayTable(selectedYear, selectedDeptno);
        });
		
        function initializeYearSelect(currentYear) {
            for (var year = currentYear - 1; year <= currentYear + 2; year++) {
                $('#yearSelect').append($('<option>', {
                    value: year,
                    text: year + '년',
                    selected: year === currentYear
                }));
            }
        }
        
        // 예산 데이터와 실제 지출 데이터 비교하여 테이블 생성
        function fetchDataAndDisplayTable(year, deptno) {
	        $.when(fetchBudgetData(year, deptno), fetchActualExpenses(year, deptno))
	            .done(function(budgetDataResponse, actualExpensesResponse) {
	                // 예산 데이터와 실제 지출 데이터 처리
	                var budgetData = budgetDataResponse[0];
	                var actualExpensesData = actualExpensesResponse[0];
	                createComparisonTable(budgetData, actualExpensesData);
	            });
  	 	}
        function fetchBudgetData(year, deptno) {
            return $.ajax({
                url: '${path}/budgetSch',
                type: 'GET',
                data: { year: year, deptno: deptno }
            });
        }

        function fetchActualExpenses(year, deptno) {
            return $.ajax({
                url: '${path}/actualExpense',
                type: 'GET',
                data: { year: year, deptno: deptno }
            });
        }
        
        // 비교 테이블 생성 함수
        function createComparisonTable(budgetList, actualExpenses) {
            var table = $('#dataTable');
            table.empty(); // 테이블 초기화

            // 월별로 테이블 헤더와 데이터 행 생성
            for(var month = 1; month <= 12; month++) {
            	var monthBudget = budgetList.filter(item => item.month === month);
                var monthExpenses = actualExpenses.filter(item => item.month === month);
                // 테이블 헤더 생성
                var row  = $('<thead id="compHead'+month+'"><tr class="table-info text-center">' +
                    '<th rowspan="2">부서명</th>' +
                    '<th colspan="4">'+month+'월 예산 실적</th>' +
                    '</tr><tr class="table-secondary text-center">' +
                    '<th>예산</th>' +
                    '<th>실적</th>' +
                    '<th>비교(예산-실적)</th>' +
                    '<th>비율(실적/예산)</th>' +
                    '</tr></thead>');
                table.append(row);

                // 해당 월에 대한 데이터만 필터링
                var monthlyBudgetList = budgetList.filter(function(budget) {
                    return budget.month === month;
                });
                var monthlyActualExpenses = actualExpenses.filter(function(expense) {
                    return expense.month === month;
                });

                // 테이블 바디에 데이터 행 추가
                var tbody = $('<tbody id="compBody'+month+'" style="text-align:right;"></tbody>');
                monthlyBudgetList.forEach(function(budget) {
                    var actual = monthlyActualExpenses.find(function(expense) {
                        return expense.deptno === budget.deptno;
                    }) || { totalDebitAmount: 0 };

                    var diff = budget.month_amount - actual.totalDebitAmount;
                    var ratio = actual.totalDebitAmount / budget.month_amount * 100 || 0;
                    var diffColor = diff < 0 ? 'red' : 'blue'; // 차이에 따른 글씨 색상 결정


                    tbody.append('<tr>' +
                        '<td>' + budget.dname + '</td>' +
                        '<td>' + budget.month_amount.toLocaleString() + '</td>' +
                        '<td>' + actual.totalDebitAmount.toLocaleString() + '</td>' +
                        '<td style="color:' + diffColor + ';">' + diff.toLocaleString() + '</td>' + // 색상 적용
                        '<td>' + ratio.toFixed(2) + '%</td>' +
                        '</tr>');
                });
                table.append(tbody);
            }
        }
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
						<h1 class="h3 mb-0 text-gray-800">※ 예산 실적 비교</h1>
					</div>
					<!-- Content Row -->
					<div class="row">
						<div class="col-xl-12 col-lg-12">
							<div class="card shadow">
								<div class="card-header">
									<h6 class="m-0 font-weight-bold text-primary">예산 실적 비교표</h6>
									<form id="frm01" class="form" method="GET">
										<div class="form-row align-items-center">
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
												<select id="yearSelect" class="form-control">
													<option value="0" selected>연도선택</option>
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
										<table class="table table-hover table-striped table-bordered" id="dataTable">
											<thead id="compHead">
												<tr class="table-info text-center">
													
												</tr>
											</thead>
											<tbody id="compBody" style="text-align:right;">
									
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

<!-- 추가 plugins:js -->
<script src="${path}/a00_com/vendor/datatables/jquery.dataTables.js"></script>
<script src="${path}/a00_com/vendor/datatables/dataTables.bootstrap4.js"></script>
<script src="${path}/a00_com/js/dataTables.select.min.js"></script>
<!-- Chart JS API -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</body>
</html>