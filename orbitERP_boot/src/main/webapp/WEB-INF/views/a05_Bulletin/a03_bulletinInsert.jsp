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





<script src="${path}/a00_com/jquery.min.js"></script>



<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}"
		if (msg != "") {
			if (!confirm(msg + "\n계속 등록하시겠습니까?")) {
				location.href = "${path}/bulList"
			}			
		}
		$("#regBtn").click(function() {
			if ($("#fif").val() == "" || $("#fif").val() == null) {
				alert("제목을 등록하세요")
				return;
			}
			if ($("#gil").val() == "" || $("#gil").val() == null) {
				alert("내용을 등록하세요")
				return;
			}
			if (confirm("등록하시겠습니까?")) {
				$("form").submit()
			}
		})
		$("#mainBtn").click(function() {
			//alert("초기 리스트 화면 이동")
			location.href = "${path}/bulList"
		})
	})
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



<!-- Custom fonts for this template-->
<link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${path}/a00_com/css/sb-admin-2.min.css" rel="stylesheet">



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
					<h1 class="h3 mb-4 text-gray-800">게시글</h1>
					<br> <br>
					<form method="post" enctype="multipart/form-data" action="${path}/insertBulletin">
						
						<div class="row">
							<div class="col-md-1">
								<label>제목</label>
							</div>
							<div class="col-md-11">
								<input class="form-control form-control-user"
									value="${bulletin.title}" name="title" id="fif" />
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-md-1">
								<label>게시자</label>
							</div>
							<div class="col-md-11">
								<input class="form-control form-control-user" required
									value="${emem.auth}" name="auth" readonly />
							</div>
						</div>
						<br>
						
						<div class="row">
							<div class="col-md-1">
								<label>첨부파일</label>
							</div>
							<div class="col-md-11">
								<input type="file" class="form-control form-control-user"
									multiple="multiple" value="" name="reports" />
							</div>
						</div>
						<br>
						
						<div class="row">
							<div class="col-md-1">
								<label>내용</label>
							</div>
							<div class="col-md-11">
								<textarea class="form-control" id="gil" name="content">${bulletin.content}</textarea>
							</div>
						</div>
						<br> <br>
						<div class="row justify-content-end">
							<div class="col-auto">
								<input type="button" class="btn btn-primary" value="등록"
									id="regBtn" />
							</div>
							<div class="col-auto">
								<input type="button" class="btn btn-info" value="게시판 리스트"
									id="mainBtn" />
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
						<span>Copyright &copy; Orbit ERP presented by TEAM FOUR</span>
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

	<!-- Page level plugins -->
	<script src="${path}/a00_com/vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="${path}/a00_com/js/demo/chart-area-demo.js"></script>
	<script src="${path}/a00_com/js/demo/chart-pie-demo.js"></script>
</body>
</html>