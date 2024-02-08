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
<style>
.jumbotron {
	padding: 2%;
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

#chatArea {
	width: 80%;
	height: 500px;
	overflow-y: auto;
	text-align: left;
}
</style>
<%--
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
 --%>
<!-- jQuery -->
<script src="${path}/a00_com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#goListBtn").click(function() {
			location.href = "empList"
		})
	});
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

					</div>

					<div class="card shadow mb-4">

						<div class="card-header py-3">
							<div class="row">
								<div class="col-6">
									<div class="text-left">
										<h5>
											<span class="badge badge-warning custom-badge">${emem.auth}</span>
											${emem.ename}님 메일 발송 페이지
										</h5>
									</div>
								</div>
								<div class="col-6">
									<div class="text-right">
										<input type="button" class="btn btn-success" value="사원조회 페이지로 이동"
											id="goListBtn" />
									</div>
								</div>
							</div>
						</div>
						<div class="card-body">

							<form method="post">
								<div class="input-group mb-3">
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">
											수신자</span>
									</div>
									<select name="receiver" class="form-control">
										<c:forEach var="emp" items="${empListModel}">
											<option value="${emp.email}">${emp.email}(${emp.ename}/부서번호:${emp.deptno})</option>
										</c:forEach>
									</select>

								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">
											발신자</span>
									</div>
									<!-- 차용 메일서버의 경우 변경되지 않음.. -->
									<input readonly class="form-control"
										value="choem8090@gmail.com" />
								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">
											제목</span>
									</div>
									<input name="title" placeholder="메일 제목 입력" class="form-control"
										value="" />
								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">
											메일내용</span>
									</div>
									<textarea id="chatArea" name="content" class="form-control"
										placeholder="메일 내용 입력"></textarea>
								</div>

								<div style="text-align: right;">
									<input type="submit" class="btn btn-info" value="메일발송"
										id="regBtn" />
								</div>




								<script type="text/javascript">
									var msg = "${msg}"
									if (msg != "") {
										alert(msg);
									}
								</script>
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
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->


	<%@ include
		file="/WEB-INF/views/a04_financeResource/z01_modalAccsub.jsp"%>


	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>
	<!-- Logout Modal-->
	<%@ include file="/WEB-INF/views/a00_module/a08_logout_modal.jsp"%>
	<!-- Bootstrap core JavaScript-->
	<script src="${path}/a00_com/vendor/jquery/jquery.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="${path}/a00_com/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${path}/a00_com/js/sb-admin-2.min.js"></script>

	<!-- 추가 plugins:js -->
	<script src="${path}/a00_com/vendor/js/vendor.bundle.base.js"></script>
	<script src="${path}/a00_com/vendor/datatables/jquery.dataTables.js"></script>
	<script
		src="${path}/a00_com/vendor/datatables/dataTables.bootstrap4.js"></script>
	<script src="${path}/a00_com/js/dataTables.select.min.js"></script>
</body>
</html>