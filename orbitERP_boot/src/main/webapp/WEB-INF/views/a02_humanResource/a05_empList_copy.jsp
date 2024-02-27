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
<%--
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
 --%>
<!-- jQuery -->
<script src="${path}/a00_com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {

				// 숫자에 콤마를 추가하는 함수
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

				var msg = "${msg}"
				if (msg != "") {
					alert(msg)
					location.href = "${path}/empList"
				}

				$($("#frm02 [name=deptno]")).change(function() {
					var selectValue = $(this).val();
					console.log("선택된 부서: " + selectValue);
					if (selectValue == "50") {
						$("#msg").css("color", "red");
						$("#subject").prop("readonly", false); // "subject" 입력 필드를 읽기/쓰기 가능하도록 변경
						$("#job").val("강사"); // "job" 입력 필드의 값을 "강사"로 설정
						$("#job").prop("readonly", true); // 직급 강사로 하고 readonly로 변경
						$("#job option[value='강사']").prop("disabled", false); // 강사 옵션 활성화
					} else {
						$("#msg").css("color", "black");
						$("#subject").prop("readonly", true); // 교육팀 아니면 과목명 입력 불가
						$("#subject").val('');
						$("#job").prop("readonly", false); // 다른 부서면 직급 수정 가능
						$("#job option[value='강사']").prop("disabled", true); // 강사 옵션 비활성화
					}
				});

				$("#frm02 [name=empno]").keyup(function() {
					if (event.keyCode == 13) {
						ckEmpno()
					}
				})

				/*$('#frm02').submit(function(event) {
					// 콤마가 포함된 입력 필드의 ID를 가져옵니다.
					var inputField = $('#sal');
					var valueWithCommas = inputField.val();
					// 콤마를 제거합니다.
					var valueWithoutCommas = valueWithCommas.replace(/,/g, '');
					// 콤마가 제거된 값을 다시 입력 필드에 설정합니다.
					inputField.val(valueWithoutCommas);
				});*/

				$("#regFrmBtn").click(
						function() {

							if ($("#frm02 [name=empno]").val() == "") {
								alert("사원번호를 입력하세요")
								return;
							}
							if ($("#frm02 [name=ckempno]").val() !== "Y") {
								alert("중복된 사원 번호이거나 사원번호 중복체크를 진행하지 않았습니다.")
								return;
							}
							if ($("#frm02 [name=ename]").val() == "") {
								alert("사원명을 입력하세요")
								return;
							}
							if ($("#frm02 [name=deptno]").val() == "0") {
								alert("부서를 입력하세요")
								return;
							}
							if ($("#frm02 [name=deptno]").val() == "50"
									&& $("#frm02 [name=subject]").val() == "") {
								alert("담당 과목을 입력하세요")
								$("#frm02 [name=subject]").focus()
								return;
							}
							if ($("#frm02 [name=deptno]").val() == "50"
									&& $("#frm02 [name=job]").val() != "강사") {
								alert("교육팀의 직급은 강사로 입력해주세요")
								$("#frm02 [name=job]").focus()
								return;
							}
							if ($("#frm02 [name=hiredate]").val() == "") {
								alert("입사일을 입력하십시오.")
								$("#frm02 [name=hiredate]").focus()
								return;
							}
							
							if ($("#jumin1").val() == "") {
								alert("주민번호 앞자리를 입력하세요")
								$("#jumin1").focus()
								return;
							}
							if ($("#jumin2").val() == "") {
								alert("주민번호 뒷자리를 입력하세요")
								$("#jumin2").focus()
								return;
							}

							if ($("#frm02 [name=job]").val() == "") {
								alert("직급을 입력하세요")
								return;
							}
					
						
							if($("#phone1").val()=="" || $("#phone2").val()=="" || $("#phone3").val()==""){
								alert("휴대폰 번호를 입력해주세요.")
								$("#phone1").focus()
								return;
							}
							
							if (confirm("사원 정보를 등록하시겠습니까?")) {
								//alert("게시물을 등록합니다.")
								var jumin1 = $('#jumin1').val();
								var jumin2 = $('#jumin2').val();
								// 2개 합친값
								var ssum = jumin1 + "-" + jumin2;
								$('#frm02 [name=ssnum]').val(ssum)
								console.log("주민번호: " + ssum)

								var phone1 = $('#phone1').val();
								var phone2 = $('#phone2').val();
								var phone3 = $('#phone3').val();
								// 3개 합친값
								var phone = phone1 + "-" + phone2 + "-"
										+ phone3;
								$('#frm02 [name=phone]').val(phone)
								console.log("주민번호: " + ssum)

								$('#frm02').submit();

							}
						})
						
				$('input[name="profile"]').on('change', function() {
					var previewElement = $('#profilePreview')[0];
					var file = this.files[0];

					if (file) {
						var reader = new FileReader();

						reader.onload = function(e) {
							previewElement.src = e.target.result;
						};

						reader.readAsDataURL(file);
					} else {
						// 파일이 선택되지 않았을 때 기본 이미지로 설정
						previewElement.src = "";
					}
				});

				// 연봉 입력창에 자동으로 , 넣기
				$('#sal').on('input', function() {
					var input = $(this).val().replace(/,/g, ''); // 먼저 콤마를 제거
					if (!isNaN(input)) { // 입력 값이 숫자인 경우
						$(this).val(addCommas(input)); // 콤마 추가
					}
				});
				
				// 모달창 닫히면 모달창 내용 초기화
				
				$('#registerModal').on('hidden.bs.modal', function () {
				    // 모달 내용 초기화
				    $("#frm02")[0].reset();
				});

			});
	function goDetail(empno) {
		location.href = "${path}/detailEmp?empno=" + empno
	}

	// 사원 번호 중복 체크
	function ckEmpno() {
		var empno = $("#frm02 [name=empno]").val()
		$.ajax({
			url : "${path}/checkEmpno",
			type : "get",
			data : "empno=" + empno,
			dataType : "json",
			success : function(cnt) {
				//alert(cnt+":"+typeof(cnt))
				if (cnt > 0) {
					$("#empCk").css("color", "red")
					$("[name=ckempno]").val("N")
					$("#empCk").text("이미 존재하는 사원번호입니다.")
					$("[name=empno]").val("").focus()
				} else {
					$("#empCk").css("color", "blue")
					$("[name=ckempno]").val("Y")
					$("#empCk").text("사용가능한 사원번호입니다.")

				}
			}
		})

	}
