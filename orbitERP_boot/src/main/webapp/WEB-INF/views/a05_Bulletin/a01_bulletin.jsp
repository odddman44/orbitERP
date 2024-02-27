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
<%--
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
 --%>
<!-- jQuery -->
<script src="${path}/a00_com/jquery-3.6.0.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		
		$("#refBtn").click(function() {
			if ("${emem.auth}" === "총괄관리자") {
				location.href = "${path}/insertBulletinFrm";
			} else {
				alert("총괄관리자만 등록할 수 있습니다");
			}
		});
		
	});

	// 상세 페이지
	function goDetail(no) {
		location.href = "bulletinDetail?no=" + no
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

.pageSize {
	width: 20%
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
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<div class="row">
							<div class="col-12">
								<h1 class="h3 mb-0 text-gray-800">☆ 게시판</h1>
							</div>
						</div>
					</div>
				
			<!-- Content Row -->

			<div class="card shadow mb-4">
				<div class="card-header py-3">
				<div class="d-sm-flex align-items-center justify-content-between mb-4">
					<h5 class="m-0 font-weight-bold text-primary">공지사항 게시판</h5>
				
				<div class="row">
							<form id="unug" method="post">
								<input type="hidden" name="curPage" value="${sch.curPage}" />
								<div class="input-group-append">
									<input type="text" class="form-control bg-light border-1 small"
										name="title" placeholder="제목검색" value="${sch.title}" aria-label="Search"
										aria-describedby="basic-addon2"/>

										<button class="btn btn-primary" type="submit">
											<i class="fas fa-search fa-sm"></i>
										</button>
								</div>		
							</form>

						</div>
					</div>
				</div>

			<div class="card-body">
					<!-- 데이터 총 건수와 한 페이지 공개 데이터 선택창 -->
				<form id="kemet">
					<div class="input-group-append">
						<span class="input-group-text">총:${sch.count}건</span> 
						<input type="text" class="form-control" aria-label="Total count"  readonly/> 
						<span class="input-group-text">페이지 수</span> 
							<select name="pageSize" class="form-control text-align-center" aria-label="Page size" style="width: 15%;">
								<option>3</option>
								<option>5</option>
								<option>10</option>
								<option>20</option>
								<option>50</option>
							</select>
							
						</div>
						<br>
						
						<script type="text/javascript">
							// 선택된 페이지 사이즈를 다음 호출된 페이지에서 출력
							$("[name=pageSize]").val("${sch.pageSize}")
							// 페이지크기를 변경했을 때, 선택된 페이지를 초기페이지로 설정..
							$("[name=pageSize]").change(function() {
								$("[name=curPage]").val(1)
								$("#kemet").submit()
							})
						</script>
					</form>
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<col width="10%">
							<col width="15%">
							<col width="30%">
							<col width="25%">
							<col width="20%">

							<thead class="thead-light">

								<tr class="table-success text-center">
									<th>번호</th>
									<th>게시자</th>
									<th>제목</th>
									<th>등록일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody>

								<c:forEach var="bul" items="${bulList}">
									<tr ondblclick="goDetail(${bul.no})">
										<td>${bul.cnt}</td>
										<td>${bul.auth}</td>
										<td>${bul.title}</td>
										<td><fmt:formatDate value="${bul.regdte }" /></td>
										<td>${bul.readcnt}</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
						</div>
						<div style="text-align: right;">
							<input data-target="#exampleModalCenter" type="button"
								class="btn btn-info" value="게시글 등록" id="refBtn" />
						</div>
						
						<!-- 등록 버튼과 페이지 위치 못 맞추는 문제 있음 -->

						<ul class="pagination justify-content-center">
							<li class="page-item"><a class="page-link"
								href="javascript:goPage(${sch.startBlock-1})">Previous</a></li>
							<c:forEach var="pNo" begin="${sch.startBlock }"
								end="${sch.endBlock}">
								<li class="page-item ${sch.curPage==pNo?'active':''}"><a
									class="page-link" href="javascript:goPage(${pNo})">${pNo}</a></li>
							</c:forEach>
							<li class="page-item"><a class="page-link"
								href="javascript:goPage(${sch.endBlock+1})">Next</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
			<script type="text/javascript">
				function goPage(pNo) {
					$("[name=curPage]").val(pNo)
					$("#unug").submit()
				}
			</script>

			<!-- Content Row -->



			<!-- Content Row -->
			<div class="row"></div>

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
		<!-- /.container-fluid (페이지 내용 종료) -->

	</div>
	<!-- End of Main Content -->

	
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