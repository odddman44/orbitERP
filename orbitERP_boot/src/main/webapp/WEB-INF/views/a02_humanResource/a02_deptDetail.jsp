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
<title>Good day!!</title>
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




<script src="${path}/a00_com/jquery.min.js"></script>



<script type="text/javascript">
	$(document).ready(function() {

		// 부서리스트로 화면으로 이동
		// 부서리스트로 화면으로 이동
		$("#goListBtn").click(function() {
			if (confirm("부서리스트 화면으로 이동하시겠습니까??")) {
				location.href = "deptList";
			}
		});
		$("#delBtn").click(function() {
			if (confirm("부서 정보를 삭제하시겠습니까?")) {
				deleteDept();

			}
		})
		$("#uptBtn").click(function() {
			updateDept()
		})

	});

	function deleteDept() {
		var deptno = $("[name=deptno]").val()
		$.ajax({
			url : "${path}/deleteDept",
			data : {
				deptno : deptno
			},
			dataType : "json",
			success : function(data) {
				if (data.isDel > 0) {
					alert("부서정보 삭제 성공!")
					location.href = "${path}/deptList"
				}
			},
			error : function(err) {
				console.log(err);
			}
		})

	}
	function updateDept() {
		$.ajax({
			url : "${path}/updateDept",
			type : "POST",
			data : $("#frm01").serialize(),
			dataType : "json",
			success : function(data) {
				if (data.isUpt > 0) {
					alert("부서정보 수정 성공!")
					location.href = "${path}/deptDetail?deptno="
							+ $("[name=deptno]").val()
				}
			}
		})
	}
</script>

<style>
label {
	display: block;
	text-align: center;
	font-weight: bold;
}

button {
	float: right;
}
</style>







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

				<!-- Topbar    -->
				<%@ include file="/WEB-INF/views/a00_module/a03_topBar.jsp"%>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<h1 class="h3 mb-4 text-gray-800">부서 상세 정보</h1>
					<br> <br>
					<form id="frm01" method="post">
						<div class="row">
							<div class="col-md-1">
								<label>부서번호</label>
							</div>
							<div class="col-md-11">
								<input class="form-control form-control-user" name="deptno"
									value="${dept.deptno}" readonly />
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-md-1">
								<label>부서명</label>
							</div>
							<div class="col-md-11">
								<input class="form-control form-control-user" required
									oninvalid="this.setCustomValidity('부서번호는 반드시 입력해야 합니다.')"
									oninput="this.setCustomValid('')" value="${dept.dname}"
									name="dname" />
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-md-1">
								<label>부서코드</label>
							</div>
							<div class="col-md-11">
								<input class="form-control form-control-user" required
									value="${dept.dcode}" name="dcode" />
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-md-1">
								<label>기타정보</label>
							</div>
							<div class="col-md-11">
								<textarea class="form-control form-control-user" name="etc">${dept.etc}</textarea>
							</div>
						</div>
						<br> <br>
						<div class="row justify-content-end">
						<c:if test="${emem.auth eq '인사관리자' || emem.auth eq '총괄관리자'}">
							<div class="col-auto">
								<input type="button" class="btn btn-primary" value="수정"
									id="uptBtn" />
							</div>
							<div class="col-auto">
								<input type="button" class="btn btn-primary" value="삭제"
									id="delBtn" />
							</div>
						</c:if>
							<div class="col-auto">
								<input type="button" class="btn btn-info" value="부서조회화면"
									id="goListBtn" />
							</div>
						</div>
					</form>

				</div>
				<!-- /.container-fluid -->

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