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
		
	 	// 숫자 입력 필드에 콤마 추가
	    $(".monthlyBudget, #totalBudget").on('input', function() {
            var value = $(this).val().replace(/,/g, ''); // 콤마 제거
            var valueWithCommas = addCommas(value); // 콤마 추가
            $(this).val(valueWithCommas);
        });
	 	
	 	// 숫자에 콤마를 추가하는 함수
        function addCommas(nStr) {
            nStr = parseFloat(nStr); // 입력 값을 숫자로 변환
            if (!nStr) { // 값이 0이거나 변환 불가능한 경우 공백 반환
                return "";
            }
            nStr += ''; // 숫자를 문자열로 변환
            var x = nStr.split('.');
            var x1 = x[0];
            var x2 = x.length > 1 ? '.' + x[1] : '';
            var rgx = /(\d+)(\d{3})/;
            while (rgx.test(x1)) {
                x1 = x1.replace(rgx, '$1' + ',' + '$2');
            }
            return x1 + x2;
        }
	 	
    	// 콤마 제거하기
        function removeComma(str) {
            return str.replace(/,/g, '');
        }
    	
     // 예산 등록/수정/삭제 버튼 클릭 이벤트에 권한 확인 로직 추가
        function checkAuthAndProceed(callback) {
            if (deptAuth !== 1 && deptAuth !== 20) {
                alert("권한이 없는 이용자입니다.");
                return;
            }
            callback();
        }

        // 연간 예산과 월별 예산액의 합계 일치 확인
        function isBudgetSumMatched() {
            var totalBudget = parseInt(removeComma($("#totalBudget").val())) || 0;
            var totalMonthlyBudget = 0;
            $(".monthlyBudget").each(function() {
                totalMonthlyBudget += parseInt(removeComma($(this).val())) || 0;
            });

            if (totalBudget !== totalMonthlyBudget) {
                alert("연간 예산과 월별 예산액의 합계가 일치하지 않습니다.");
                return false;
            }
            return true;
        }
		 
		// 연간 예산 총액 입력란과 월별 예산 입력란에 이벤트 핸들러 설정
	    $("#totalBudget, .monthlyBudget").change(function() {
	        updateBudgetDiff();
	    });
		 // 연간 예산 총액과 월별 예산액의 차이를 계산하고 표시하는 함수.
	    function updateBudgetDiff() {
	        var totalBudget = parseInt(removeComma($("#totalBudget").val())) || 0; // 연간 예산 총액
	        var totalMonthlyBudget = 0; // 월별 예산액의 총합

	        // 각 월별 예산액의 합계를 계산합니다.
	        $(".monthlyBudget").each(function() {
	            totalMonthlyBudget += parseInt(removeComma($(this).val())) || 0;
	        });

	        var diff = totalBudget - totalMonthlyBudget; // 차이 계산
            displayDiff(diff); // 차이 표시
	    }
		 
		// 차이 표시 함수
        function displayDiff(diff) {
            var diffText = diff === 0 ? "일치" : diff > 0 ? "미달: " + addCommas(diff) : "초과: " + addCommas(Math.abs(diff));
            var color = diff === 0 ? "green" : diff > 0 ? "blue" : "red";
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
	                    	groupedData[key] = {
	                                dname: item.dname, 
	                                year: item.year, 
	                                deptno: item.deptno, // deptno 값을 포함시키기
	                                amounts: Array(12).fill(0), 
	                                total: 0
	                            };
	                    }
	                    groupedData[key].amounts[item.month - 1] = item.month_amount;
	                    groupedData[key].total += item.month_amount;
	                });

	                // 그룹화된 데이터를 테이블에 추가
	                Object.values(groupedData).forEach(function(group) {
	                	var row = $('<tr></tr>').data('deptno', group.deptno) // 행에 deptno 데이터 속성 추가
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
	    	if (deptAuth !== 1 && deptAuth !== 20) {
	            alert("권한이 없는 이용자입니다.");
	            return; // 함수 실행 종료
	        }
	    	
	    	$("#frm02")[0].reset();
	        // 모달 창 표시
	        $("#newBudgetModal").modal('show');
	    	 // 모달창 제목 변경
	        $('#newBudgetModalLabel').text('예산 편성').parent().css
			({'background-color': '#5F04B4', 'color': '#ffffff'});
	        $('#regFrmBtn').show();  // 등록 버튼 보이기
	        $('#uptBtn').hide();     // 수정 버튼 숨기기
	        $('#delBtn').hide();     // 삭제 버튼 숨기기
	    });
		
	    $("#divideBtn").click(function() {
	    	// 연간 예산 총액 입력값
	    	var totalBudget = parseInt(removeComma($("#totalBudget").val())) || 0; 
	    	// 10,000단위로 떨어지게 12로 나누고 내림
	        var baseMonthlyBudget = Math.floor(totalBudget / 12 / 10000) * 10000; 
	  	    // 전체에서 나눈 값의 합을 뺀 나머지
	        var remainder = totalBudget - (baseMonthlyBudget * 12); 
	        var lastMonthAdditional = remainder; // 12월에 더할 나머지 값

	        // 1월부터 11월까지의 월별 예산액 입력란에 기본 월별 예산액 할당
	        for (var month = 1; month <= 11; month++) {
	            $("#month" + month).val(addCommas(baseMonthlyBudget));
	        }

	        // 12월의 예산액에 나머지를 더해서 할당
	        $("#month12").val(addCommas(baseMonthlyBudget + lastMonthAdditional));
	        
	        updateBudgetDiff(); // 예산 차이 업데이트 함수 호출
	    });
	    
	 	// 예산 등록 버튼 클릭 이벤트
	    $("#regFrmBtn").click(function() {
	        var budgets = [];
	        var year = $("#stdYear").val();
	        var deptno = $("#deptno2").val();

	        $(".monthlyBudget").each(function(index) {
	            var monthAmount = removeComma($(this).val());
	            if (monthAmount) {
	                budgets.push({
	                    year: year,
	                    month: index + 1,
	                    deptno: deptno,
	                    month_amount: parseFloat(monthAmount)
	                });
	            }
	        });
	        
	        checkAuthAndProceed(function() {
                if (!isBudgetSumMatched()) return;

                // AJAX 요청 코드...
		     	// 모든 값이 올바르게 포맷되고 콤마가 제거되었는지 확인
		        if (budgets.length > 0) {
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
			                fetchBudgetData(year, deptno); // 최신 데이터로 테이블 갱신
			                location.reload(); // 페이지를 새로고침하여 최신 데이터 표시
			            },
			            error: function(xhr, status, error) {
			                alert('예산 데이터 등록 중 오류가 발생했습니다. ' + error);
			            }
			        });
		        } else {
		        	alert("예산 필드를 올바르게 작성하세요.");
		        }
            });
	    });
	 	
	 	// 테이블 행 더블클릭 이벤트 리스너
	    $('#dataTable tbody').on('dblclick', 'tr', function() {
	        var year = $(this).find('td:eq(1)').text().trim(); // 연도 정보 추출
	        var deptno = parseInt($(this).data('deptno')); // 부서 번호 추출, data-deptno 속성 필요
	        
	        if (deptAuth !== 1 && deptAuth !== 20) {
	            alert("권한이 없는 이용자입니다.");
	            return; // 함수 실행 종료
	        }

	        // AJAX 요청으로 서버에서 예산 정보 조회
	        $.ajax({
	            url: '${path}/budgetDetails',
	            type: 'GET',
	            data: { year: year, deptno: deptno },
	            dataType: 'json',
	            success: function(response) {
	                // 모달의 입력 필드에 조회한 예산 정보 채우기
	                $('#stdYear').val(year);
	                $('#deptno2').val(deptno);

	                // 월별 예산액 초기화
	                $('.monthlyBudget').each(function() {
	                    $(this).val('');
	                });

	                // 월별 예산액 채우기
	                response.forEach(function(budget) {
	                    $('#month' + budget.month).val(budget.month_amount.toLocaleString());
	                });

	                // 총 예산액 계산
	                var totalBudget = response.reduce(function(sum, budget) {
	                    return sum + budget.month_amount;
	                }, 0);

	                $('#totalBudget').val(totalBudget.toLocaleString());

	                // 모달창 제목 변경 및 버튼 상태 조정
	                $('#newBudgetModalLabel').text('예산 수정/삭제').parent().css
					({'background-color': '#D7DF01', 'color': '#ffffff'});
	                $('#regFrmBtn').hide();
	                $('#uptBtn').show();
	                $('#delBtn').show();

	                // 모달 표시
	                $('#newBudgetModal').modal('show');
	            },
	            error: function(xhr, status, error) {
	                alert('예산 정보를 불러오는데 실패했습니다: ' + error);
	            }
	        });
	    });
	 	
	    $("#uptBtn").click(function() {
	        var year = $("#stdYear").val();
	        var deptno = $("#deptno2").val();
	        var budgets = $(".monthlyBudget").map(function() {
	            return {
	                year: year,
	                deptno: deptno,
	                month: $(this).data("month"), // data-month 속성에서 월 정보 가져옴
	                month_amount: parseFloat(removeComma($(this).val())) // 콤마 제거 후 숫자로 변환
	            };
	        }).get();
	        checkAuthAndProceed(function() {
                if (!isBudgetSumMatched()) return;
                // AJAX 요청 코드...
		        // 예산 수정 AJAX 요청
		        $.ajax({
		            url: '${path}/updateBudget',
		            type: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify(budgets), // 수정된 부분: budgetData 대신 budgets 사용
		            dataType: "json",
		            success: function(response) {
		                //alert("업데이트된 행의 수: " + response.updateCount);
		                $("#newBudgetModal").modal('hide');
		                fetchBudgetData(year, deptno); // 데이터 재조회
		                location.reload(); // 페이지를 새로고침하여 최신 데이터 표시
		            },
		            error: function(xhr, status, error) {
		                alert('예산 수정 실패: ' + error);
		            }
		        });
            });
	    });

		// 예산 삭제 버튼 클릭 이벤트
	    $("#delBtn").click(function() {
	        var year = $("#stdYear").val();
	        var deptno = $("#deptno2").val();
	        checkAuthAndProceed(function() {
                // AJAX 요청 코드...
		        // 사용자에게 삭제 확인 요청
		        if(confirm("선택한 예산을 삭제하시겠습니까?")) {
		            // 예산 삭제 AJAX 요청
		            $.ajax({
		                url: '${path}/deleteBudget?year=' + year + '&deptno=' + deptno, // + 연산자를 사용하여 URL 구성
		                type: 'POST',
		                success: function(response) {
		                    alert(response);
		                    $("#newBudgetModal").modal('hide');
		                    fetchBudgetData(year, deptno); // 데이터 재조회
		                    location.reload(); // 페이지를 새로고침하여 최신 데이터 표시
		                },
		                error: function(xhr, status, error) {
		                    alert('예산 삭제 실패: ' + error);
		                }
		            });
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
						<span>Copyright &copy; Orbit ERP presented by TEAM FOUR</span>
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
								<option value="2023">2023년</option>
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
					<input type="text" id="totalBudget" class="form-control" style="display: inline-block; 
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
							<td><input type="text" id="month1" class="form-control monthlyBudget" data-month="1"></td>
					        <td><input type="text" id="month2" class="form-control monthlyBudget" data-month="2"></td>
					        <td><input type="text" id="month3" class="form-control monthlyBudget" data-month="3"></td>
					        <td><input type="text" id="month4" class="form-control monthlyBudget" data-month="4"></td>
					        <td><input type="text" id="month5" class="form-control monthlyBudget" data-month="5"></td>
					        <td><input type="text" id="month6" class="form-control monthlyBudget" data-month="6"></td>
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
							<td><input type="text" id="month7" class="form-control monthlyBudget" data-month="7"></td>
					        <td><input type="text" id="month8" class="form-control monthlyBudget" data-month="8"></td>
					        <td><input type="text" id="month9" class="form-control monthlyBudget" data-month="9"></td>
					        <td><input type="text" id="month10" class="form-control monthlyBudget" data-month="10"></td>
					        <td><input type="text" id="month11" class="form-control monthlyBudget" data-month="11"></td>
					        <td><input type="text" id="month12" class="form-control monthlyBudget" data-month="12"></td>
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
                <button type="button" id="uptBtn" form="registerForm" class="btn btn-success">수정</button>
                <button type="button" id="delBtn" form="registerForm" class="btn btn-danger">삭제</button>
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