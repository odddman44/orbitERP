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




<script src="${path}/a00_com/jquery.min.js"></script>



<script type="text/javascript">
	var msg = "${msg}"

	if (msg != "") {
		var sno = $("[name=sno]").val()
			alert(msg) 
			location.href = "${path}/studentList"
		
	}

	$(document).ready(function() {
		var sno = $("[name=sno]").val();
		
		// 로그인된 세션 
		var auth="${emem.auth}"
		if(auth!=="인사관리자" && auth!=="총괄관리자"){
			$("#delBtn").hide()
			$("#uptBtn").hide()
			}

		// 부서리스트로 화면으로 이동
		// 부서리스트로 화면으로 이동
		$("#goListBtn").click(function() {

			location.href = "studentList";

		});
		$("#delBtn").click(function() {
			if (confirm("학생 정보를 삭제하시겠습니까?")) {
				deleteStudent()

			}
		})
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

	function deleteStudent() {
		var sno = $("[name=sno]").val()
		$.ajax({
			url : "${path}/deleteStudent",
			data : {
				sno : sno
			},
			dataType : "json",
			success : function(data) {
				if (data.isDel > 0) {
					alert("학생정보 삭제 성공!")
					location.href = "${path}/studentList"
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
					<h1 class="h3 mb-4 text-gray-800">학생 상세 정보</h1>
					<br> <br>
					<div class="d-flex justify-content-left">
						<!--  <img id="profile" src="${profile}" width="100px" height="100px" alt="사진" /> -->
					</div>
					<form id="frm01" method="post" action="${path}/updateStudent"
						enctype="multipart/form-data">

						<br>
						<div class="row justify-content-left align-items-left">
							<div class="col-sm-8">

								<c:if test="${not empty fname}">
									<!-- fname이 null이 아닐 때 처리할 내용 -->
									<img id="profileImage" src="${path}/z02_upload/${fname}"
										width="150px" height="150px">
								</c:if>
								<c:if test="${empty fname}">
									<!-- 저장된 사진이 없을 때 -->
									<img id="profileImage" src="${path}/z02_upload/기본프사.png"
										width="103px" height="132px">
								</c:if>
								<input id="profileInput" class="form-control form-control-user"
									type="file" name="profile" accept="image/*">
							</div>
							<br>
						</div>

						<br> <br>
						<div class="row justify-content-left align-items-left">
							<label for="sno" class="col-sm-1 col-form-label">학생번호</label>
							<div class="col-sm-3">
								<input type="text" readonly
									class="form-control form-control-user" name="sno"
									value="${student.sno}">
							</div>
							<label for="name" class="col-sm-1 col-form-label">학생명</label>
							<div class="col-sm-3">
								<input type="text" class="form-control form-control-user"
									name="name" value="${student.name}">
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="birth" class="col-sm-1 col-form-label">생년월일</label>
							<div class="col-sm-3">
								<input type="date" class="form-control form-control-user"
									name="birth" value="${student.birth}" />
							</div>
							<label for="final_degree" class="col-sm-1 col-form-label">학년</label>
							<div class="col-sm-3">
								<input type="text" class="form-control form-control-user"
									name="final_degree" value="${student.final_degree}">
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="phone" class="col-sm-1 col-form-label">H.P</label>
							<div class="col-sm-3">
								<input type="text" class="form-control form-control-user"
									name="phone" value="${student.phone}">
							</div>
							<label for="reg_date" class="col-sm-1 col-form-label">등록일자</label>
							<div class="col-sm-3">
								<input type="date" class="form-control form-control-user"
									name="reg_date" value="${student.reg_date}">
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="address" class="col-sm-1 col-form-label">주소</label>
							<div class="col-sm-7">
								<input type="text" class="form-control form-control-user"
									name="address" value="${student.address}">
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="account" class="col-sm-1 col-form-label">계좌번호</label>
							<div class="col-sm-7">
								<input type="text" class="form-control form-control-user"
									name="account" value="${student.account}">
							</div>
						</div>







						<br> <br>
						<div class="row justify-content-left">
							<div class="col-auto">
								<input type="submit" class="btn btn-primary" value="수정"
									id="uptBtn" />
							</div>
							<div class="col-auto">
								<input type="button" class="btn btn-primary" value="삭제"
									id="delBtn" />
							</div>
							<div class="col-auto">
								<input type="button" class="btn btn-info" value="학생리스트"
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