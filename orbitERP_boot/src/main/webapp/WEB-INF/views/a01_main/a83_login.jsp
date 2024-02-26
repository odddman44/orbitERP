<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>:: Orbit ERP ::</title>
<link href="${path}/a00_com/img/logo.svg" rel="icon" type="image/x-icon" />
<!-- jQuery -->
<script src="${path}/a00_com/jquery-3.6.0.js"></script>

<script type="text/javascript">
	var id = "${erpmem.empno}"
	var sessId = "${emem.empno}"
	console.log("요청값1:" + id)
	if (id != "") {
		console.log("요청값2:" + id)
		if (sessId != "") {
			console.log("요청값3:" + sessId)
			alert("${emem.ename}님 반갑습니다!\r\n 로그인 되었습니다.")
			location.href = "${path}/main"
		} else {
			alert("로그인 실패! \n다시 로그인하세요..")
		}
	}
	
	$(document).ready(function() {
		// 이전화면에서 요청된 내용을 선택하게 하게, 선택할 때, 서버에 언어 선택 내용 전달.
		$("#selectLan").change(function() {
			var chVal = $(this).val()
			if (chVal != '') {
				location.href = "${path}/multiLang?lang=" + chVal
			}
		})
	});
</script>

<!-- Custom fonts for this template-->
<link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${path}/a00_com/css/sb-admin-2.min.css" rel="stylesheet">
<link href="${path}/a00_com/css/custom-style.css" rel="stylesheet">

</head>
<body class="bg-gradient-primary">

	<div class="container">

		<!-- Outer Row -->
		<div class="row justify-content-center">

			<div class="col-xl-10 col-lg-12 col-md-9">

				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block bg-login-image">
								<img src="${path}/a00_com/images/login_image.png">
							</div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-4">Orbit ERP <spring:message code="log"/></h1>
									</div>
									<form class="user" method="post">
										<div class="form-group">
											<input type="text" name="empno"
												class="form-control form-control-user" id="empno"
												name="empno" aria-describedby="emailHelp"
												placeholder='<spring:message code="empno"/>'>
										</div>
										<div class="form-group">
											<input type="password" name="pwd"
												class="form-control form-control-user" id="pwd" name="pwd"
												placeholder='<spring:message code="pwd"/>'>
										</div>
										<button type="submit"
											class="btn btn-primary btn-user btn-block"><spring:message code="log"/></button>
										<hr>
									</form>
									<div class="text-center">
										<a class="small" href="${path}/mailToPasswordFrm"><spring:message code="amnesia" /></a>
									</div>
									<div class="text-center">
										<select class="small" id="selectLan">
											<option value=""><spring:message code="seleclang" /></option>
											<option value="ko"><spring:message code="ko" /></option>
											<option value="en"><spring:message code="en" /></option>
										</select>
									</div>
								</div>
							</div>
						</div>
					</div>
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

	<!-- Page level plugins -->
	<script src="${path}/a00_com/vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="${path}/a00_com/js/demo/chart-area-demo.js"></script>
	<script src="${path}/a00_com/js/demo/chart-pie-demo.js"></script>
</body>
</html>