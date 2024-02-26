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
	//체크된 값들을 저장할 배열
	var checkedValues = [];
	$(document).ready(function() {
		$("#empListBtn").click(function(){
			empList()
			checkedValues = [];
			$("[name=receiver]").val("")
			$("#empModalBtn").click();
		})
		$("#schTBtn").click(function(){
			empList()
		})
		$("#selectAll").click(function() {
			var isChecked = $(this).prop('checked'); // 전체 선택 체크박스의 상태 가져오기

		    $(".selectRow").prop('checked', isChecked); // 모든 개별 체크박스에 전체 선택 상태 적용

		    // 개별 체크박스가 체크되었을 경우 배열에 값을 추가
		    if (isChecked) {
		        $(".selectRow:checked").each(function() {
		            var empno = $(this).closest("tr").find("td.empno").text();
		            var ename = $(this).closest("tr").find("td.ename").text();
		            
		            checkedValues.push({
		                empno: empno,
		                ename: ename
		            });
		        });
		    } else {
		        checkedValues = []; // 전체 선택 해제 시 배열 초기화
		    }

		    console.log(checkedValues); // 배열 확인
	    });
		
		$('#dataTable5').on('draw.dt', function() {
		    $("#selectAll").prop('checked', false);//페이지 이동하면 전체체크해제]
		});
		
		$('#sendBtn').click(function() { // 보내기 버튼
		    
		    if ($("[name=altitle]").val() == "") {
		        alert("제목을 입력하세요.");
		        return;
		    }
		    if ($("[name=receiver]").val() == "") {
		        alert("받는 사람을 선택하세요.");
		        return;
		    }
		    if ($("[name=alcategory]").val() == "") {
		        alert("카테고리를 선택하세요.");
		        return;
		    }
		    if ($("[name=alcontent]").val() == "") {
		        alert("내용를 선택하세요.");
		        return;
		    }
		    

		    var categoryVal = $("[name=alcategory]").val()
		    console.log(categoryVal)
		    switch (categoryVal) {
		        case "공지사항":
		            $("[name=color]").val("danger");
		            $("[name=icon]").val("bell");
		            break;
		        case "회의":
		            $("[name=color]").val("warning");
		            $("[name=icon]").val("users");
		            break;
		        case "일정":
		            $("[name=color]").val("info");
		            $("[name=icon]").val("calendar-alt");
		            break;
		        default: //개인 그 이외의 값
		            $("[name=color]").val("primary");
		            $("[name=icon]").val("file-alt");
		            break;
		    }
			$("[name=sender]").val('${sender.empno}')
			receiverList(checkedValues,categoryVal)//알림보내기 empno,카테고리
		    checkedValues.forEach(function (check) {
		        $("[name=receiver]").val(check.empno);

		        $.ajax({
		            type: "POST",
		            url: "/sendAlramGo",
		            data: $("#frm01").serialize(),
		            dataType: "json",
		            success: function (data) {
		                alert(data.msg)
					    window.close()
		            },
		            error: function (err) {
		                console.log(err);
		                // Handle form submission error here
		            }
		        });
		    });
		});
	})
	
	function table(){
		$("#dataTable5").DataTable({
	    	//"paging": true,        // 페이지 나누기 기능 사용
	    	"pageLength": 10, 
	        "lengthChange": false, // 한 페이지에 표시되는 행 수 변경 가능
	        "searching": false, // 검색 기능 사용
	        "ordering": false, // 정렬 기능 사용
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
	            	stuhtml += "<td><input type='checkbox' class='selectRow' value='' " + (isChecked(emp.empno) ? "checked" : "") + "></td>"
	                stuhtml += "<td class='empno'>" + emp.empno + "</td>"
	                stuhtml += "<td class='ename'>" + emp.ename + "</td>"
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
	// 이미 선택된 사원인지 확인하는 함수
	function isChecked(empno) {
	    return checkedValues.some(function (value) {
	        return value.empno === empno;
	    });
	}
	function getCheck() {
	    // 선택 버튼 클릭 시
	    var cnt = 1;
	    var rechtml = "";

	    checkedValues.forEach(function (check) {
	        rechtml += check.ename + ', ';
	        cnt++;

	        if (cnt === 6) {
	            rechtml += '\n';
	            cnt = 1; // cnt 초기화
	        }
	    });

	    rechtml = rechtml.slice(0, -2);
	    $("[name=receiver]").val(rechtml);
	    $("#close").click(); // 모달창 닫기
	}

	// 체크박스 클릭 시 배열에 저장
	document.addEventListener('change', function (event) {
	    if (event.target.classList.contains('selectRow')) {
	    	var empno = event.target.closest("tr").querySelector("td.empno").innerText;
	    	var ename = event.target.closest("tr").querySelector("td.ename").innerText;
	    	
	    	if (event.target.checked) {
		    		checkedValues.push({
			            empno: empno,
			            ename: ename
			        });
	        } else {
	            // 체크가 해제된 경우 해당 객체를 배열에서 제거
	            checkedValues = checkedValues.filter(function (value) {
	                return value.empno !== empno;
	            });
	        }
	    	
	    	console.log(checkedValues)
	    }
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
<!-- 알림보내기 페이지 -->
<%@ include file="/WEB-INF/views/a00_module/a03_topBar.jsp" %> 
<script>
document.getElementById("hiden").style.display = "none";
</script>
<div class="notification-form">
  <div class="header">
    <h5>알림보내기</h5>
  </div>
  <div class="body">
    <form id="frm01" class="form" method="post">
      <input type="hidden" name="id" value="0" />
      <div class="input-group mb-3">
        <label for="altitle" class="input-group-text">제목</label>
        <input type="text" name="altitle" class="form-control" value="${altitle}"/>
      </div>
      <div class="input-group mb-3">
        <label for="sender" class="input-group-text">보내는사람</label>
        <input type="text" id="sender" name="sender" readonly class="form-control" value="${sender.ename}" />
      </div>
      <div class="input-group mb-3">
        <label for="receiver" class="input-group-text">받는사람</label>
        <input type="text" name="receiver" class="form-control" readonly/>
        <button type="button" id="empListBtn" class="btn btn-dark">사원조회</button>
      </div>
      <div class="input-group mb-3">
      	<input type="text" name="color" class="form-control" style="display: none;" value=""/>
      	<input type="text" name="icon" class="form-control" style="display: none;" value=""/>
        <label for="alcategory" class="input-group-text">카테고리</label>
        <select name="alcategory" class="form-control">
          <option value="">선택</option>
          <option value="공지사항">공지사항</option>
          <option value="회의">회의</option>
          <option value="일정">일정</option>
          <option value="개인">개인</option>
          </select>
      </div>
      <div class="input-group mb-3">
        <label for="alcontent" class="input-group-text">내용</label>
        <textarea id="alcontent" name="alcontent" class="form-control" rows="8"></textarea>
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
						<button type="button" class="btn btn-success" onclick="getCheck()">선택</button>
							<button type="button" class="btn btn-secondary" id="close"
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