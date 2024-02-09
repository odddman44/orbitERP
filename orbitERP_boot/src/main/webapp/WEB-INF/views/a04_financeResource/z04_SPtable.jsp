<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<script>
	$(document).ready(function() {
		// '검색' 버튼 클릭 이벤트
		$("#schBtn").click(function() {
			var startDate = $('input[name="startDate"]').val();
	        var endDate = $('input[name="endDate"]').val();
	        var deptno = $('#deptno').val(); // 부서 번호

	        fetchData(deptno, startDate, endDate);
		});
		
		function fetchData(deptno, startDate, endDate) {
	        $.ajax({
	            url: '/grossProfit?deptno=' + deptno + '&startDate=' + startDate + '&endDate=' + endDate,
	            method: 'GET',
	            success: function(data) {
	            	console.log(data)
	                updateTableHeaders(startDate, endDate);
	                updateTableBody(data);
	            },
	            error: function(xhr, status, error) {
	                console.error("Error fetching data: ", error);
	            }
	        });
	    }
		
		// 테이블 헤더 업데이트 함수
	    function updateTableHeaders(startDate, endDate) {
	    	var months = generateMonths(startDate, endDate);
	        var headerHtml = '<th>부서</th><th>거래명</th>'; // 기본 컬럼

	        // 월별 컬럼 추가
	        months.forEach(function(month) {
	            headerHtml += `<th>${month}</th>`;
	        });

	        headerHtml += '<th>집계</th>'; // 집계 컬럼 추가
	        $("#gpHeader").html(headerHtml); // 테이블 헤더 업데이트
	    }

		// 테이블 본문 업데이트 함수
		function updateTableBody(data) {
		    // 각 거래처명 및 월별 매출총이익을 테이블에 표시하는 로직
		    var bodyHtml = '';
		    
		    data.forEach(function(item) {
		        // 테이블의 각 행을 동적으로 생성
		        bodyHtml += `<tr>
		                        <td>${item.deptno}</td>
		                        <td>${item.trans_cname}</td>`;
		
		        // 'generateMonths' 함수를 사용하여 생성된 월 범위에 따라 셀 추가
		        var months = generateMonths($('input[name="startDate"]').val(), $('input[name="endDate"]').val());
		        months.forEach(function(month) {
		            if (month === item.yearMonth) {
		                bodyHtml += `<td>${item.netSalesProfit.toLocaleString()}</td>`; // 해당 월에 매출총이익 표시
		            } else {
		                bodyHtml += `<td></td>`; // 해당 월이 아닌 경우 빈 셀 추가
		            }
		        });
		
		        bodyHtml += '</tr>';
		    });
		
		    $("#gpBody").html(bodyHtml); // 생성된 HTML을 테이블 본문에 삽입
		}
				
		// 시작 날짜와 종료 날짜 사이의 모든 월을 배열로 생성하는 함수
	    function generateMonths(startDate, endDate) {
	        var start = new Date(startDate);
	        var end = new Date(endDate);
	        var months = [];
	        while(start <= end) {
	            months.push(start.getFullYear() + "." + (start.getMonth() + 1).toString().padStart(2, '0'));
	            start.setMonth(start.getMonth() + 1);
	        }
	        return months;
	    }
	});
</script>
<!-- 테이블 -->
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">월별 매출총이익 조회</h6>
		<form id="frm01" class="form" method="GET">
			<div class="form-row align-items-center">
				<div class="col-auto">
					시작날짜 : <input type="month" name="startDate" value="" />~
				</div>
				<div class="col-auto">
					마지막날짜 :<input type="month" name="endDate" value=""/>
				</div>
				<label for="accName">부서명</label>
				<div class="col-auto">
			        <select id="deptno" name="deptno" class="form-control">
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