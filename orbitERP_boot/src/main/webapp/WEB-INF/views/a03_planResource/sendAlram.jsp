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
 <style type="text/css">
 body {
  background-color: #f5f5f5;
}
 .notification-form {
  color: #333333;
  padding: 20px 30px;
}

.header {
 padding: 10px 0
 }
.input-group-text {
  width: 90px;
}
#sendBtn {
  float: right;
}
 </style>
<!-- jQuery -->
<script src="${path}/a00_com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		$("#empListBtn").click(function(){
			empList()
			$("#empModalBtn").click();
		})
		$("#schTBtn").click(function(){
			empList()
		})
		$("#selectAll").click(function() {
	        $(".selectRow").prop('checked', $(this).prop('checked'));
	    });
		$('#dataTable5').on('draw.dt', function() {
		    $("#selectAll").prop('checked', false);
		});
	})
	function table(){
		$("#dataTable5").DataTable({
	    	//"paging": true,        // 페이지 나누기 기능 사용
	    	"pageLength": 10, 
	        "lengthChange": false, // 한 페이지에 표시되는 행 수 변경 가능
	        "searching": false, // 검색 기능 사용
	        "ordering": true, // 정렬 기능 사용
	        "info": true, // 표시 건수 및 현재 페이지 표시
	        "autoWidth": false, // 컬럼 너비 자동 조절 해제
	        "language" : {
	        	 "emptyTable" : "검색한 데이터가 없습니다.",
	        	 "info": "현재 _START_ - _END_ / 총 _TOTAL_건",
	        	 "paginate": {
	        		  	"next": "다음",
	        			"previous": "이전"
	        		  }
	        }
	    })
	}
	function empList(){
		$.ajax({
			type:"POST",
			url:"/schEmp",
			data:$("#frm02").serialize(),
			dataType: "json",
			success: function (data) {
				var stuhtml = "";
				$("#dataTable5").DataTable().destroy();
	            $.each(data.empList, function (idx, emp) {
	            	stuhtml += "<tr>";
	                stuhtml += "<td><input type='checkbox' class='selectRow' value=''></td>"
	                stuhtml += "<td>" + emp.empno + "</td>"
	                stuhtml += "<td>" + emp.ename + "</td>"
	                stuhtml += "<td>" + emp.job + "</td>"
	                stuhtml += "<td>" + emp.deptno + "</td>"
	                stuhtml += "</tr>"
	            })

	            $("#emp").html(stuhtml);
	           table()
            },
            error: function (err) {
                console.log(err);
                // Handle form submission error here
            }
		})
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
<!-- 알림보내기 페이지 -->
<div class="notification-form">
  <div class="header">
    <h5>알림보내기</h5>
  </div>
  <div class="body">
    <form id="frm01" class="form" method="post">
      <input type="hidden" name="id" value="0" />
      <div class="input-group mb-3">
        <label for="title" class="input-group-text">제목</label>
        <input type="text" name="title" class="form-control" />
      </div>
      <div class="input-group mb-3">
        <label for="sender" class="input-group-text">보내는사람</label>
        <input type="text" id="sender" readonly class="form-control" value="${sender}" />
      </div>
      <div class="input-group mb-3">
        <label for="receiver" class="input-group-text">받는사람</label>
        <input type="text" id="receiver" class="form-control" />
        <button type="button" id="empListBtn" class="btn btn-dark">사원조회</button>
      </div>
      <div class="input-group mb-3">
        <label for="category" class="input-group-text">카테고리</label>
        <select name="category" class="form-control">
          <option value="">선택</option>
          <option value="공지">공지사항</option>
          <option value="회의">회의</option>
          <option value="일정">일정</option>
          <option value="개인">개인</option>
          </select>
      </div>
      <div class="input-group mb-3">
        <label for="content" class="input-group-text">내용</label>
        <textarea id="content" name="content" class="form-control" rows="8"></textarea>
      </div>
    </form>
  </div>
    <button type="button" id="sendBtn" class="btn btn-primary">보내기</button>
</div>
<!-- 사원조회 모달시작 -->
<button id="empModalBtn" class="btn btn-success d-none"
					data-toggle="modal" data-target="#empModal" type="button">등록</button>
<div class="modal" id="empModal" >
				<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">사원조회</h5>
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
									<input placeholder="사원명" name="ename"
										class="form-control mr-sm-2" />
									<select name="deptno"
										class="form-control form-control-user">
										<option value="0">부서선택</option>
										<c:forEach var="dept" items="${dlist}">
											<option value="${dept.deptno}">${dept.dname}(${dept.dcode})</option>
										</c:forEach>
									</select>
									<button class="btn btn-info" type="button" id="schTBtn">Search</button>
								</nav>
							</form>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable5">
									<thead>
										<tr>
											<th><input type="checkbox" id="selectAll"></th>
											<th>사원번호</th>
											<th>이름</th>
											<th>직책</th>
											<th>부서번호</th>
										</tr>
									</thead>
									<tbody id="emp">
									</tbody>
								</table>
							</div>
						</div>
					</div>
						<div class="modal-footer">
						<button type="button" class="btn btn-success">선택</button>
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">닫기</button>
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
	<!-- 추가 plugins:js -->
	<script src="${path}/a00_com/vendor/datatables/jquery.dataTables.js"></script>
	<script
		src="${path}/a00_com/vendor/datatables/dataTables.bootstrap4.js"></script>
	<script src="${path}/a00_com/js/dataTables.select.min.js"></script>
</body>
</html>