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
		var auth = "${emem.auth}";
		var msg = "${msg}"
		if(msg!=""){
			alert(msg)
			location.href="${path}/accList"
		}
		
		$('#accListSch').click(function() {
	        var accCodeInput = $('#acc_codeSch');
	        if (accCodeInput.val().trim() === '') {
	            accCodeInput.val('0'); // 공백일 경우 기본값으로 '0'을 설정
	        }
	        $('#frm01').submit(); // 폼 제출
	    });
		
	    // 페이지 로드 시 이전에 선택된 base_acc 값을 설정
	    var selectedBaseAcc = "${sch.base_acc}"; // 서버 측에서 전달된 base_acc 값
	    if (selectedBaseAcc) {
	        $("select[name='base_acc']").val(selectedBaseAcc);
	    }

	    // 계정과목 성격 select 변경 시 자동 검색
	    $("select[name='base_acc']").change(function() {
	        $("#frm01").submit(); // 폼 제출 (검색 버튼 클릭 효과)
	    });
		
		// 계정과목 등록 버튼 클릭시의 모달창
		$("#regBtn").click(function() {
			if (auth !== "총괄관리자" && auth !== "재무관리자") {
                alert("권한이 없는 이용자입니다.");
            } else {
				$("#frm02")[0].reset();
				// acc_code 필드의 readonly 속성 제거
				$("#frm02 #accCode").prop('readonly', false);
				// readonly 및 비활성화 해제
	            $("#frm02 #accName").prop('readonly', false);
	            $("#frm02 input[name='debit_credit']").prop('disabled', false);
	            $("#frm02 #accType").prop('disabled', false);
	         	
			    // 모달창 보여주기
			    $('#registerModalLabel').text('계정과목 등록').parent().css
			    		({'background-color': '#59eb85', 'color': '#ffffff'});
			    $('#regFrmBtn').show();  // 등록 버튼 보여주기
			    $("#checkDupBtn").show(); // 중복확인 버튼 보여주기
	    		$('#uptBtn').hide();     // 수정 버튼 숨기기
	   			$('#delBtn').hide();     // 삭제 버튼 숨기기
			    $("#registerModal").modal('show');
            }
		});
		
		var isAccCodeChecked = false;  // 중복확인 상태를 추적하는 변수
		// 중복확인 처리..
		$("#checkDupBtn").click(function() {
			var accCode = $("#accCode").val();
		    if (!isNaN(accCode) && accCode.length >= 4 && accCode.length <=5) {
		        $.ajax({
		            url: "${path}/checkAccCodeDuplication",
		            type: "GET",
		            data: { acc_code: accCode },
		            dataType: "json",
		            success: function(response) {
		                console.log(response)
		                if (response.isDuplicate) {
		                    alert("중복된 계정코드가 존재합니다.");
		                } else {
		                    alert("사용 가능한 계정코드입니다.");
		                    $("#accCode").prop('readonly', true);
		                    isAccCodeChecked = true;
		                }
		            },
		            error: function() {
		                alert("오류가 발생했습니다.");
		            }
		        });
		    } else {
		        alert('계정코드는 4~5자리의 숫자형이어야 합니다.');
		        $("#accCode").val("").focus();
		    }
		});
		
		// 모달창 종료시, 중복확인처리 했던거 무효
		$('#registerModal').on('hidden.bs.modal', function () {
		    isAccCodeChecked = false;
		});
		
		// 모달창 내부 등록버튼 클릭시
		$("#regFrmBtn").click(function(){
			if (!isAccCodeChecked) {
		        alert("중복확인이 필요합니다.");
		        return;
		    }
			var form = $("#frm02");
			form.attr("action", "${path}/insertAccsub");
			
			if($("#frm02 [name=acc_code]").val()==""){
				alert("과목코드를 입력하세요")
				return;
			}
			if($("#frm02 [name=acc_name]").val()==""){
				alert("과목명을 입력하세요")
				return;
			}
			if($("#frm02 [name=debit_credit]").val()==""){
				alert("대차구분을 선택하세요")
				return;
			}
			if(confirm("등록하시겠습니까?")){
				form.submit()				
			}
		})
		
		// 수정버튼 클릭시 
		$("#uptBtn").click(function(){
			if (auth !== "총괄관리자" && auth !== "재무관리자") {
                alert("권한이 없는 이용자입니다.");
            } else {
				var accCode = $("#frm02 #accCode").val();
				var formData = $("#frm02").serialize();
				
				console.log(formData)
				// '기준' 계정과목의 경우, 비활성화된 필드 값 추가
			    if (window.currentAccBaseAcc === '기준') {
			        formData += '&debit_credit=' + $("#frm02 input[name='debit_credit']:checked").val();
			        formData += '&acc_type=' + $("#frm02 #accType").val();
			    }
				
				$.ajax({
					url: "${path}/updateAccsub",
					type: "post",
					data: formData,
					dataType: "json",
					success: function(response){
						var updatedData = response.accsub;
						alert(response.msg); // 성공메세지
						location.reload(); // 페이지 새로고침
					},
					error: function(err){
						console.log(err)
						console.log(err.status)
						alert("수정실패")
					}
				})
            }
		})
		
		// 삭제버튼 클릭시
		$("#delBtn").click(function() {
			if (auth !== "총괄관리자" && auth !== "재무관리자") {
                alert("권한이 없는 이용자입니다.");
            } else {
				if (window.currentAccBaseAcc === '기준') {
			        alert("기준 계정과목은 삭제할 수 없습니다.");
			        return;
			    }
			    var accCode = $("#frm02 #accCode").val();
			    if(confirm('정말 삭제하시겠습니까?')) {
			        $.ajax({
			            url: '${path}/deleteAccsub',
			            type: 'post',
			            data: {'acc_code': accCode},
			            dataType: "json",
			            success: function(response) {
			                alert(response.msg); // 성공 메시지
			                location.reload(); // 페이지 새로고침
			            },
			            error: function() {
			                alert('삭제 실패');
			            }
			        });
			    }
            	
            }
			
		});
		
		
	}); // document(ready) 끝
	
	// 상세정보 불러오는 함수 
	function detailAcc(accCode){
	
		$.ajax({
			url:'${path}/accsubDetail',
			type:'get',
			data:{'acc_code':accCode},
			dataType:"json",
			success:function(data){
				// 모달 창에 데이터 채워넣기
				var accsub = data.accsub;
				console.log(accsub)
            	
            	// 불러온 데이터 모달창에 채우기
				$("#frm02 #accCode").val(accsub.acc_code);
				$("#frm02 #accName").val(accsub.acc_name);
				$("#frm02 input[name='debit_credit'][value='"+accsub.debit_credit+"']").prop('checked',true);
				$("#frm02 #accType").val(accsub.acc_type);
				$("#frm02 input[name='active_status'][value='"+accsub.active_status+"']").prop('checked',true);
				$("#frm02 #remarks").val(accsub.remarks);
				
				window.currentAccBaseAcc = accsub.base_acc; // base_acc 값을 전역 변수에 저장
				if (accsub.base_acc === '기준') {
	                // '기준'인 경우 일부 필드만 활성화
	                $("#frm02 #accName").prop('readonly', true);
	            	// 라디오 버튼 비활성화
	                $("#frm02 input[name='debit_credit']").prop('disabled', true);
	             	// 셀렉트 박스 비활성화
	                $("#frm02 #accType").prop('disabled', true);
	            } else {
	                // '기준'이 아닌 경우 모든 필드 활성화
	                $("#frm02 input, #frm02 select").prop('readonly', false);
	            }
				
				// 계정코드 수정할 수 없게(primary key임)
				$("#frm02 #accCode").prop('readonly', true);
				// 모달창 보여주는 부분
				$('#registerModalLabel').text('계정과목 수정/삭제').parent().css
						({'background-color': '#4a5ba3', 'color': '#ffffff'});
				$('#regFrmBtn').hide();  // 등록 버튼 숨기기
				$("#checkDupBtn").hide(); // 중복확인 버튼 숨기기
			    $('#uptBtn').show();     // 수정 버튼 보여주기
			    $('#delBtn').show();     // 삭제 버튼 보여주기
				$("#registerModal").modal('show');
			},
			error:function(err){
				console.log(err)
				alert('상세정보를 가져오는 데 실패했습니다.');
			}
		})
	}
