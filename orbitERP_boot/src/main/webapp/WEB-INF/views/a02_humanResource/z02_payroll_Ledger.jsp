<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<script>
	$(document).ready(function() {

		// searchStub()

		// 선택 요소에 월 옵션을 추가합니다.
		for (var i = 1; i <= 12; i++) {
			// 옵션 요소를 생성하여 선택 요소에 추가합니다.
			$('#month').append($('<option>', {
				value : i,
				text : i + '월'
			}));
		}

		$("#newBtn2").click(function() {
			// alert("신규버튼 클릭!")
			$("#upt2Btn").hide();
			$("#del2Btn").hide()
			$("#regBtn").show();
			$('#registerModal2').modal('show');
		})

	});

	/*
	 function searchStub(){
	 var deptno = $("#frm02 select[name=deptno]").val();
	 console.log("부서번호"+deptno)
	 var year = $("#frm02 select[name=year]").val();
	 console.log("연도"+deptno)
	 var month = $("#frm02 select[name=month]").val();
	 console.log("달"+month)

	 $.ajax({
	 url: "/paystubList",
	 data: {
	 deptno: deptno,
	 year: year,
	 month: month
	 },
	 dataType: "json",
	 type: "GET",
	 success: function(stub) {
	 console.log(stub);
	 console.log(typeof stub);
	 },
	 error: function(xhr, status, error) {
	 console.error("Error fetching data: ", error);
	 }
	 });
	 }
	 */
</script>
<div class="col-xl-6 col-lg-6">
	<div class="card shadow mb-4">
		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">

			<h6 class="m-0 font-weight-bold text-primary">급여대장 조회</h6>
			<button type="button" id="newBtn2"
				class="btn btn-primary btn-icon-split">
				<span class="icon text-white-50"><i class="fas fa-check"></i></span>
				<span class="text">신규</span>
			</button>
		</div>


		<div class="card-body">
			<form id="frm03">
				<div class="row justify-content-end">
					<div class="col-3">
						<select name="deptno" class="form-control form-control-user">
							<option value="0">부서선택</option>
							<c:forEach var="dept" items="${dlist}">
								<option value="${dept.deptno}">${dept.dname}[${dept.deptno}]</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-3">
						<select id="year" class="form-control" name="year">
							<option value="0">년도</option>
							<c:forEach var="i" begin="2014" end="2024">
								<option value="${i}">${i}년</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-3">
						<select id="month" class="form-control" name="month">
							<option value="0">월</option>
							<c:forEach var="i" begin="1" end="12">
								<option value="${i}">${i}월</option>
							</c:forEach>
						</select>

					</div>
					<div class="col-3">
						<button class="btn btn-info" type="button" id="schBtnFrm">검색</button>
					</div>
				</div>
			</form>
			<br>
			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable2">
					<thead>
						<tr>

							<th>신고귀속</th>
							<th>급여구분</th>
							<th>부서번호</th>
							<th>대장명칭</th>
							<th>인원수</th>


						</tr>
					</thead>
					<tbody id="tbody">

					</tbody>
				</table>

			</div>
		</div>
	</div>
</div>
<!-- 모달창 -->

<div class="modal fade" id="registerModal2" tabindex="-1" role="dialog"
	aria-labelledby="registerModalLabel2" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="registerModalLabel">직원별 급여정보 등록</h5>
				<button type="button" id="closeBtn" class="close"
					data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="frm02" method="POST" class="text-left">
					<div class="form-group row">

						<div class="col-md-6">

							<label for="start_date">신고귀속</label> <input type="date"
								class="form-control" id="payment_date" name="payment_date"
								required />
						</div>

						<div class="col-md-6">
							<label for="start_date">대장명칭</label> <input type="text"
								class="form-control" id="stub_name" name="stub_name" required>
						</div>

					</div>
					<div class="table-responsive">
						<table class="table table-bordered" id=dataTable>
							<thead>
								<tr>
									<th></th>
									<th></th>
									<th></th>
									
								
								</tr>
							</thead>
						
						</table>

				</form>


					</div>
			</div>
			
		</div>
		
		<hr style="border-color: #46bcf2;">
		<div class="modal-footer d-flex justify-content-between">
			<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			<button type="button" id="regBtn" form="registerForm"
				class="btn btn-primary">등록</button>
			<c:if test="${emem.auth eq '인사관리자' || emem.auth eq '총괄관리자' }">
				<button type="button" id="del2Btn" form="registerForm"
					class="btn btn-danger">삭제</button>
				<button type="button" id="upt2Btn" form="registerForm"
					class="btn btn-info">수정</button>
			</c:if>
		</div>
	</div>

