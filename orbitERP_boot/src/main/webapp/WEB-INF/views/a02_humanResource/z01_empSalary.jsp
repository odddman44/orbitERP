<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />

<script>
	$(document).ready(function() {
		// 선택 요소에 월 옵션을 추가합니다.
		for (var i = 1; i <= 12; i++) {
			// 옵션 요소를 생성하여 선택 요소에 추가합니다.
			$('#month').append($('<option>', {
				value : i,
				text : i + '월'
			}));
		}
	});
	
	function search(){
		 $.ajax({
	            url: '/"salaryList'
	            method: 'POST',
	            data:$()
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
</script>
<div class="col-xl-6 col-lg-6">
	<div class="card shadow mb-4">
		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">

			<h6 class="m-0 font-weight-bold text-primary">직원별 급여 정보</h6>
			<button class="btn btn-success" type="button">신규</button>
		</div>


		<div class="card-body">
			<form method="post" >
				<div class="row justify-content-end">
					<div class="col-4">
						<select name="deptno" class="form-control form-control-user">
							<option value="0">부서선택</option>
							<c:forEach var="dept" items="${dlist}">
								<option value="${dept.deptno}">${dept.dname}(${dept.deptno})</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-4">
						<span> <select id="year" class="form-control">
								<option value="">년도</option>
								<c:forEach var="i" begin="2014" end="2024">
									<option value="${i}">${i}년</option>
								</c:forEach>
						</select>
					</div>
					<div class="col-4">
						<select id="month" class="form-control">
							<option value="">월</option>
							<c:forEach var="i" begin="1" end="12">
								<option value="${i}">${i}월</option>
							</c:forEach>
						</select>

					</div>
					<input type="hidden" name="payment_date">
				</div>
			</form>
			<br>
			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable">
					<thead>
						<tr>

							<th>지급일</th>
							<th>사원번호</th>
							<th>기본급</th>
							<th>수당</th>
							<th>공제</th>
							<th>실수령액</th>
							<th>부서명</th>
						</tr>
					</thead>
					<tbody>
						<tr th:each="sal : ${salary}">
							<td th:text="${sal.payment_date}">Payment Date</td>
							<td th:text="${sal.empno}">Employee Number</td>
							<td th:text="${sal.base_salary}">Base Salary</td>
							<td th:text="${sal.allowance}">Allowance</td>
							<td th:text="${sal.deduction}">Deduction</td>
							<td th:text="${sal.net_pay}">Net Pay</td>
							<td th:text="${sal.dname}">Department Name</td>
						</tr>
					</tbody>
				</table>

			</div>
		</div>
	</div>
</div>

