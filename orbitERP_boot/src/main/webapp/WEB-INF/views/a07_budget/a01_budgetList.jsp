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
		var currentYear = new Date().getFullYear();
	    var startYear = 2023;
	    var endYear = currentYear + 2;
	 	// 조회 부분의 연도 선택에 옵션 동적 추가
	    for (var year = startYear; year <= endYear; year++) {
	        $('#yearSelect').append($('<option>', {
	            value: year,
	            text: year + '년'
	        }));
	    }
		 // 등록 모달창의 연도 선택에 옵션 동적 추가
        for (var year = currentYear; year <= endYear; year++) {
            $('#stdYear').append($('<option>', {
                value: year,
                text: year + '년',
                selected: year === currentYear // 현재 연도 기본 선택
            }));
        }
		
		// 연간 예산 총액 입력란과 월별 예산 입력란에 이벤트 핸들러 설정
	    $("#totalBudget, .monthlyBudget").change(function() {
	        updateBudgetDiff();
	    });
		 // 연간 예산 총액과 월별 예산액의 차이를 계산하고 표시하는 함수.
	    function updateBudgetDiff() {
	        var totalBudget = parseFloat($("#totalBudget").val()) || 0; // 연간 예산 총액
	        var totalMonthlyBudget = 0; // 월별 예산액의 총합

	        // 각 월별 예산액의 합계를 계산합니다.
	        $(".monthlyBudget").each(function() {
	            totalMonthlyBudget += parseFloat($(this).val()) || 0;
	        });

	        var diff = totalBudget - totalMonthlyBudget; // 차이 계산
	        var diffText = "일치"; // 표시할 텍스트
	        var color = "green"; // 텍스트 색상

	        if (diff > 0) {
	            diffText = "미달: " + diff.toLocaleString();
	            color = "blue";
	        } else if (diff < 0) {
	            diffText = "초과: " + Math.abs(diff).toLocaleString();
	            color = "red";
	        }

	        // 결과 표시
	        $("#budgetDiff").text(diffText).css("color", color);
	    }
		 
	    function fetchBudgetData(year, deptno) {
	        $.ajax({
	            url: '${path}/budgetSch', // 서버 엔드포인트 URL로 변경 필요
	            type: 'GET',
	            dataType: 'json',
	            data: { year: year, deptno: deptno },
	            success: function(data) {
	                var tbody = $("#budgetData");
	                tbody.empty();

	                // 부서명과 연도별로 그룹화된 데이터를 담을 객체 초기화
	                let groupedData = {};

	                // 데이터 그룹화
	                data.forEach(function(item) {
	                    var key = item.dname + '_' + item.year;
	                    if (!groupedData[key]) {
	                        groupedData[key] = { dname: item.dname, year: item.year, amounts: Array(12).fill(0), total: 0 };
	                    }
	                    groupedData[key].amounts[item.month - 1] = item.month_amount;
	                    groupedData[key].total += item.month_amount;
	                });

	                // 그룹화된 데이터를 테이블에 추가
	                Object.values(groupedData).forEach(function(group) {
	                    var row = $('<tr></tr>');
	                    row.append($('<td></td>').text(group.dname)); // 부서명
	                    row.append($('<td></td>').text(group.year)); // 연도
	                    group.amounts.forEach(function(amount, index) {
	                        row.append($('<td></td>').text(amount ? amount.toLocaleString() : '-')); // 월별 예산액
	                    });
	                    row.append($('<td></td>').text(group.total.toLocaleString())); // 합계
	                    tbody.append(row);
	                });
	            },
	            error: function(xhr, status, error) {
	                console.error("Error: " + error);
	                alert("데이터 로드 중 오류 발생");
	            }
	        });
	    }

	    // 초기 데이터 로드
	    var currentYear = $('#yearSelect').val(); // 현재 선택된 연도
	    fetchBudgetData(currentYear, 0);

	    // 검색 버튼 이벤트
	    $("#schBtn").click(function() {
	        var year = $('#yearSelect').val();
	        var deptno = $('#deptno').val();
	        fetchBudgetData(year, deptno);
	    });
	    
		// 예산 편성 버튼 클릭 이벤트 핸들러
	    $("#newBtn").click(function() {
	        // 모달 창 표시
	        $("#newBudgetModal").modal('show');
	    });
		
	    $("#divideBtn").click(function() {
	    	var totalBudget = parseInt($("#totalBudget").val()) || 0; // 연간 예산 총액 입력값
	        var baseMonthlyBudget = Math.floor(totalBudget / 12 / 10000) * 10000; // 10,000단위로 떨어지게 12로 나누고 내림
	        var remainder = totalBudget - (baseMonthlyBudget * 12); // 전체에서 나눈 값의 합을 뺀 나머지
	        var lastMonthAdditional = remainder; // 12월에 더할 나머지 값

	        // 1월부터 11월까지의 월별 예산액 입력란에 기본 월별 예산액 할당
	        for (var month = 1; month <= 11; month++) {
	            $("#month" + month).val(baseMonthlyBudget);
	        }

	        // 12월의 예산액에 나머지를 더해서 할당
	        $("#month12").val(baseMonthlyBudget + lastMonthAdditional);
	        
	        updateBudgetDiff(); // 예산 차이 업데이트 함수 호출
	    });
	    
	 	// 예산 등록 버튼 클릭 이벤트
	    $("#regFrmBtn").click(function() {
	        var budgets = [];
	        var year = $("#stdYear").val();
	        var deptno = $("#deptno2").val();

	        $(".monthlyBudget").each(function(index) {
	            var monthAmount = $(this).val();
	            if (monthAmount) {
	                budgets.push({
	                    year: year,
	                    month: index + 1,
	                    deptno: deptno,
	                    month_amount: monthAmount
	                });
	            }
	        });

	        // AJAX 요청으로 서버에 데이터 전송
	        $.ajax({
	            url: '${path}/budgetInsert', // 서버 엔드포인트 URL
	            type: 'POST',
	            contentType: 'application/json', // 요청의 Content-Type
	            data: JSON.stringify(budgets), // JSON 문자열로 변환
	            dataType : 'json',
	            success: function(response) {
	                alert('예산 데이터가 성공적으로 등록되었습니다.');
	                $("#newBudgetModal").modal('hide'); // 모달 닫기
	                // 성공 후 필요한 동작 추가(예: 테이블 데이터 갱신 등)
	            },
	            error: function(xhr, status, error) {
	                alert('예산 데이터 등록 중 오류가 발생했습니다. ' + error);
	            }
	        });
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
													<option value="0" selected>연도선택</option>
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
										<table class="table table-hover table-striped table-bordered" id="dataTable">
											<thead>
												<tr class="table-secondary text-center">
													<th>부서명</th><th>연도</th>
													<th>1월</th><th>2월</th><th>3월</th>
													<th>4월</th><th>5월</th><th>6월</th>
													<th>7월</th><th>8월</th><th>9월</th>
													<th>10월</th><th>11월</th><th>12월</th>
													<th>합계</th>
												</tr>
											</thead>
											<tbody id="budgetData" style="text-align:right;">
									
											</tbody>
										</table>
										<div>
											<button type="button" id="newBtn" class="btn btn-info">예산 편성</button>
										</div>
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
<!-- 모달 창 -->
<div class="modal fade" id="newBudgetModal" tabindex="-1" role="dialog" aria-labelledby="newBudgetModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="newBudgetModalLabel">월별 예산 편성</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="frm02" method="POST" class="text-left">
				    <div class="form-group row">
				    	<div class="col-md-4">
					        <label for="stdYear">기준년도</label>
							<select id="stdYear" class="form-control" name="stdYear" required>
							</select>
							<label for="accName">부서명</label>
					        <select id="deptno2" class="form-control">
					        	<c:forEach var="dept" items="${dlist}">
					        		<option value="${dept.deptno}">${dept.dname}[${dept.deptno}]</option>
					        	</c:forEach>
					        </select>
				        </div>
				    </div>
				    <hr>
				    <h5>연간 예산 총액</h5>
					<input type="number" id="totalBudget" class="form-control" style="display: inline-block; 
							width: auto;" placeholder="예산 총액 입력">
					<button type="button" id="divideBtn" class="btn btn-success btn-icon-split">
					    <span class="icon text-white-50"><i class="fas fa-divide"></i></span>
					    <span class="text">균등분배</span>
					</button>
					<span id="budgetDiff" style="margin-left: 20px;"></span>
                    <br>
		            <div class="table-responsive" >
					   <table class="table table-hover table-striped table-bordered" style="width:100%;">
						   <thead id="head1">
				               <tr class="table-primary text-center">
					               <th>1월</th>
					               <th>2월</th>
					               <th>3월</th>
					               <th>4월</th>
					               <th>5월</th>
					               <th>6월</th>
				               </tr>
			               </thead>
			               <tbody id="modalTbody1">
			               <tr>
							<td><input type="number" id="month1" class="form-control monthlyBudget"></td>
					        <td><input type="number" id="month2" class="form-control monthlyBudget"></td>
					        <td><input type="number" id="month3" class="form-control monthlyBudget"></td>
					        <td><input type="number" id="month4" class="form-control monthlyBudget"></td>
					        <td><input type="number" id="month5" class="form-control monthlyBudget"></td>
					        <td><input type="number" id="month6" class="form-control monthlyBudget"></td>
					       </tr>
			               </tbody>
						   <thead id="head2">
				               <tr class="table-primary text-center">
					               <th>7월</th>
					               <th>8월</th>
					               <th>9월</th>
					               <th>10월</th>
					               <th>11월</th>
					               <th>12월</th>
				               </tr>
			               </thead>
			               <tbody id="modalTbody2">
			               <tr>
							<td><input type="number" id="month7" class="form-control monthlyBudget"></td>
					        <td><input type="number" id="month8" class="form-control monthlyBudget"></td>
					        <td><input type="number" id="month9" class="form-control monthlyBudget"></td>
					        <td><input type="number" id="month10" class="form-control monthlyBudget"></td>
					        <td><input type="number" id="month11" class="form-control monthlyBudget"></td>
					        <td><input type="number" id="month12" class="form-control monthlyBudget"></td>
					       </tr>
			               </tbody>
					   </table>
					</div>     
				</form>
            </div>
            <hr style="border-color: #46bcf2;">
            <div class="modal-footer d-flex justify-content-between" >
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" id="regFrmBtn" form="registerForm" class="btn btn-primary">예산등록</button>
                <button type="button" id="uptBtn" form="registerForm" class="btn btn-info">수정</button>
            </div>
        </div>
    </div>
</div>
<!-- 모달창 종료 -->

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