<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<script>
	$(document).ready(function() {
		
	});
</script>
<!-- 테이블 -->
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">월별 매출총이익 조회</h6>
		<form id="frm01" class="form" method="GET">
			<div class="form-row align-items-center">
				<div class="col-auto">
					시작날짜 : <input type="date" name="startDate" value="" />~
				</div>
				<div class="col-auto">
					마지막날짜 :<input type="date" name="endDate" value=""/>
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
				<thead>
					<tr>
						<th>부서</th>
						<th>거래명</th>
						<th>가변테이블로 넣을 부분</th>
						<th>집계</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>default</td>
						<td>default</td>
						<td>default</td>
						<td>default</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>