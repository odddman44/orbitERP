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
	var msg = "${msg}"
	console.log("msg:"+msg)
	if(msg!=""){
		alert(msg);
		location.href="${path}/studentList"
	}
	$(document).ready(function() {
		// 로그인된 세션 
		var auth="${emem.auth}"
		if(auth!=="인사관리자" && auth!=="총괄관리자"){
			$("#regBtn").hide()
			}
		$("#regFrmBtn").click(function(){
			if($("#frm02 [name=name]").val()==""){
				alert("학생명을 입력하세요")
				return;
			}
			if($("#frm02 [name=birth]").val()==""){
				alert("생년월일을 입력하세요")
				return;
			}
			if($("#frm02 [name=final_degree]").val()==""){
				alert("학년을 입력하세요")
				return;
			}
			if($("#frm02 [name=reg_date").val()==""){
				alert("등록일자를 입력하세요")
				return;
			}
			if(confirm("학생 정보를 등록하시겠습니까?")){
				//alert("게시물을 등록합니다.")
				$("form").submit()				
			}
		})
	    // 파일 입력이 변경되었을 때 이벤트 핸들러 등록
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
	})

	// 상세 페이지 이동
	function goPage(sno) {
		location.href = "detailStudent?sno=" + sno
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
						<h1 class="h3 mb-0 text-gray-800">☆ 학생정보 조회</h1>
					</div>
					<!-- 테이블 -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">

							<hr>
							<form id="frm01" class="form" method="post">
								<input type="hidden" name="curPage" value="${sch.curPage}">
								<nav class="navbar navbar-expand-sm navbar-light bg-light">

									<input placeholder="학생명" name="name" value="${sch.name}"
										class="form-control mr-sm-2" /> 
									<select class="form-control mr-sm-2" name="final_degree">									
										<option value="">학년 선택</option>
										<option value="초등">초등</option>
										<option value="중등">중등</option>
										<option value="고등">고등</option>
										<option value="성인">성인</option>
									</select>
									
									<button class="btn btn-info" type="submit">Search</button>
								</nav>
								<div class="input-group mt-3 mb-0">
									<span class="input-group-text">총 학생 수 : ${sch.count}명</span>
									<button type="button" id="regBtn" class="btn btn-success"
										data-toggle="modal" data-target="#registerModal">학생
										정보 등록</button>
									<input type="text" class="form-control" style="width: 50%;"
										readonly> 
								</div>
							</form>

						</div>
						<div class="card-body">
							<span>테이블의 행을 클릭시, 수정 및 삭제가 가능합니다.</span>
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable">
									<thead>
										<tr>
											<th>학생번호</th>
											<th>학생명</th>
											<th>학년</th>
											<th>등록일자</th>

										</tr>
									</thead>
									<tbody>
										<c:forEach var="stu" items="${studentList}">
											<tr
												onclick="location.href='detailStudent?sno='+${stu.sno}">
												<td>${stu.sno}</td>
												<td>${stu.name}</td>
												<td>${stu.final_degree}</td>
												<td>${stu.reg_date}</td>
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
					<h5 class="modal-title" id="registerModalLabel">학생 등록</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="frm02" method="POST" action="${path}/insertStudent" enctype="multipart/form-data">
						<div class="d-flex justify-content-left">
							<img id="profilePreview" src="" width="103px" height="132px" alt="사진없음" />
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<div class="col-sm-12">
							<input type="file" name="profile" class="form-control form-control-user" accept="image/*">
							</div>
						</div>

						<br> <br>
						<div class="row justify-content-left align-items-left">
							<label for="name" class="col-sm-3 col-form-label">학생명</label>
							<div class="col-sm-9">
								<input type="text" class="form-control form-control-user"
									name="name">
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="birth" class="col-sm-3 col-form-label">생년월일</label>
							<div class="col-sm-9">
								<input type="date" class="form-control form-control-user"
									name="birth" />
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="final_degree" class="col-sm-3 col-form-label">학년</label>
							<div class="col-sm-9">
								<select class="form-control form-control-user" name="final_degree">
									<option>초등 1학년</option>
									<option>초등 2학년</option>
									<option>초등 3학년</option>
									<option>초등 4학년</option>
									<option>초등 5학년</option>
									<option>초등 6학년</option>
									<option>중등 1학년</option>
									<option>중등 2학년</option>
									<option>중등 3학년</option>
									<option>고등 1학년</option>
									<option>고등 2학년</option>
									<option>고등 3학년</option>
									<option>성인</option>
								</select>
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="phone" class="col-sm-3 col-form-label">H.P</label>
							<div class="col-sm-9">
								<input type="text" class="form-control form-control-user"
									name="phone" >
							</div>
						</div>
						<br>
						<div class="row justify-content-left align-items-left">
							<label for="reg_date" class="col-sm-3 col-form-label">등록일자</label>
							<div class="col-sm-9">
								<input type="date" class="form-control form-control-user"
									name="reg_date" />
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