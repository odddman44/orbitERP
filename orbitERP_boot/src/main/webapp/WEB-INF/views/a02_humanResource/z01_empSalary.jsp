<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<style>
	#dataTable {
    text-align: center; /* 가운데 정렬 */
}
</style>
<script>
	$(document)
			.ready(
					function() {

					

						search();
						// 콤마 추가

						// 선택 요소에 월 옵션을 추가합니다.
						for (var i = 1; i <= 12; i++) {
							// 옵션 요소를 생성하여 선택 요소에 추가합니다.
							$('#month').append($('<option>', {
								value : i,
								text : i + '월'
							}));
						}

						$("#schBtn").click(function() {
							console.log("전달되는 데이터:" + $("form").serialize());
							search();
							// 검색하고 나서는 다시 payment_dataStr 비워두기(전체 검색을 위하여)
							$("[name=payment_dateStr]").val("");
						});

						// 모달창 띄우기
						$("#newBtn").click(function() {
							openNewVoucherModal();
							
							// payment_dateStr, empno, deptno 수정 가능 처리
							$("#frm02 [name='payment_dateStr']").prop('disabled', false);
							$("#frm02 [name='empno']").prop('disabled', false);
							$("#frm02 [name='deptno']").prop('disabled', false);
							$("#uptBtn").hide()
							$("#delBtn").hide()
						});

						// 모달창에서 부서별로 사원번호 select값 나오게 하는 함수
						$("#frm02 [name=deptno]")
								.change(
										function() {
											var deptno = $(this).val();
											console.log("부서번호: " + deptno);
											$
													.ajax({
														url : "/elist?deptno="
																+ deptno,
														type : "GET",
														data : {
															deptno : deptno
														},
														success : function(data) {
															console
																	.log(typeof (data))
															console.log(data)
															// 성공적으로 데이터를 받았을 때 실행할 로직

															// 받아온 데이터 중에서 사원 번호를 select 요소에 할당하는 로직을 작성
															var empSelect = $("#empSelect"); // 사원을 선택할 select 요소 선택
															empSelect.empty(); // 기존 옵션을 모두 삭제

															$
																	.each(
																			data,
																			function(
																					index,
																					employee) {
																				// 받아온 데이터를 순회하며 옵션을 생성하여 select 요소에 추가
																				empSelect
																						.append($(
																								"<option>",
																								{
																									value : employee.empno, // 옵션의 값은 사원 번호
																									text : employee.empno
																											+ ' ['
																											+ employee.ename
																											+ ']' // 옵션의 텍스트는 사원 이름
																								}));
																			});
														},
														error : function(xhr,
																status, error) {
															console
																	.error(
																			"Error fetching employee list: ",
																			error);
														}
													});
										});

						$('#base_salary').on('input', function() {
							var input = $(this).val().replace(/,/g, ''); // 먼저 콤마를 제거
							if (!isNaN(input)) { // 입력 값이 숫자인 경우
								$(this).val(addCommas(input)); // 콤마 추가
							}
						});
						$('#allowance').on('input', function() {
							var input = $(this).val().replace(/,/g, ''); // 먼저 콤마를 제거
							if (!isNaN(input)) { // 입력 값이 숫자인 경우
								$(this).val(addCommas(input)); // 콤마 추가
							}
						});
						$('#deduction').on('input', function() {
							var input = $(this).val().replace(/,/g, ''); // 먼저 콤마를 제거
							if (!isNaN(input)) { // 입력 값이 숫자인 경우
								$(this).val(addCommas(input)); // 콤마 추가
							}
						});

						// 실수령액 자동으로 넣기
						// base_salary, allowance, deduction 값이 변경될 때마다 net_pay를 업데이트합니다.
						$('#base_salary, #allowance, #deduction')
								.on(
										'input',
										function() {
											var baseSalary = $('#base_salary')
													.val();
											var allowance = $('#allowance')
													.val();
											var deduction = $('#deduction')
													.val();

											if (baseSalary && allowance
													&& deduction) {
												baseSalary = parseInt(baseSalary
														.replace(/,/g, '')) || 0;
												allowance = parseInt(allowance
														.replace(/,/g, '')) || 0;
												deduction = parseInt(deduction
														.replace(/,/g, '')) || 0;

												var netPay = baseSalary
														+ allowance - deduction;
												// 콤마 추가
												var formattedNetPay = addCommas(netPay);

												// net_pay 필드에 값을 설정합니다.
												$('#net_pay').val(
														formattedNetPay);
											}else if((allowance == 0 || allowance == '') && (deduction == 0 || deduction == '')){
												$('#net_pay').val(baseSalary)
											}

										});
						$("#closeBtn").click(function(){
							$("#frm02")[0].reset();
						})

						$("#regFrmBtn")
								.click(
										function() {
											
											
											
											
											 
											var payment_date = new Date($(
													"#payment_date").val());
											var start_date = new Date($(
													"#start_date").val());
											var end_date = new Date($(
													"end_date").val());

											if (payment_date < start_date) {
												alert("급여지급일은 근무시작일보다 이후 날짜여야 합니다.");
												return false; // Prevent form submission
											}

											if (payment_date < end_date) {
												alert("급여지급일은 근무종료일보다 이후 날짜여야 합니다.");
												return false; // Prevent form submission
											}

											if (end_date < start_date) {
												alert("급여종료일은 근무시작일보다 이후 날짜여야 합니다.");
												return false; // Prevent form submission
											}

											if ($("#payment_date").val() == "") {
												alert("급여 지급일을 입력하십시오.")
												return false;
											}
											if ($("#start_date").val() == "") {
												alert("근무 시작일자 입력하십시오.")
												return false;
											}

											if ($("end_date").val() == "") {
												alert("근무 종료일자를 입력하십시오.")
												return false;
											}

											if ($("#empno").val() == "") {
												alert("사원번호을 입력하십시오.")
												return false;
											}

											if ($("#deptno").val() == ""
													|| $("#deptno").val() == 0) {
												alert("부서번호를 입력하십시오..")
												return false;
											}
											if ($("#base_salary").val() == ""
													|| $("#base_salary").val() == 0) {
												alert("기본급을 입력하십시오.")
												return false;
											} else {
												if (confirm("급여 정보를 등록하시겠습니까?")) {
													var dateString = $("#payment_date").val(); // yyyy-mm-dd 형식의 날짜 문자열
													var dateParts = dateString.split("-"); // 날짜를 구성하는 부분을 분리

													// Date 객체를 생성하여 날짜 설정
													var dateObject = new Date(dateParts[0], dateParts[1] - 1, dateParts[2]);

													// 일자를 뺀 값 구하기
													var yearMonth = dateObject.getFullYear() + "-" + ("0" + (dateObject.getMonth() + 1)).slice(-2);
													// 상여, 공제 기본 값 설정
													if($("#allowance").val()==null || $("#allowance").val()==""){
														$("#allowance").val("0")
													}
													if($("#deduction").val()==null || $("#deduction").val()==""){
														$("#deduction").val("0")
													}
													
													removeComma(); // 콤마 제거
													$.ajax({
													    type: "POST",
													    url: "/salDuplicationCheck",
													    data: {
													        empno: $("#frm02 [name=empno]").val(),
													        payment_dateStr: yearMonth
													    },
													    dataType: "json",
													    success: function(data) {
													        console.log("등록 결과: " + data);
													        if (data <= 0) {
													            insertSalary();
													        } else {
													            alert("해당 달의 입력하신 사원의 급여 정보가 이미 존재합니다.");
													            return;
													        }
													    },
													    error: function(err) {
													        console.log(err);
													    }
													});
													
												
												}
											}

										})
										$("#uptBtn").click(function(){
											// alert($("#frm02").serialize());
											
										
											 
											if(confirm("급여 정보를 수정하시겠습니까?")){
												removeComma(); // 콤마 제거하기
												// 상여, 공제가 비어있는 경우 기본값 설정
												
												if($("#allowance").val()==null || $("#allowance").val()==""){
													$("#allowance").val("0")
												}
												if($("#deduction").val()==null || $("#deduction").val()==""){
													$("#deduction").val("0")
												}
												
												// 비활성화 풀기
													 $("#frm02 [name='payment_dateStr']").prop('disabled', false);
													 $("#frm02 select[name='empno']").prop('disabled', false);
													 $("#frm02 select[name='deptno']").prop('disabled', false);
												
												$.ajax({
													url:"/updateSalary",
													dataType:"json",
													data:$("#frm02").serialize(),
													type:"POST",
													success:function(data){
														if(data>0){
															alert("급여 정보 수정 성공!")
															$("#frm02")[0].reset();
															window.location.reload();
															$("#closeBtn").click()
														
														}else{
															alert("급여 정보 수정 실패")
														}
													},
													error:function(err){
														console.log("급여 수정 중 에러 발생: "+err)
													}
												})
											}
											
										})
										
										$("#delBtn").click(function(){
											var empno = $("[name=empno]").val()
											console.log(empno)
											var payment_dateStr = $("[name=payment_dateStr]").val();
											console.log(payment_dateStr)
											if(confirm("급여 정보를 삭제하시겠습니까?")){
												// 비활성화 풀기
												 $("#frm02 [name='payment_dateStr']").prop('disabled', false);
												 $("#frm02 select[name='empno']").prop('disabled', false);
												 $("#frm02 select[name='deptno']").prop('disabled', false);
												$.ajax({
													url:"/deleteSalary",
													dataType:"json",
													data:{
														empno:empno,
														payment_dateStr:payment_dateStr
													},
													type:"POST",
													success:function(data){
														if(data>0){
															alert("급여 정보 삭제 성공")
															$("#frm02")[0].reset();
															window.location.reload();
															$("#closeBtn").click()
														
														}else{
															alert("급여 정보 삭제 실패")
														}
													},
													error:function(err){
														console.log("급여 삭제 중 에러 발생: "+err)
													}
												})
											}
										})
										
										
										
										

					})

	// 급여 리스트 불러오는 함수
	function search() {
	$('#dataTable').DataTable().destroy(); // 테이블 초기화
	
    $('#dataTable').DataTable({
        "paging": true,
        "searching": false,
        "ordering": true,
        "info": true,
        "pagingType": "full_numbers",
        "pageLength": 10,
        "ajax": {
            "url": "/salaryList",
            "type": "POST",
            "data": function() {
                return $("#frm01").serialize(); // 폼 데이터를 직렬화하여 전송
            },
            "dataType": "json",
            "dataSrc": "" // 데이터 소스로 사용할 JSON 배열의 위치를 지정
        },
        "columns": [
            { 
                "data": "payment_date",
                "render": function(data, type, row) {
                    // 데이터가 표시될 때 날짜 형식으로 변환하여 반환
                    if (type === 'display' || type === 'filter') {
                        var date = new Date(data);
                        return date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2);
                    }
                    return data;
                }   
            }, // 첫 번째 열: payment_date
            { "data": "empno" },         // 두 번째 열: empno
            {"data":"ename"},
            { 
                "data": "base_salary",
                "render": $.fn.dataTable.render.number(',', '.', 0),
                "className": "text-right"
            },   // 세 번째 열: base_salary
            { 
                "data": "allowance",
                "render": $.fn.dataTable.render.number(',', '.', 0),
                "className": "text-right"
            },     // 네 번째 열: allowance
            { 
                "data": "deduction",
                "render": $.fn.dataTable.render.number(',', '.', 0),
                "className": "text-right"
            },     
            { 
                "data": "net_pay",
                "render": $.fn.dataTable.render.number(',', '.', 0),
                "className": "text-right"
            },       // 여섯 번째 열: net_pay
            { 
                "data": "dname" 
            }          // 일곱 번째 열: dname
        ],
        "createdRow": function(row, data, index) {
            // 행 클릭 이벤트 처리
            $(row).on('click', function() {
            	var paymentDate = new Date(data.payment_date);
                var formattedDate = paymentDate.getFullYear() + "-" + ("0" + (paymentDate.getMonth() + 1)).slice(-2);
                goSalaryDetail(data.empno, formattedDate);
            });
        }
    });
}

	// 신규 모달창 열기 함수
	function openNewVoucherModal() {
		$("#frm02")[0].reset();
		$("#registerModalLabel").text("급여 정보 등록")
		$("#regFrmBtn").show()
		$('#registerModal').modal('show');
	}

	// 콤마 제거하기
	function removeComma() {
		// 콤마가 포함된 입력 필드의 ID를 가져옵니다.
		var inputField1 = $('#base_salary');
		var inputField2 = $('#allowance');
		var inputField3 = $('#deduction');
		var valueWithCommas1 = inputField1.val();
		var valueWithCommas2 = inputField2.val();
		var valueWithCommas3 = inputField3.val();
		// 콤마를 제거합니다.
		var valueWithoutCommas1 = valueWithCommas1.replace(/,/g, '');
		var valueWithoutCommas2 = valueWithCommas2.replace(/,/g, '');
		var valueWithoutCommas3 = valueWithCommas3.replace(/,/g, '');
		// 콤마가 제거된 값을 다시 입력 필드에 설정합니다.
		inputField1.val(valueWithoutCommas1);
		inputField2.val(valueWithoutCommas2);
		inputField3.val(valueWithoutCommas3);
	}

	function addCommas(nStr) {
		nStr += '';
		var x = nStr.split('.');
		var x1 = x[0];
		var x2 = x.length > 1 ? '.' + x[1] : '';
		var rgx = /(\d+)(\d{3})/;
		while (rgx.test(x1)) {
			x1 = x1.replace(rgx, '$1' + ',' + '$2');
		}
		return x1 + x2;
	}

	function goSalaryDetail(empno, payment_dateStr) {
		console.log("전달받은 사원번호:" + empno)
		console.log("전달받은 지급일:" + payment_dateStr)
		$("#frm02")[0].reset();
		// 상세 정보 가져오기
		$.ajax({
			type : "POST",
			url : "/salaryDetail",
			data : {
				empno : empno,
				payment_dateStr : payment_dateStr
			},
			dataType : "json",
			success : function(salary) {
				base_salary = addCommas(salary.base_salary)
				allowance = addCommas(salary.allowance)
				deduction = addCommas(salary.deduction)
				net_pay = addCommas(salary.net_pay)

		
				var payment_date = new Date(salary.payment_date)
				console.log("급여 지급일"+salary.payment_date)
				payment_date.setUTCHours(payment_date.getUTCHours() + 9);
				var start_date = new Date(salary.start_date)
				console.log("근무 시작일"+salary.start_date)
				start_date.setUTCHours(start_date.getUTCHours() + 9);
				var end_date = new Date(salary.end_date)
				console.log("근무 종료일"+salary.end_date)
				end_date.setUTCHours(end_date.getUTCHours() + 9);
				
				var payment_dateStr = payment_date.toISOString().split('T')[0];
				var start_dateStr = start_date.toISOString().split('T')[0];
				var end_dateStr = end_date.toISOString().split('T')[0];

			

				

				$("#defaultEmpno").val(salary.empno)
				$("#defaultEmpno").text(salary.empno)
				$("#frm02 [name=deptno]").val(salary.deptno)
				$("#frm02 [name=base_salary]").val(base_salary)
				$("#frm02 [name=allowance]").val(allowance)
				$("#frm02 [name=deduction]").val(deduction)
				$("#net_pay").val(net_pay)
				$("#frm02 [name=payment_dateStr]").val(payment_dateStr)
				$("#frm02 [name=start_dateStr]").val(start_dateStr)
				$("#frm02 [name=end_dateStr]").val(end_dateStr)
				

			},
			error : function(err) {
				console.log(err);
				// Handle form submission error here
			}
		})
		$('#registerModal').modal('show');
		$("#registerModalLabel").text("급여 정보 상세")
		$("#uptBtn").show();
		$("#delBtn").show()
		$("#regFrmBtn").hide();
		
		// payment_dateStr, empno, deptno 수정 불가 처리
		 $("#frm02 [name='payment_dateStr']").prop('disabled', true);
		 $("#frm02 select[name='empno']").prop('disabled', true);
		 $("#frm02 select[name='deptno']").prop('disabled', true);
		 

		
		 
	
	}
	
	
	// 등록 함수
	function insertSalary(){
		$.ajax({
			type : "POST",
			url : "/insertSalary",
			data : $("#frm02").serialize(),
			dataType : "json",
			success : function(data) {
				console.log("등록 결과: "+ data)
				if (data > 0) {
					alert("급여 정보 등록 성공")
					window.location.reload();
				} else {
					alert("급여 정보 등록 실패")
				}
			},
			error : function(err) {
				console.log(err);
			}
		})
	}
