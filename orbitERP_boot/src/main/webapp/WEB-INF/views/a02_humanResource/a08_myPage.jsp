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
<%--
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
 --%>

<style>
#chatArea {
	height: 300px;
}

#text {
	width: 70%;
	margin-left: auto;
	margin-right: auto;
}

.input-group-text {
	width: 100%;
	background-color: linen;
	color: black;
	font-weight: bolder;
}

.input-group-prepend {
	width: 20%;
}

.input_value {
	display: flex;
	align-items: center;
	width: 35%;
}
</style>
<!-- jQuery -->
<script src="${path}/a00_com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var empno = "${emem.empno}"
		// 현재 URL에서 empno 값 가져오기
		var urlParams = new URLSearchParams(window.location.search);
		var empnoFromURL = urlParams.get('empno');

		if (empnoFromURL !== empno) {
			alert("올바르지 않은 접근입니다.")
			window.location.href = "${path}/main"
		}

		// 메인으로 이동
		$("#goListBtn").click(function() {
			location.href = "${path}/main"
		})

		$("#uptBtn").click(function() {
			if ($("#pwd").val() !== $("#pwdconfirm").val()) {
				alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.")
				$("input[name='pwd']").focus(); // input 요소에 직접 접근하여 focus() 메서드를 호출합니다.
				return;
			} else {
				$("form").attr("action", "${path}/empUpdate");
				$("#frm01").submit();
			}
		})

	

		// 사진 미리보기
		$("#profileInput").on("change", function() {
			var input = this;
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$("#profileImage").attr("src", e.target.result);
				};
				reader.readAsDataURL(input.files[0]);
			}
		});

	});
</script>

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
					<h1 class="h3 mb-4 text-gray-800">나의 정보 관리</h1>
					<br> <br>
					<div class="d-flex justify-content-left">
						<!--  <img id="profile" src="${profile}" width="100px" height="100px" alt="사진" /> -->
					</div>
					<form id="frm01" method="post" enctype="multipart/form-data">

						<br>
						<div class="row justify-content-left align-items-left">
							<div class="col-sm-8">

								<c:if test="${not empty fname}">
									<!-- fname이 null이 아닐 때 처리할 내용 -->
									<img id="profileImage" src="${path}/z02_empProfile/${fname}"
										width="103px" height="132px">
								</c:if>
								<c:if test="${empty fname}">
									<!-- 저장된 사진이 없을 때 -->
									<img id="profileImage" src="${path}/z02_empProfile/기본프사.png"
										width="103px" height="132px">
								</c:if>
								<input id="profileInput" class="form-control form-control-user"
									name="profile" type="file" accept="image/*">
							</div>
							<br>
						</div>

						<br> <br>
						<div class="row justify-content-left align-items-left">
							<label for="sno" class="col-sm-1 col-form-label">사원번호</label>
							<div class="col-sm-3">
								<input type="text" readonly
									class="form-control form-control-user" name="empno"
									value="${employee.empno}">
							</div>
							<label for="ename" class="col-sm-1 col-form-label">사원명</label>
							<div class="col-sm-3">
								<input type="text" class="form-control form-control-user"
									readonly name="ename" value="${employee.ename}">
							</div>

						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="sno" class="col-sm-1 col-form-label">직급</label>
							<div class="col-sm-3">

								<input readonly class="form-control form-control-user"
									value="${employee.job}" name="job">

							</div>

						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="ssnum" class="col-sm-1 col-form-label">주민번호</label>
							<div class="col-sm-3">
								<input class="form-control form-control-user" name="ssnum"
									readonly value="${employee.ssnum}" readonly />
							</div>
							<label for="final_degree" class="col-sm-1 col-form-label">부서번호</label>
							<div class="col-sm-3">
								<input class="form-control form-control-user" name="deptno"
									readonly value="${employee.deptno}" readonly />

							</div>
						</div>
						<br>

						<div class="row justify-content-left align-items-left">
							<label for="pwd" class="col-sm-1 col-form-label">비밀번호</label>
							<div class="col-sm-3">
								<input type="password" class="form-control form-control-user"
									id="pwd" name="pwd">
							</div>
							<label for="pwd" class="col-sm-1 col-form-label">비밀번호 확인</label>
							<div class="col-sm-3">
								<input type="password" id="pwdconfirm"
									class="form-control form-control-user">
							</div>


						</div>
						<br>
						<div class="row justify-content-left align-items-left">

							<c:if test="${employee.deptno == 50}">
								<label for="subject" class="col-sm-1 col-form-label">담당과목</label>
								<div class="col-sm-3">
									<input type="text" class="form-control form-control-user"
										readonly name="subject"
										value="${empty employee.subject ? '없음' : employee.subject}">
								</div>
							</c:if>

						</div>


						<div class="row justify-content-left align-items-left">
							<label for="phone" class="col-sm-1 col-form-label">H.P</label>
							<div class="col-sm-3">
								<input type="text" class="form-control form-control-user"
									name="phone" value="${employee.phone}"
									placeholder="하이픈 포함해서 입력(010-xxxx-xxx)"
									pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required>
							</div>
							<label for="hiredate" class="col-sm-1 col-form-label">입사일</label>
							<div class="col-sm-3">
								<input class="form-control form-
								control-user"
									name="hiredate" value="${employee.hiredate}" readonly>
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="address" class="col-sm-1 col-form-label">주소</label>
							<div class="col-sm-7">
								<input type="text" class="form-control form-control-user"
									name="address" value="${employee.address}">
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="account" class="col-sm-1 col-form-label">계좌번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control form-control-user"
									name="account" value="${employee.account}">
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="email" class="col-sm-1 col-form-label">이메일</label>
							<div class="col-sm-7">
								<input type="email" class="form-control form-control-user"
									name="email" value="${employee.email}"
									pattern="^[\w._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"
									placeholder="xxx@gmail.com 형식으로 입력" required>
							</div>
						</div>
						<br> <br>
						<div class="row justify-content-left">
							<div class="col-auto">
								<input type="button" class="btn btn-info" value="메인화면"
									id="goListBtn" /> <input type="button" class="btn btn-success"
									id="uptBtn" value="수정">
							</div>
						</div>
					</form>

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
	<!-- End of Page Wrapper -->

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