</script>
	<!-- DB테이블 플러그인 추가 -->
    <link rel="stylesheet" href="${path}/a00_com/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="${path}/a00_com/vendor/datatables/dataTables.bootstrap4.css">
    <link rel="stylesheet" type="text/css" href="${path}/a00_com/js/select.dataTables.min.css">
     <!-- Custom fonts for this template-->
    <link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <!-- 
    기존 font
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
	
    <!-- Custom styles for this template-->
    <link href="${path}/a00_com/css/sb-admin-2.min.css" rel="stylesheet">
    <link href="${path}/a00_com/css/custom-style.css" rel="stylesheet">
</head>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="/WEB-INF/views/a00_module/a02_sliderBar.jsp" %>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">
				<!-- Topbar  -->
				<%@ include file="/WEB-INF/views/a00_module/a03_topBar.jsp" %> 
				<!-- End of Topbar -->
				<!-- Begin Page Content (여기서부터 페이지 내용 입력) -->
				<div class="container-fluid">
					<!-- Page Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">☆ 계정과목 리스트</h1>
					</div>
					<!-- 테이블 -->
					<div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">계정과목 조회</h6>
                            <hr>
		                    <form id="frm01" class="form"  method="post">
								<input type="hidden" name="curPage" value="${sch.curPage}">
						  	<nav class="navbar navbar-expand-sm navbar-light bg-light">
							    <input type="number" placeholder="계정코드 입력" id="acc_codeSch" name="acc_code" value="${sch.acc_code}" class="form-control mr-sm-2" />
							    <input placeholder="계정과목명 입력" name="acc_name" value="${sch.acc_name}" class="form-control mr-sm-2" />
							    <!--  <input placeholder="계정종류 입력" name="acc_type" value="${sch.acc_type}" class="form-control mr-sm-2" /> -->
							     <!-- 계정종류 드롭다운 메뉴 -->
				                <select name="acc_type" class="form-control mr-sm-2">
				                    <option value="">계정분류</option>
				                    <option value="자산" ${sch.acc_type == '자산' ? 'selected' : ''}>자산</option>
				                    <option value="자본" ${sch.acc_type == '자본' ? 'selected' : ''}>자본</option>
				                    <option value="부채" ${sch.acc_type == '부채' ? 'selected' : ''}>부채</option>
				                    <option value="손익" ${sch.acc_type == '손익' ? 'selected' : ''}>손익</option>
				                    <option value="원가" ${sch.acc_type == '원가' ? 'selected' : ''}>원가</option>
				                </select>
							    <select name="base_acc" class="form-control">
								    <option value="">전체</option>
								    <option value="기준">기준</option>
								    <option value="추가">추가</option>
								</select>
							    <button class="btn btn-info" type="button" id="accListSch">Search</button>
						 	</nav>
						 	<div class="input-group mt-3 mb-0">	
								<span class="input-group-text">총 : ${sch.count}건</span>
								<button type="button" id="regBtn" class="btn btn-success">
								계정과목등록
								</button>
								<input type="text" class="form-control" style="width:50%;" readonly>
								<span class="input-group-text">페이지수</span>
								<select name="pageSize" class="form-control">
									<option>5</option>
									<option>10</option>
									<option>20</option>
									<option>50</option>
								</select>
							</div>	
							<script type="text/javascript">
								// 선택된 페이지 사이즈를 다음 호출된 페이지에서 출력
								$("[name=pageSize]").val("${sch.pageSize}")
								// 페이지를 변경했을 때, 선택된 페이지를 초기페이지로 설정..
								$("[name=pageSize]").change(function(){
									$("[name=curPage]").val(1)
									$("#frm01").submit()
								})
							</script>
							</form>
                        </div>
                        <div class="card-body">
                        	<span>테이블의 행을 더블클릭시, 수정 및 삭제가 가능합니다.</span>
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable">
                                    <thead>
                                        <tr>
                                            <th>계정코드</th>
                                            <th>계정과목명</th>
                                            <th>대차구분</th>
                                            <th>계정종류</th>
                                            <th>사용구분</th>
                                            <th>적요</th>
                                            <th>설정</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="acc" items="${accList}">
                                        <tr ondblclick="detailAcc('${acc.acc_code}')">
                                            <td>${acc.acc_code}</td>
                                            <td>${acc.acc_name}</td>
                                            <td>${acc.debit_credit == 'D' ? '차변' : '대변'}</td>
                                            <td>${acc.acc_type}</td>
                                            <td>${acc.active_status}</td>
                                            <td>${acc.remarks}</td>
                                            <td>${acc.base_acc}</td>
                                        </tr>
                                    	</c:forEach>
                                    </tbody>
                                </table>
                                
                                <ul class="pagination justify-content-center">
								  <li class="page-item">
								  <a class="page-link" 
								  	href="javascript:goPage(${sch.startBlock-1})">Previous</a></li>
								  	
								  <c:forEach var="pcnt" begin="${sch.startBlock}" 
								  						end="${sch.endBlock}">
								  <li class="page-item ${sch.curPage==pcnt?'active':''}">
								  	<a class="page-link" href="javascript:goPage(${pcnt})">${pcnt}</a></li>
								  </c:forEach>
								  
								  <li class="page-item">
								  <a class="page-link"
								   href="javascript:goPage(${sch.endBlock+1})">Next</a></li>
								</ul>
								<script type="text/javascript">
									function goPage(pcnt){
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
						<span>Copyright &copy; Orbit ERP presented by TEAM FOUR</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->
	
<!-- 모달 창 -->
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="registerModalLabel">계정과목 등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="frm02" method="POST">
				    <!-- 계정코드 입력 -->
				    <div class="form-group">
				        <label for="accCode">계정코드</label>
				        <input type="number" class="form-control" id="accCode" name="acc_code" required>
				        <button type="button" id="checkDupBtn" class="btn btn-info">중복확인</button>
				    </div>
				    
				    <!-- 계정과목명 입력 -->
				    <div class="form-group">
				        <label for="accName">계정과목명</label>
				        <input type="text" class="form-control" id="accName" name="acc_name" required>
				    </div>
				
				    <!-- 대차구분 선택 (라디오 버튼) -->
				    <div class="form-group">
				        <label>대차구분</label>
				        <div>
				            <input type="radio" id="debit" name="debit_credit" value="D" checked>
				            <label for="debit">차변</label>
				        </div>
				        <div>
				            <input type="radio" id="credit" name="debit_credit" value="C">
				            <label for="credit">대변</label>
				        </div>
				    </div>
				
				    <!-- 계정종류 선택 (드롭다운) -->
				    <div class="form-group">
				        <label for="accType">계정종류</label>
				        <select class="form-control" id="accType" name="acc_type">
				            <option value="자산">자산</option>
				            <option value="부채">부채</option>
				            <option value="자본">자본</option>
				            <option value="손익">손익</option>
				        </select>
				    </div>
					<!--계정 활성화 여부 -->
					<div class="form-group">
				        <label>계정 활성화 상태:</label>
				        <div class="form-check">
				            <input class="form-check-input" type="radio" name="active_status" id="activeYes" value="Y" >
				            <label class="form-check-label" for="activeYes">
				                활성화
				            </label>
				        </div>
				        <div class="form-check">
				            <input class="form-check-input" type="radio" name="active_status" id="activeNo" value="N" checked>
				            <label class="form-check-label" for="activeNo">
				                비활성화
				            </label>
				        </div>
				    </div>
				    <!-- 적요 입력 -->
				    <div class="form-group">
				        <label for="remarks">적요</label>
				        <input type="text" class="form-control underlined-input" id="remarks" name="remarks" placeholder="적요를 입력하세요">
				    </div>
				</form>
            </div>
            <hr style="border-color: #46bcf2;">
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <span class="mx-auto">
                	<button type="button" id="delBtn"class="btn btn-danger" data-dismiss="modal">삭제</button>
                </span>
                <button type="button" id="uptBtn" class="btn btn-success" data-dismiss="modal">수정</button>
                <button type="button" id="regFrmBtn" form="registerForm" class="btn btn-primary">등록</button>
            </div>
        </div>
    </div>
</div>
<!-- 모달창 종료 -->	

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> 
		<i class="fas fa-angle-up"></i>
	</a>
	<!-- Logout Modal-->
	<%@ include file="/WEB-INF/views/a00_module/a08_logout_modal.jsp" %>
<!-- Bootstrap core JavaScript-->
    <script src="${path}/a00_com/vendor/jquery/jquery.min.js"></script>
<script src="${path}/a00_com/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="${path}/a00_com/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${path}/a00_com/js/sb-admin-2.min.js"></script>
<!-- 추가 plugins:js -->
<script src="${path}/a00_com/vendor/datatables/jquery.dataTables.js"></script>
<script src="${path}/a00_com/vendor/datatables/dataTables.bootstrap4.js"></script>
<script src="${path}/a00_com/js/dataTables.select.min.js"></script>

</body>
</html>