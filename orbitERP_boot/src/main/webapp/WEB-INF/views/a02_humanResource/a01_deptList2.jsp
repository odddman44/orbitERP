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

<!-- jQuery -->
<script src="${path}/a00_com/jquery-3.6.0.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		console.log($("#frm01 [name=dname]").val())

		/*
		$("#frm02 input[name=deptno]").on("change", function() {
			var deptno = $(this).val();
			//alert(deptno);
			if (!isNal(deptno)) {
				// ajax 실행
			} else {
				alert("부서번호는 숫자로 입력해주세요.")
			}

		})
		 */

		$("#regDeptBtn").click(function() {
			if ($("#frm02 [name=deptno]").val() == "") {
				alert("부서번호 등록하세요")
				return;
			}
			if ($("#frm02 [name=isChecked]").val() == "N") {
				alert("부서번호 중복체크를 해주세요")
				return;
			}
			if ($("#frm02 [name=dname]").val() == "") {
				alert("부서명을 등록하세요")
				return;
			}
			if ($("#frm02 [name=dcode]").val() == "") {
				alert("부서코드를 등록하세요.")
				return;
			}
			if (confirm("등록하시겠습니까?")) {
				//alert("게시물을 등록합니다.")
				insertDept();
			}

		})
		$("#dupBtn").click(function() {
			var deptno = $("#frm02 [name=deptno]").val()
			dupleCheck(deptno);
		})
		$("#frm02 [name=deptno]").keyup(function(event) {

			var deptno = $("#frm02 [name=deptno]").val()
			if (event.keyCode == 13) {
				dupleCheck(deptno);
			}
		})
	});
	// 상세 페이지 이동
	function goPage(deptno) {
		location.href = "deptDetail?deptno=" + deptno
	}
	// 부서번호 중복체크 함수
	function dupleCheck(deptno) {
		$.ajax({
			url : "${path}/duplicateDeptno",
			type : "GET",
			data : {
				deptno : deptno
			},
			dataType : "json",
			success : function(data) {
				if (data.isExist > 0) {
					$("#resultMsg").text("존재하는 부서번호입니다.")
					$("#resultMsg").css("color", "red")
				} else {
					$("#resultMsg").text("등록가능한 부서번호입니다.")
					$("#resultMsg").css("color", "blue")
					$("#frm02 [name=isChecked]").val("Y")
					console.log($('#frm02 [name=isChecked]').val())
				}

			},
			error : function(err) {
				console.log(err)
			}
		})
	}
	// 부서등록 함수
	function insertDept() {
		$.ajax({
			url : "${path}/insertDept",
			data : $("#frm02").serialize(),
			dataType : "json",
			success : function(data) {
				if (data.isInsert > 0) {
					alert("부서정보 등록 성공!")
					location.href = "${path}/deptList"
				}
			}
		})

	}
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
<style>
#regBtn {
	float: right;
}

table {
	text-align: center;
}

.input-group-text {
	width: 100px;
}

#chatArea {
	width: 100%;
	height: 200px;
	overflow-y: auto;
	text-align: left;
	border: 1px solid green;
}
</style>
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
						<div class="row">
							<div class="col-12">
								<h1 class="h3 mb-0 text-gray-800">부서정보조회</h1>
							</div>
						</div>
						<div class="row">
							<form method="post">
								<div class="input-group">
									<input type="text" class="form-control bg-light border-1 small"
										name="dname" placeholder="부서검색" value="${dept.dname}"
										aria-label="Search" aria-describedby="basic-addon2">
									<div class="input-group-append">
										<button class="btn btn-primary" type="submit">
											<i class="fas fa-search fa-sm"></i>
										</button>
							</form>

						</div>

					</div>
				</div>


			</div>
			<!-- Content Row -->

			<div class="row">
				<table class="table table-hover" id="dataTable">
					<col width="33%">
					<col width="34%">
					<col width="33%">
					<thead class="thead-light">

						<tr class="table-success text-center">
							<th>부서번호</th>
							<th>부서명</th>
							<th>부서코드</th>

						</tr>
					</thead>
					<tbody>
						<c:forEach var="depart" items="${deptList}">
							<tr onclick="goPage('${depart.deptno}')">
								<td>${depart.deptno}</td>
								<td>${depart.dname}</td>
								<td>${depart.dcode}</td>

							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>


			<!-- Content Row -->

			<div style="text-align: right;">
			<c:if test="${emem.auth eq '인사관리자'}">
				<input data-toggle="modal" data-target="#exampleModalCenter"
					type="button" class="btn btn-success" value="부서등록" id="refBtn" />
			</c:if>
			</div>

			<!-- Content Row -->
			<div class="row"></div>

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
	<div class="modal fade" id="exampleModalCenter" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalCenterTitle"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLongTitle">부서등록</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="frm02" class="form" method="post" action="insertDept">
						<div class="input-group mb-3">
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">부서번호</span>

							</div>
							<input type="number" name="deptno" class="form-control" /> <input
								type="hidden" name="isChecked" value="N" />
							<button type="button" id="dupBtn" class="btn btn-primary">부서번호
								중복체크</button>
						</div>
						<div id="resultMsg">부서번호 중복체크를 진행해주세요.</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">
									부서명</span>
							</div>
							<input type="text" name="dname" class="form-control" />
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">
									부서코드</span>
							</div>
							<input type="text" name="dcode" multiple="multiple"
								class="form-control" />
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend ">
								<span class="input-group-text  justify-content-center">
									기타</span>
							</div>
							<textarea id="chatArea" name="etc"></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" id="regDeptBtn" class="btn btn-primary">등록</button>
				</div>
			</div>
		</div>
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