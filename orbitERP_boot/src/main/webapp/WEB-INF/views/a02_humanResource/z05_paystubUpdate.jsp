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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	
	// 체크된 급여 리스트를 저장할 배열
	var paystubList = [] // 기존에 있던 paystub ajax로 받아옴

	
	

	
	
	
	$(document).ready(function() {
		
		
		
		
		// json으로 기존에 있던 사원별 급여리스트를 받아온다.
		$.ajax({
		    url: '${path}/updatePaystubFrmJson',
		    type: 'post',
		    data: {
		        payment_dateStr: '${param.payment_dateStr}',
		        deptno: '${param.deptno}'
		    },
		    dataType: 'json',
		    success: function(data) {
		        // 기존에 있던 데이터 받아오기
		        console.log('ajax로 받아온 paystub', data);
		        for(var i=0; i<data.length; i++){
		            paystubList.push({
		                empno: data[i].empno,
		                net_pay: data[i].net_pay
		            });
		           
		        }

		    }
		});
		
		
		var sessionCk = "${emem.deptno}"
		if (sessionCk !== "1" && sessionCk !== "10") {
			alert('급여대장 수정은 인사관리자 혹은 총괄관리자만 가능합니다.')
			window.close();
		}

		$("#closeBtn").click(function() {
			if (confirm("급여 명세서 등록을 취소하시겠습니까?\n 등록을 취소하시면 입력한 내용이 초기화됩니다.")) {
				window.close();
			}
		})
		
        for(var i=0; paystubList.length;i++){
        	console.log("기존에 등록된 사원번호:"+paystubList[i])
        }
		
	
		
		$("#schSalary").click(function(){
			var deptno = $("#deptno").val()
			console.log("모달창으로 전달되는 부서번호: "+deptno)
			var payment_dateStr = $("#payment_dateStr").val();
			var dateParts = payment_dateStr.split('-');
			var year = dateParts[0] // 연도
			var month = dateParts[1] // 달
			
		 	$('#dataTable3').DataTable().destroy(); // 테이블 초기화
			
			   $('#dataTable3').DataTable({
			        "paging": true,
			        "searching": false,
			        "ordering": true,
			        "info": true,
			        "pagingType": "full_numbers",
			        "pageLength": 5,
			        "ajax": {
			            "url": "/salaryList",
			            "type": "GET",
			            "data": function() {
			            	  return {
			                      "deptno": deptno,
			                      "year": year,
			                      "month": month
			                  };
			            },
			            "dataType": "json",
			            "dataSrc": "" // 데이터 소스로 사용할 JSON 배열의 위치를 지정
			        },
			        "columns": [
			      
		            { "data": "empno" },         // 두 번째 열: empno
		            { "data": "ename" }, // 3
		            { 
		                "data": "base_salary", // 4
		                "render": $.fn.dataTable.render.number(',', '.', 0),
		                "className": "text-right"
		            },   // 세 번째 열: base_salary
		            { 
		                "data": "allowance", // 5
		                "render": $.fn.dataTable.render.number(',', '.', 0),
		                "className": "text-right"
		            },     // 네 번째 열: allowance
		            { 
		                "data": "deduction",
		                "render": $.fn.dataTable.render.number(',', '.', 0),
		                "className": "text-right"
		            },     
		            { 
		                "data": "net_pay",
		                "render": $.fn.dataTable.render.number(',', '.', 0),
		                "className": "text-right"
		            }, 
		            {
		            	"data": null,
		                "defaultContent": "<button class='btn btn-info' id='regSalBtn'>등록</button>"
		            }
		         
			                    
			        ]
			     
			    });
			
		})
		
		// 등록 버튼 이벤트 처리
	$('#dataTable3 tbody').on('click', '#regSalBtn', function() {
	    console.log("등록된 사원");
	    var row = $(this).closest('tr');
	    var empno = row.find('td:eq(0)').text();
	    var ename = row.find('td:eq(1)').text()
	    var net_pay = row.find('td:eq(5)').text();
	    
	   
	   
	    var html = "";
	    html += "<tr class='table-light text-center'>";
	    html += "<td>" + empno + "</td>";
	    html += "<td>" + ename + "</td>";
	    html += "<td style='text-align: right;'>" + net_pay + "</td>";
	    html += "<td><button type='button' class='btn btn-danger' id='delSalBtn'>제거</button></td>";
	   	if(isExits(empno)){
	   		console.log("새로등록되는 사원번호:"+empno)
	   		alert("이미 선택한 사원의 급여정보가 등록되었습니다.")
	   		
	   	}else{
	    	$("#modalTable").append(html); // 수정된 부분: row 대신에 html을 append
	    	// 배열에도 추가
	    	 paystubList.push({
	 	    	empno : empno,
	 	    	net_pay: net_pay
	 	    })
	 	    
	 	// 02/29 추가된 코드
	 	  var count = $("#size").val();
	    	count ++;
	    	$("#size").val(count);
	    	
	    	var origin_totWithComma = $("#tot_net_pay").val()
        	var origin_tot =  parseInt(origin_totWithComma.replace(/,/g, ''))
        	console.log("추가되는 실수령액: "+net_pay)
        	var plusNet_pay = parseInt(net_pay.replace(/,/g, ''))
        	origin_tot+=plusNet_pay
        	$("#tot_net_pay").val(addCommas(origin_tot))
	   	}
	    
	    
	   
	   
	});
		
		$("#modalTable").on("click", "#delSalBtn", function() {
		    var deleteSal = $(this).closest("tr").find("td:first").text();
		    console.log("삭제하는 연봉 정보:"+deleteSal)
		   
		    
		    
		// 배열에서 일치하는 empno를 찾아 삭제
	    for (var i = 0; i < paystubList.length; i++) {
	        if (paystubList[i].empno === deleteSal) {
	        	
	            console.log("배열의 사이즈: "+paystubList.length)
	            // 02/29 추가된 코드
	            var count = $("#size").val();
	        	count --;
	        	$("#size").val(count)
	        	
	        	var net_pay = paystubList[i].net_pay;
	        	console.log("삭제되는 실수령액: "+net_pay)
	        	var origin_totWithComma = $("#tot_net_pay").val()
	        	var origin_tot = origin_totWithComma.replace(/,/g, '')
	        	if(isNaN(net_pay)){
	        		minus_netpay = net_pay.replace(/,/g, '')
	        		origin_tot -= minus_netpay
	        		$("#tot_net_pay").val(addCommas(origin_tot))
	        	}else{
		        	origin_tot -= net_pay;
		        	$("#tot_net_pay").val(addCommas(origin_tot))
	        	}
	        	
	        	
	        	paystubList.splice(i); // 배열에서 해당 요소 삭제
	            break;
	        }
	    }
		    $(this).closest("tr").remove();
		});
		
		$("#delBtn").click(function(){
			if(confirm("급여장부를 삭제하시겠습니가?\n 삭제를 진행하면 다시 복구할 수 없습니다.")){
				deletePaystub();
			}
		})
		
		$("#uptBtn").click(function() {
		    if (confirm("급여장부를 수정하시겠습니까?")) {
		        $("#frm01 [name='payment_dateStr']").prop('disabled', false);
		        $("#frm01 [name='deptno']").prop('disabled', false);

		        paystubList.forEach(function(salary) {
		            $("#empno").val(salary.empno);
		            $("#net_pay").val(salary.net_pay);
		            // 콤마 제거
		            var net_payWithComma = $("#net_pay").val();
		            var net_pay = net_payWithComma.replace(/,/g, '');
		            $("#net_pay").val(net_pay);

		            $.ajax({
		                url: "${path}/insertPayStub",
		                data: $("#frm01").serialize(),
		                dataType: "json",
		                success: function(data) {
		                    if (data > 0) {
		                        alert("급여 장부 수정 성공");
		                        // 창을 닫음
		                        opener.parent.location='/salaryManage';
		                        window.close();
		                    } else {
		                        alert("급여 장부 수정 실패");
		                    }
		                },
		                error: function(err) {
		                    console.log(err);
		                }
		            });
		        });
		    }
		});
		
	
})
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
	
	// 배열에 존재하는 empno인지 확인하는 함수
	function isExits(empno) {
	    for (var i = 0; i < paystubList.length; i++) {
	        if (paystubList[i].empno === empno) {
	            return true; // 이미 존재하는 empno인 경우 true 반환
	        }
	    }
	    return false; // empno가 존재하지 않는 경우 false 반환
	}
	
	// paystub 삭제 함수
	function deletePaystub(){
		// 비활성화 풀기
		$("#frm01 [name='payment_dateStr']").prop('disabled', false);
		$("#frm01 [name='deptno']").prop('disabled', false);
			$.ajax({
				url:"/deletePaystub",
				dataType:"json",
				data:{
					payment_dateStr:$("#payment_dateStr").val(),
					deptno:$("#deptno").val()
				},
				type:"POST",
				success:function(data){
					if(data>0){
						alert("급여장부 삭제 성공")
						opener.parent.location='/salaryManage';
						window.close()
					
					
					}else{
						alert("급여 정보 삭제 실패")
					}
				},
				error:function(err){
					console.log("급여 삭제 중 에러 발생: "+err)
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
<body id="page-top">
w
	<!-- Page Wrapper -->
	<div id="wrapper">


		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<div class="container-fluid">
					<br>
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">급여대장 상세 페이지</h1>
					</div>
					<div class="card shadow mb-4">
						<div class="card-body">
							<div id="text">
								<form method="post" id="frm01">
									<div class="input-group mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text  justify-content-center">급여대장
												명칭</span>
										</div>
										<c:if test="${not empty paystubList}">
											<input type="text" name="stub_name" id="stub_name" value="${paystubList[0].stub_name}" class="form-control">
										</c:if>
										
									</div>
									<div class="input-group mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text  justify-content-center">급여
												지급일 </span>
										</div>
										<c:if test="${not empty paystubList}">
										<input type="date" name="payment_dateStr" id="payment_dateStr" disabled
											value="<fmt:formatDate value='${paystubList[0].payment_date}' pattern='yyyy-MM-dd'/>"
											class="form-control">
										</c:if>

									</div>
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												부서번호</span>
										</div>
										<select name="deptno" id="deptno" disabled
											class="form-control form-control-user">
											<c:if test="${not empty paystubList}">
												<option>${paystubList[0].deptno}</option>
											</c:if>
											<c:forEach var="dept" items="${dlist}">
												<option value="${dept.deptno}">${dept.dname}[${dept.deptno}]</option>
											</c:forEach>
										</select>
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												인원수</span>
										</div>
								
										<div class="input_value">
											<input class="form-control" type="text" value= "${paystubList[0].count}" readonly id="size" /> 
											<input
												type="button" class="btn btn-dark" value="사원별 급여 조회"
												data-toggle="modal" data-target="#salaryModal" id="schSalary" />
										</div>
									</div>
									<hr>

									<h6 class="h6 mb-0 text-gray-800">등록된 사원별 급여</h6>
									<hr>

									<table class="table table-hover table-striped table-bordered"
										id="regEmp" style="width: 100%;">
										<thead>
											<tr class="table-light text-center">
												<th>사원번호</th>
												<th>사원명</th>
												<!--  <th>직급</th> -->
												<th style="text-align: right;">실수령액</th>
												<th>제거</th>
											</tr>
										</thead>
										<!-- 입력을 위한 input들 -->
										<input type="hidden" name="empno" id="empno">
										<input type="hidden" name="net_pay" id="net_pay">
										<tbody id="modalTable">
											<c:forEach var="stub" items="${paystubList}">
												<tr class="table-light text-center">
													<td>${stub.empno}</td>
													<td>${stub.ename}</td>
													<!-- <td>${stub.job}</td> -->
													<td style="text-align: right;"><fmt:formatNumber value="${stub.net_pay}" pattern="#,##0" /></td>
													<td><button type='button' class='btn btn-danger' id='delSalBtn'>제거</button></td>
												</tr>
											</c:forEach>
										</tbody>
										
									</table>

									<div class="input-group mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text  justify-content-center">총
												금액</span>
										</div>
										
										<input type="text" id="tot_net_pay" value="<fmt:formatNumber value='${paystubList[0].total_net_pay}' pattern="#,##0"/>" class="form-control" readonly>
										

									</div>


									<div style="text-align: right;">
										<input type="button" class="btn btn-warning" value="닫기"
											id="closeBtn" /> 
										<c:if test="${emem.auth eq '인사관리자' || emem.auth eq '총괄관리자'}">
											<input type="button" class="btn btn-info" value="수정" id="uptBtn" />
											<input type="button" class="btn btn-danger" value="삭제" id="delBtn" />
										</c:if>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>

				<!-- /.container-fluid (페이지 내용 종료) -->
			</div>
			<!-- End of Main Content -->
			<!-- 사원별 급여 조회 modal -->
			<div class="modal" id="salaryModal">
				<div class="modal-dialog modal-dialog-centered modal-lg"
					role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">급여정보 등록</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<div class="card shadow mb-4">

								<div class="card-body">

									<div class="table-responsive">
										<table class="table table-bordered" id="dataTable3">
											<thead>
												<tr>
													<th>사원번호</th>
													<th>사원명</th>
													<th>기본급</th>
													<th>수당</th>
													<th>공제</th>
													<th>실수령액</th>
													<th>선택</th>
												</tr>
											</thead>
											<tbody id="tch">
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>
				</div>
			</div>


		
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