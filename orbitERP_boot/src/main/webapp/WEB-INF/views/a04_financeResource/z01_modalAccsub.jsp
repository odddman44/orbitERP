<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<script type="text/javascript">
	$(document).ready(function() {
		/* 계정과목 선택 모달창*/
		// 모달창이 열릴 때마다 DataTables 초기화
		$('#accountModal').on('shown.bs.modal', function() {
			console.log("계정과목 모달창 열림.")
	        if (!$.fn.DataTable.isDataTable('#dataTable2')) {
		        $('#dataTable2').DataTable({
		            "paging": true,
		            "searching": true,
		            "ordering": true,
		            "info": true,
		            "pagingType": "full_numbers",
		            "pageLength": 10
		        });
		    }
	    });
		// 계정 코드 입력란에 클릭 이벤트 핸들러 추가
		$("#modalTable").on('click', 'input[name="acc_code"]', function() {
		    window.currentAccInput = $(this); // 현재 클릭된 입력란을 저장
		    $('#accountModal').modal('show');  // 계정과목 조회 모달창 표시
		});
	});
	function choiceAcc(acc_code, acc_name) {
		// 선택된 계정 코드와 이름을 모달 테이블의 입력란에 설정
	    if (window.currentAccInput && window.currentAccInput.length) {
	        window.currentAccInput.val(acc_code);
	        window.currentAccInput.closest('tr').find('.acc-name').val(acc_name);
	    }
	    $('#accountModal').modal('hide'); // 모달창 닫기
	}
</script>
<div class="modal fade" id="accountModal" tabindex="-1" role="dialog" aria-labelledby="accountModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="accountModalLabel">계정과목 조회</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div id="card-body accountList">
					<table class="table table-bordered" id="dataTable2">
						<thead>
							<tr>
								<th>선택</th>
								<th>계정코드</th>
								<th>계정과목명</th>
								<th>대차구분</th>
								<th>계정종류</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="acc" items="${aList}">
								<tr>
									<td><button type="button" 
									class="btn btn-primary" 
									onclick="choiceAcc('${acc.acc_code}', '${acc.acc_name}')">선택</button></td>
									<td>${acc.acc_code}</td>
									<td>${acc.acc_name}</td>
									<td>${acc.debit_credit == 'D' ? '차변' : '대변'}</td>
									<td>${acc.acc_type}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 계정과목 모달창 종료 -->