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

	        $.ajax({
	            url: '${path}/grossProfit',
	            method: 'GET',
	            data: {
	                deptno: deptno,
	                startDate: startDate,
	                endDate: endDate
	            },
	            dataType: 'json',
	            success: function(data) {
	                updateTableHeaders(startDate, endDate);
	                updateTableBody(data);
	            },
	            error: function(xhr, status, error) {
	                console.error("Error fetching data: ", error);
	            }
	        });
		});

		// 테이블 헤더 업데이트 함수
	    function updateTableHeaders(startDate, endDate) {
	        var months = generateMonths(startDate, endDate);
	        var headerHtml = '<th>부서</th><th>거래명</th>'; // 기본 컬럼
	        months.forEach(function(month) {
	            headerHtml += `<th>${month}</th>`;
	        });
	        headerHtml += '<th>집계</th>'; // 집계 컬럼 추가
	        $("#gpHeader tr").html(headerHtml);
	    }

		// 테이블 본문 업데이트 함수
		function updateTableBody(data) {
			var bodyHtml = "";
		    var currentTransCname = "";
		    var totalProfit = 0;

		    data.forEach(function(item, index) {
		        // 거래처명이 바뀔 때마다 새로운 행 시작
		        if (currentTransCname !== item.transCname) {
		            // 새로운 거래처명이 시작되기 전에, 이전 거래처의 집계를 표시
		            if (index > 0) {
		                bodyHtml += `<td>${totalProfit.toLocaleString()}</td></tr>`;
		                totalProfit = 0; // 집계 초기화
		            }
		            bodyHtml += `<tr><td>${item.deptno}</td><td>${item.transCname}</td>`;
		            currentTransCname = item.transCname;
		        }
		        // 매출총이익을 해당 월에 표시
		        bodyHtml += `<td>${item.netSalesProfit.toLocaleString()}</td>`;
		        totalProfit += item.netSalesProfit; // 집계 업데이트
		    });

		    // 마지막 거래처의 집계를 표시
		    bodyHtml += `<td>${totalProfit.toLocaleString()}</td></tr>`;
		    $("#gpBody").html(bodyHtml);
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