</script>
<style>
table {
	text-align: center
}
</style>
<div class="col-xl-6 col-lg-6">
	<div class="card shadow mb-4">
		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">

			<h6 class="m-0 font-weight-bold text-primary">직원별 급여 정보</h6>
			<c:if test="${emem.auth eq '인사관리자' || emem.auth eq '총괄관리자'}">
			<button type="button" id="newBtn"
				class="btn btn-primary btn-icon-split">
				<span class="icon text-white-50"><i class="fas fa-check"></i></span>
				<span class="text">신규</span>
			</button>
		</c:if>
		</div>
		


		<div class="card-body">
			<form method="post" id="frm01">

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
						<span> <select id="year" name="year" class="form-control">
								<option value="">년도</option>
								<c:forEach var="j" begin="2014" end="2024">
									<option value="${j}">${j}년</option>
								</c:forEach>
						</select>
					</div>
					<div class="col-3">
						<select id="month" name="month" class="form-control">
							<option value="">월</option>
							<c:forEach var="i" begin="1" end="12">
								<option value="${i}">${i}월</option>
							</c:forEach>
						</select>

					</div>
					<div class="col-3">
						<button class="btn btn-info" type="button" id="schBtn">검색</button>
					</div>

				</div>

			</form>
			<br>

			<div class="table-responsive">
				<table class="table table-bordered" id=dataTable>
					<thead>
						<tr>

							<th>지급일</th>
							<th>사원번호</th>
							<th>사원명</th>
							<th>기본급</th>
							<th>수당</th>
							<th>공제</th>
							<th>실수령액</th>
							<th>부서명</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>




			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog"
	aria-labelledby="registerModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="registerModalLabel">직원별 급여정보 등록</h5>
				<button type="button" id="closeBtn" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="frm02" method="POST" class="text-left">
					<div class="form-group row">

						<div class="col-md-4">

							<label for="start_date">급여 지급일</label> 
							<input type="date" class="form-control" id="payment_date" name="payment_dateStr" required />
							
						</div>

						<div class="col-md-4">
							<label for="start_date">근무 시작일자</label> <input type="date"
								class="form-control" id="start_date" name="start_dateStr"
								required>
						</div>
						<div class="col-md-4">

							<label for="end_cname">근무 종료일자</label> <input type="date"
								class="form-control" id="end_date" name="end_dateStr" required>

						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-6">

							<label for="empno">사원번호</label> <select id="empSelect"
								name="empno" class="form-control">
								<option value="" id="defaultEmpno">사원번호 선택</option>
							</select>
							
						</div>
						<div class="col-md-6">

							<label for="voucherType">부서번호</label> <select id="deptno"
								name="deptno" class="form-control">
								<option value="0">부서선택</option>
								<c:forEach var="dept" items="${dlist}">
									<option value="${dept.deptno}">${dept.dname}[${dept.deptno}]</option>
								</c:forEach>
							</select>
							
						</div>
					</div>

					<hr>
					<div class="table-responsive">
						<table class="table table-hover table-striped table-bordered"
							style="width: 100%;">
							<thead>
								<tr class="table-primary text-center">
									<th>기본급</th>
									<th>수당</th>
									<th>공제</th>
									<th>실수령액</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input class="form-control text-right" type="text"
										id="base_salary" name="base_salary"></td>
									<td><input class="form-control text-right" type="text" id="allowance"
										name="allowance"></td>
									<td><input class="form-control text-right" type="text"
										name="deduction" id="deduction"></td>
									<td><input class="form-control text-right" type="text" readonly id="net_pay"></td>
								</tr>
							</tbody>
						</table>
					</div>



				</form>
			</div>
			<hr style="border-color: #46bcf2;">
			<div class="modal-footer d-flex justify-content-between">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" id="regFrmBtn" form="registerForm"
					class="btn btn-primary">등록</button>
			<c:if test="${emem.auth eq '인사관리자' || emem.auth eq '총괄관리자' }">
				<button type="button" id="delBtn" form="registerForm"
					class="btn btn-danger">삭제</button>
				<button type="button" id="uptBtn" form="registerForm"
					class="btn btn-info">수정</button>
			</c:if>
			</div>
		</div>
	</div>
</div>

