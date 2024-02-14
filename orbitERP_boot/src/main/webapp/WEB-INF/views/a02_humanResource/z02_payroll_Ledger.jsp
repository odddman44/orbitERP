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
            value: i,
            text: i + '월'
        }));
    }
});
</script>
<div class="col-xl-6 col-lg-6">
	<div class="card shadow mb-4">
		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">

			<h6 class="m-0 font-weight-bold text-primary">급여대장 조회</h6>
			<button class="btn btn-success" type="button">신규</button>
		</div>


		<div class="card-body">
		<form>
				<div class="row justify-content-end">
				
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
				</div>
		</form>
		<br>
			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable">
					<thead>
						<tr>

							<th>신고귀속</th>
							<th>급여구분</th>
							<th>지급구분</th>
							<th>대장명칭</th>
							<th>지급일</th>
							<th>인원수</th>
							<th>급여대장</th>
							<th>명세서</th>
							<th>지급총액</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>

			</div>
		</div>
	</div>
</div>