</script>
<!-- DB테이블 플러그인 추가 -->
<link rel="stylesheet" href="${path}/a00_com/css/vendor.bundle.base.css">
<link rel="stylesheet"
	href="${path}/a00_com/vendor/datatables/dataTables.bootstrap4.css">
<link rel="stylesheet" type="text/css"
	href="${path}/a00_com/js/select.dataTables.min.css">
<!-- Custom fonts for this template-->
<link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<!-- 
    기존 font
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${path}/a00_com/css/sb-admin-2.min.css" rel="stylesheet">
<link href="${path}/a00_com/css/custom-style.css" rel="stylesheet">
</head>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="/WEB-INF/views/a00_module/a02_sliderBar.jsp"%>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">
				<!-- Topbar  -->
				<%@ include file="/WEB-INF/views/a00_module/a03_topBar.jsp"%>
				<!-- End of Topbar -->
				<!-- Begin Page Content (여기서부터 페이지 내용 입력) -->
				<div class="container-fluid">
					<!-- Page Heading -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">☆ 사원 리스트</h1>
					</div>
					<!-- 테이블 -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">사원정보 조회</h6>
							<hr>
							<form id="frm01" class="form" method="post">
								<input type="hidden" name="curPage" value="${sch.curPage}">
								<nav class="navbar navbar-expand-sm navbar-light bg-light">
									<input placeholder="사원명" name="ename" value="${sch.ename}"
										class="form-control mr-sm-2" /> <select name="deptno"
										class="form-control form-control-user">
										<option value="0">부서선택</option>
										<c:forEach var="dept" items="${dlist}">
											<option value="${dept.deptno}">${dept.dname}(${dept.dcode})</option>
										</c:forEach>
									</select>

									<button class="btn btn-info" type="submit">Search</button>

								</nav>
								<div class="input-group mt-3 mb-0">
								<div class="col-12">
									<span class="input-group-text">총 : ${sch.count}건</span>
								</div>
								</div>
								<br>
								<div class="row">
									<div class="text-left col-6">
										<c:if test="${emem.auth eq '인사관리자'}">
											<button type="button" id="regBtn" class="btn btn-success"
												data-toggle="modal" data-target="#registerModal">
												사원정보등록</button>
										</c:if>
									</div>
									<div class="text-right col-6">
										<button class="btn btn-info" type="button" onclick="location.href='mailSend'">이메일 보내기</button>
									</div>
								</div>

								<script type="text/javascript">
									// 선택된 페이지 사이즈를 다음 호출된 페이지에서 출력
									$("[name=pageSize]").val("${sch.pageSize}")
									// 페이지를 변경했을 때, 선택된 페이지를 초기페이지로 설정..
									$("[name=pageSize]").change(function() {
										$("[name=curPage]").val(1)
										$("#frm01").submit()
									})
								</script>
							</form>

						</div>
						<div class="card-body">
							<span>테이블의 행을 더블클릭시, 수정 및 삭제가 가능합니다.</span>
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable">
									<thead>
										<tr>
											<th>사원번호</th>
											<th>사원명</th>
											<th>직급</th>
											<th>부서명</th>

										</tr>
									</thead>
									<tbody>
										<c:forEach var="emp" items="${empList}">
											<tr onclick="goDetail('${emp.empno}')">
												<td>${emp.empno}</td>
												<td>${emp.ename}</td>
												<td>${emp.job}</td>
												<td>${emp.dname}</td>

											</tr>
										</c:forEach>
									</tbody>
								</table>

								<ul class="pagination justify-content-center">
									<li class="page-item"><a class="page-link"
										href="javascript:goPage(${sch.startBlock-1})">Previous</a></li>

									<c:forEach var="pcnt" begin="${sch.startBlock}"
										end="${sch.endBlock}">
										<li class="page-item ${sch.curPage==pcnt?'active':''}"><a
											class="page-link" href="javascript:goPage(${pcnt})">${pcnt}</a></li>
									</c:forEach>

									<li class="page-item"><a class="page-link"
										href="javascript:goPage(${sch.endBlock+1})">Next</a></li>
								</ul>
								<script type="text/javascript">
									function goPage(pcnt) {
										$("[name=curPage]").val(pcnt)
										$("#frm01").submit();
									}
								</script>

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
						<span>Orbit ERP presented by TEAM FOUR</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- 모달 창 -->
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog"
		aria-labelledby="registerModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="registerModalLabel">사원 등록</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="frm02" method="POST" enctype="multipart/form-data"
						action="${path}/empInsert">
						<div class="d-flex justify-content-left">
							<img id="profilePreview" src="" width="103px" height="132px"
								alt="사진없음" />
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<div class="col-sm-12">
								<input type="file" name="profile"
									class="form-control form-control-user" accept="image/*">
							</div>
						</div>

						<br> <br>
						<div class="row justify-content-left align-items-left">
							<input type="hidden" name="ckempno" value="N" /> <label
								for="name" class="col-sm-3 col-form-label">사원번호(*)</label>
							<div class="col-sm-9">

								<input type="text" class="form-control form-control-user"
									name="empno" maxlength="6">
								<p id="empCk">Enter 누르면 사원번호 중복 체크</p>
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="name" class="col-sm-3 col-form-label">부서명(*)</label>
							<div class="col-sm-9">
								<select name="deptno" class="form-control form-control-user">
									<option value="0">부서선택</option>
									<c:forEach var="dept" items="${dlist}">
										<option value="${dept.deptno}">${dept.dname}(${dept.dcode})</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="name" class="col-sm-3 col-form-label">과목</label>
							<div class="col-sm-9">
								<input type="text" class="form-control form-control-user"
									id="subject" name="subject" readonly>
								<p id="msg">부서가 교육팀인 경우 과목 항목을 입력하십시오.</p>
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="name" class="col-sm-3 col-form-label">사원명(*)</label>
							<div class="col-sm-9">
								<input type="text" class="form-control form-control-user"
									name="ename">
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="birth" class="col-sm-3 col-form-label">직급(*)</label>
							<div class="col-sm-9">
								<select class="form-control form-control-user" id="job"
									name="job">
									<option value="">직급 선택</option>
									<option>인턴</option>
									<option>사원</option>
									<option>주임</option>
									<option>대리</option>
									<option>팀장</option>
									<option>이사</option>
									<option>강사</option>
								</select>
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="final_degree" class="col-sm-3 col-form-label">입사일자(*)</label>
							<div class="col-sm-9">
								<input type="date" class="form-control form-control-user"
									name="hiredate" />
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="phone" class="col-sm-3 col-form-label">이메일</label>
							<div class="col-sm-9">
								<input type="text" class="form-control form-control-user"
									name="email">
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="reg_date" class="col-sm-3 col-form-label">H.P(*)</label>

							<input type="hidden" class="form-control form-control-user"
								name="phone" />

							<div class="col-sm-2">
								<input type="text" class="form-control form-control-user"
									id="phone1" pattern="[0-9]*" maxlength="3" />
							</div>
							<div class="col-sm-1">-</div>
							<div class="col-sm-2">
								<input type="text" class="form-control form-control-user"
									id="phone2" pattern="[0-9]*" maxlength="4" />
							</div>
							<div class="col-sm-1">-</div>
							<div class="col-sm-2">
								<input type="text" class="form-control form-control-user"
									id="phone3" name="pwd" pattern="[0-9]*" maxlength="4" />
							</div>

						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="address" class="col-sm-3 col-form-label">주소</label>
							<div class="col-sm-9">
								<input type="text" class="form-control form-control-user"
									name="address">
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="account" class="col-sm-3 col-form-label">계좌번호</label>
							<div class="col-sm-9">
								<input type="text" class="form-control form-control-user"
									name="account">
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="ssnum" class="col-sm-3 col-form-label">주민번호(*)</label>
							<!-- 실제 서버에 전달되는 ssnum -->
							<input type="hidden" class="form-control form-control-user"
								name="ssnum">
							<div class="col-sm-4">
								<input type="text" class="form-control form-control-user"
									autocomplete="on" id="jumin1" placeholder="ex)980530"
									pattern="\d*" maxlength="6">
							</div>
							<div class="col-sm-1">-</div>
							<div class="col-sm-4">

								<input type="password" class="form-control form-control-user"
									autocomplete="on" id="jumin2" placeholder="ex)2000000"
									pattern="\d*" maxlength="7">
							</div>

						</div>
					
					</form>
				</div>
				<hr style="border-color: #46bcf2;">
				<div class="modal-footer">
					<button type="button" id="regFrmBtn" form="registerForm"
						class="btn btn-primary">등록</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>



				</div>
			</div>
					<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Orbit ERP presented by TEAM FOUR</span>
					</div>
				</div>
			</footer>
		</div>
	</div>


	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>
	<!-- Logout Modal-->
	<%@ include file="/WEB-INF/views/a00_module/a08_logout_modal.jsp"%>
	<!-- Bootstrap core JavaScript-->
	<script src="${path}/a00_com/vendor/jquery/jquery.min.js"></script>
	<script
		src="${path}/a00_com/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- Core plugin JavaScript-->
	<script src="${path}/a00_com/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${path}/a00_com/js/sb-admin-2.min.js"></script>

	<!-- 추가 plugins:js -->

	<script src="${path}/a00_com/vendor/datatables/jquery.dataTables.js"></script>
	<script
		src="${path}/a00_com/vendor/datatables/dataTables.bootstrap4.js"></script>
	<script src="${path}/a00_com/js/dataTables.select.min.js"></script>
</body>
</html>