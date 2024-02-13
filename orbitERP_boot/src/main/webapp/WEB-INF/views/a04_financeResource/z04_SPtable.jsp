<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<script>
	$(document).ready(function() {
		 // 페이지 로드 시 자동으로 데이터 조회
	    fetchData($('#deptno').val(), $('#gpStart').val(), $('#gpEnd').val());
		
		// '검색' 버튼 클릭 이벤트
		$("#schBtn").click(function() {
			var startDate = $('#gpStart').val() || '';
	        var endDate = $('#gpEnd').val() || '';
	        var deptno = $('#deptno').val(); // 부서 번호
	        
	     	// 날짜 유효성 검사
            if (!validateDates(startDate, endDate)) {
                return; // 유효하지 않은 경우, 함수 실행 중단
            }

	        fetchData(deptno, startDate, endDate);
		});
		
		function fetchData(deptno, startDate, endDate) {
			console.log("받아온 부서번호:"+deptno)
			console.log("받아온 시작날짜:"+startDate)
			console.log("받아온 종료날짜:"+endDate)
			
	        $.ajax({
	            url: '/grossProfit?deptno=' + deptno + '&startDate=' + startDate + '&endDate=' + endDate,
	            method: 'GET',
	            success: function(data) {
	            	console.log("Received data:", data); // 데이터 구조 확인
	                updateTableHeaders(startDate, endDate);
	                updateTableBody(data);
	            },
	            error: function(xhr, status, error) {
	                console.error("Error fetching data: ", error);
	            }
	        });
	    }
		
		// 날짜 유효성 검사 함수
        function validateDates(startDate, endDate) {
            var start = new Date(startDate);
            var end = new Date(endDate);
            var oneYearLater = new Date(start);
            oneYearLater.setFullYear(oneYearLater.getFullYear() + 1);

            if (start > end) {
                alert("시작일보다 종료일이 빠를 수 없습니다.");
                return false;
            } else if (end > oneYearLater) {
                alert("최대 조회기간은 1년을 초과할 수 없습니다.");
                return false;
            }
            return true;
        }
		
		// 테이블 헤더 업데이트 함수
	    function updateTableHeaders(startDate, endDate) {
	    	var months = generateMonths(startDate, endDate);
	        var headerHtml = '<th>부서</th><th>거래명</th>'; // 기본 컬럼

	        // 월별 컬럼 추가
	        months.forEach(function(month) {
	            headerHtml += '<th>' + month + '</th>';
	        });

	        headerHtml += '<th>집계</th>'; // 집계 컬럼 추가
	        $("#gpHeader tr").html(headerHtml); // 테이블 헤더 업데이트
	    }

	 	// 테이블 본문 업데이트 함수
	    function updateTableBody(data) {
	        var bodyHtml = '';
	        var months = generateMonths($('#gpStart').val(), $('#gpEnd').val());

	     	// 부서명과 거래명으로 데이터 그룹화
	        var groupedData = {};
	        data.forEach(function(item) {
	            var key = item.deptno + '-' + item.trans_cname;
	            if (!groupedData[key]) {
	                groupedData[key] = [];
	            }
	            groupedData[key].push(item);
	        });

	        // 그룹화된 데이터로 테이블 본문 생성
	        Object.keys(groupedData).forEach(function(key) {
	            var items = groupedData[key];
	            var totalProfit = 0;
	            var shouldDisplayRow = false; // 행을 표시할지 여부
	            
	            var rowHtml = '<tr><td>' + items[0].deptno + '</td><td>' + items[0].trans_cname + '</td>';
	            
	            months.forEach(function(month) {
	                var monthProfit = 0;
	                items.forEach(function(item) {
	                    if(item.yearMonth === month) {
	                        monthProfit += item.netSalesProfit;
	                    }
	                });
	                if (monthProfit !== 0) {
	                    shouldDisplayRow = true; // 이 행에 유효한 데이터가 있으므로 표시
	                }
	                //console.log("월별profit:"+monthProfit)
	                rowHtml += '<td>' + (monthProfit ? monthProfit.toLocaleString() : '0') + '</td>';
	                totalProfit += monthProfit;
	            });

	            rowHtml += '<td>' + totalProfit.toLocaleString() + '</td></tr>'; // 집계 컬럼 추가
	         	// 데이터가 있는 경우에만 행 추가
	            if (shouldDisplayRow) {
	                bodyHtml += rowHtml;
	            }
	        });

	        $("#gpBody").html(bodyHtml);
	    }

	 	// 시작 날짜와 종료 날짜 사이의 모든 월을 배열로 생성하는 함수
	    function generateMonths(startDate, endDate) {
	    	var start = new Date(startDate);
            var end = new Date(endDate);
            var months = [];
            while(start <= end) {
                var month = (start.getMonth() + 1).toString().padStart(2, '0');
                months.push(start.getFullYear() + "-" + month);
                start.setMonth(start.getMonth() + 1);
            }
            return months;
        }
	});
</script>
<!-- 테이블 -->
<div class="col-xl-12 col-lg-12">
	<div class="card shadow">
		<div class="card-header">
			<h6 class="m-0 font-weight-bold text-primary">월별 매출총이익 조회</h6>
			<form id="frm01" class="form" method="GET">
				<div class="form-row align-items-center">
					<div class="col-auto">
						시작날짜 : <input type="month" id="gpStart" name="startDate" value="2023-01" />~
					</div>
					<div class="col-auto">
						마지막날짜 :<input type="month" id="gpEnd" name="endDate" value="2024-01"/>
					</div>
					<label for="accName">부서명</label>
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
					<thead id="gpHeader">
						<tr>
							<!-- 비워놓기? -->
						</tr>
					</thead>
					<tbody id="gpBody">
						<tr>
							<!-- 비워놓기? -->
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>