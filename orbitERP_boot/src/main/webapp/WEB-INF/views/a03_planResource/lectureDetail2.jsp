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
		console.log("${lecture.lecno}")
			searchStu()
		 	// 숫자에 콤마를 추가하는 함수
		       function addCommas(nStr) {
		           nStr += '';
		           var x = nStr.split('.');
		           var x1 = x[0];
		           var x2 = x.length > 1 ? '.' + x[1] : '';
		           var rgx = /(\d+)(\d{3})/;
		           while (rgx.test(x1)) {
		               x1 = x1.replace(rgx, '$1' + ',' + '$2');
		           }
		           return x1 + x2;
		       }
		   
		       // 키 입력시 자동으로 콤마 처리
		       $('#tuition_fee,#textbook_fee').on('input', function() {
		           var input = $(this).val().replace(/,/g, ''); // 먼저 콤마를 제거
		           if (!isNaN(input)) { // 입력 값이 숫자인 경우
		               $(this).val(addCommas(input)); // 콤마 추가
		           }
		       });
	
	    
	$("#uptBtn").click(function(){
			if($("[name=lec_name]").val()==""){
				alert("강의명을 입력하세요")
				return;
			}
			if($("[name=start_date]").val()==""){
				alert("개강일자를 입력하세요")
				return;
			}
			if($("[name=end_date]").val()==""){
				alert("종강일자를 입력하세요")
				return;
			}
			if($("[name=lec_num]").val()==""){
				alert("강의실을 입력하세요")
				return;
			}
			if($("[name=tuition_fee]").val()==""||
					isNaN($("[name=tuition_fee]").val())){
				alert("강의료를 숫자로 입력하세요")
				return;
			}
			if($("[name=textbook_fee]").val()==""||
					isNaN($("[name=textbook_fee]").val())){
				alert("교재비를 숫자로 입력하세요")
				return;
			}
			if($("[name=lec_content]").val()==""){
				alert("강의내용을 입력하세요")
				return;
			}
			if(confirm("수정하시겠습니까?")){
	        $("form").attr("action", "lectureUpdate");
	        $("form").submit();
		}
		
	})
	$("#delBtn").click(function(){
		if(confirm("${lecture.lec_code}${lecture.lecno}를 삭제하시겠습니까?")){
			$("form").attr("action", "lectureDelete");
	        $("form").submit();
		}
	
	})
	
	var msg = "${msg}"
	if(msg!=""){
		alert(msg)
		if(msg="삭제완료"){
			location.href="lectureList"
		}
	}
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
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">[${lecture.lec_code}${lecture.lecno}]
							상세정보</h1>
					</div>
					<div class="card shadow mb-4">
						<div class="card-body">
							<div id="text">
							<form>
							<div class="input-group mb-3">
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">
										강의코드</span>
								</div>
								<input name="lec_code" class="form-control"
									value="${lecture.lec_code}" readonly/>
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center" >
										강의번호</span>
								</div>
								<div class="input_value">
								<input name="lecno" class="form-control"
									value="${lecture.lecno}" readonly/>
								</div>
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">
										강의명</span>
								</div>
								<input name="lec_name" class="form-control"
									value="${lecture.lec_name}" />
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">
										강사명</span>
								</div>
								<div class="input_value">
								<input name="lec_teacher" class="form-control"
									value="${lecture.lec_teacher}" />
									<input type="button" class="btn btn-dark" value="강사조회" id="find" />
									</div>
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">
										개강일자</span>
								</div>
								<input type="date" name="start_date" class="form-control"
									value="${lecture.start_date}" />
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">
										종강일자</span>
								</div>
								<div class="input_value">
								<input type="date" name="end_date" class="form-control"
									value="${lecture.end_date}" />
									</div>
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">
										강의실</span>
								</div>
								<input name="lec_num" class="form-control"
									value="${lecture.lec_num}" />
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">
										학생수</span>
								</div>
								<div class="input_value">
								<input name="lec_snum" class="form-control" value="${lecture.lec_snum}" />
								<input type="button" class="btn btn-dark" value="학생조회" id="find" />
								</div>
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">
										강의료</span>
								</div>
								<input name="tuition_fee" class="form-control"
									value="${lecture.tuition_fee}"/>
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">
										교재비</span>
								</div>
								<div class="input_value">
								<input name="textbook_fee" class="form-control"
									value="${lecture.textbook_fee}" />
								</div>
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">
										강의내용</span>
								</div>
								<textarea id="chatArea" name="lec_content" class="form-control">${lecture.lec_content}</textarea>
							</div>
							<div style="text-align: right;">
								<input type="button" class="btn btn-success" value="수정" id="uptBtn" />
								<input type="button" class="btn btn-danger" value="삭제" id="delBtn" /> 
								<input type="button" class="btn btn-dark" value="알림보내기" id="mainBtn" />
							</div>
							</form>
						</div>
						</div>
						</div>
					</div>

					<!-- /.container-fluid (페이지 내용 종료) -->
				</div>
				<!-- start 학생조회modal -->
			<div class="modal" id="stuModal" >
				<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">학생등록</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
						<div class="card shadow mb-4">
						<div class="card-header py-3">

							<hr>
							<form id="frm02" class="form" method="post">
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
									<button class="btn btn-info" type="button" id="schBtn">Search</button>
								</nav>
								<div class="input-group mt-3 mb-0">
									<span class="input-group-text" id="totStu"></span>
								</div>
							</form>
						</div>
						<div class="card-body">
							<span>더블클릭시, 학생 상세정보 페이지로 이동합니다.</span>
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable1">
								  <col width="8%">
							      <col width="10%">
							      <col width="18%">
							      <col width="15%">
							      <col width="15%">
							      <col width="25%">
							      <col width="9%">
									<thead>
										<tr>
											<th>학생번호</th>
											<th>이름</th>
											<th>생년월일</th>
											<th>학년</th>
											<th>전화번호</th>
											<th>주소</th>
											<th>선택</th>
										</tr>
									</thead>
									<tbody id="stu">
									</tbody>
								</table>
							</div>
							<hr>
							<div class="table-responsive">
								<h5>수강학생</h5>
								<table class="table table-bordered" id="dataTable2">
								<col width="15%">
							    <col width="20%">
							    <col width="25%">
							    <col width="25%">
							    <col width="15%">
									<thead>
										<tr>
											<th>학생번호</th>
											<th>이름</th>
											<th>학년</th>
											<th>전화번호</th>
											<th>삭제</th>
										</tr>
									</thead>
									<tbody id="add">
									</tbody>
								</table>
							</div>
						</div>
					</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">닫기</button>
							<button type="button" class="btn btn-primary" id="insertStu">학생등록</button>
						</div>
					</div>
				</div>
			</div>
		</div>
				<!-- End of Main Content -->

				<!-- Footer -->
				<footer class="sticky-footer bg-white">
					<div class="container my-auto">
						<div class="copyright text-center my-auto">
							<span>Copyright &copy; Your Website 2021</span>
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
		<script
			src="${path}/a00_com/vendor/jquery-easing/jquery.easing.min.js"></script>

		<!-- Custom scripts for all pages-->
		<script src="${path}/a00_com/js/sb-admin-2.min.js"></script>
</body>
</html>