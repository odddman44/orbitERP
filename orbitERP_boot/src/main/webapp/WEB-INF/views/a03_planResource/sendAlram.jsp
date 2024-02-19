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
	$(document).ready(function() {
		$("#calModal").click()
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
<button id="calModal" class="btn btn-success d-none"
					data-toggle="modal" data-target="#exampleModalCenter" type="button">등록</button>

<div class="modal fade" id="exampleModalCenter" tabindex="-1"
					role="dialog" aria-labelledby="exampleModalCenterTitle"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="calTitle"></h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form id="frm01" class="form" method="post">
									<input type="hidden" name="id" value="0" />
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												강의명</span>
										</div>
										<input type="text" name="title" class="form-control" readonly/>
									</div>
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												개강일자</span>
										</div>
										<input type="text" id="start" readonly class="form-control" />
									</div>
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												종강일자</span>
										</div>
										<input type="text" id="end" readonly class="form-control" />
									</div>
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												강의실</span>
										</div>
										<input name="lec_num" class="form-control" readonly/>
									</div>
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												강사명</span>
										</div>
										<input name="lec_teacher" class="form-control" readonly/>
									</div>
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												학생수</span>
										</div>
										<input name="lec_snum" class="form-control" readonly/>
									</div>
									<div class="input-group mb-3" id="backgroundColor">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												배경색상</span>
										</div>
										<input type="color" name="backgroundColor"
											class="form-control" value="#0099cc" />
									</div>
									<div class="input-group mb-3" id="textColor">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												글자색상</span>
										</div>
										<input type="color" name="textColor" class="form-control"
											value="#ccffff" />
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<!-- -->
								<button type="button" id="detailBtn" class="btn btn-primary">보내기</button>
							</div>
						</div>
					</div>
				</div>

	<!-- Bootstrap core JavaScript-->
	<script src="${path}/a00_com/vendor/jquery/jquery.min.js"></script>
	<script
		src="${path}/a00_com/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- Core plugin JavaScript-->
	<script src="${path}/a00_com/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${path}/a00_com/js/sb-admin-2.min.js"></script>
</body>
</html>