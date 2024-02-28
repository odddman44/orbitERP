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
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="${path}/a00_com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	var deptAuth = parseInt("${emem.deptno}");
	console.log(deptAuth);
	
	$(document).ready(function() {
		$('.modal-dialog').css('max-width', '70%');
	   	$('#dataTable').DataTable({
	            "paging": true,
	            "searching": true,
	            "ordering": true,
	            "info": true,
	            "pagingType": "full_numbers",
	            "pageLength": 10
	    });
	   	
		$("#schBtn").click(function(){
			$("#frm01").submit();
		})
		
		
		// 전표유형 select시 자동 제출
		$("#selectSch").change(function() {
			$("#schBtn").click();
		})
		// 선택된 전표 유형값을 저장
        var selectedValue = "${selectedType}";
        if(selectedValue){
        	$("#selectSch").val(selectedValue);
        }
		
		// 전표 '신규' 버튼 클릭시의 모달창
		$("#newBtn").click(function() {
			 if (deptAuth !== 1 && deptAuth !== 20) {
			        alert("권한이 없는 이용자입니다.");
			    } else {
			        console.log("신규 버튼 클릭 - 모달창 열림");
			        openNewVoucherModal()
			        // 모달창 제목 변경
			        $('#registerModalLabel').text('신규 전표 등록').parent().css
					({'background-color': '#2ECDCD', 'color': '#ffffff'});
			        $('#regFrmBtn').show();  // 등록 버튼 보이기
			        $('#addRowBtn').show();  // 행 추가 버튼 숨기기
		            $('#delRowBtn').show();  // 행 삭제 버튼 숨기기
			        $('#uptBtn').hide();     // 수정 버튼 숨기기
			    }
		});
		
		// '추가' 버튼 클릭 이벤트
	    $("#addRowBtn").click(function() {
	    	console.log("추가 버튼 클릭 - 새 행 추가");
	        addNewRowToModalTable();
	    });
		 // '행 제거' 버튼 클릭 이벤트
	    $("#delRowBtn").click(function() {
	        console.log("행 제거 버튼 클릭 - 마지막 행 제거");
	        $("#modalTable tr:last").remove(); // 모달 테이블의 마지막 행을 제거
	    });
		
	 	// 신규 모달창 열기 함수
	    function openNewVoucherModal() {
	        $("#frm02")[0].reset();
	        var defaultRow = createNewRow();
	        $("#modalTable").html(defaultRow);
	        $('#registerModal').modal('show');
	    }
		// 새로운 행 생성 함수
	    function createNewRow() {
	        var newRow = '<tr class="text-center">' +
	            '<td><input type="number" class="form-control" name="acc_code" placeholder="클릭하여 선택.."></td>' +
	            '<td><input type="text" class="form-control" name="debit_amount" style="text-align:right;"></td>' +
	            '<td><input type="text" class="form-control acc-name" readonly></td>' +
	            '<td><input type="text" class="form-control" name="credit_amount" style="text-align:right;"></td>' +
	            '<td><input type="text" class="form-control" name="trans_name"></td>' +
	            '<td><input type="text" class="form-control" name="j_remark"></td>' +
	            '</tr>';
	        return newRow;
	    }
	 	// 모달 테이블에 새로운 행 추가 함수
	    function addNewRowToModalTable() {
	        var newRow = createNewRow();
	        $("#modalTable").append(newRow);
	    }
		
	    // '등록' 버튼 클릭 이벤트(폼 제출1)
	    $("#regFrmBtn").click(function() {
	    	// 콤마 제거
	        $('input[name="debit_amount"], input[name="credit_amount"]').each(function() {
	            $(this).val($(this).val().replace(/,/g, ''));
	        });
	    	
	    	var formData = {};
	        var journalizings = [];
	        console.log("전송 Data: ", formData); // 전송 데이터 확인
	    	var isValid = true;
	    	var totalDebit = 0, totalCredit = 0;
	    	// 각 행의 차변과 대변 금액 합계 계산
	        $('#modalTable tr').each(function() {
	        	var acc_code = $(this).find('input[name="acc_code"]').val();
	            var debit = $(this).find('input[name="debit_amount"]').val() || 0;
	            var credit = $(this).find('input[name="credit_amount"]').val() || 0;
	            
	        	 // 계정 코드 유효성 검사
		        if (!acc_code) {
		            alert("계정 코드를 입력해주세요.");
		            isValid = false;
		            return false; // each 반복 중단
		        }
		    	 
		     	// 차변과 대변 금액 유효성 검사
		        if (parseFloat(debit) <= 0 && parseFloat(credit) <= 0) {
		            alert("차변 혹은 대변에 적절한 금액을 입력해주세요.");
		            isValid = false;
		            return false; // each 반복 중단
		        }
	            
	            // 합계 계산
	            totalDebit += parseFloat(debit);
	            totalCredit += parseFloat(credit);
	            
	        	// 분개 데이터 추가
	            if(acc_code) {
	                journalizings.push({
	                    acc_code: acc_code,
	                    debit_amount: debit,
	                    credit_amount: credit,
	                    trans_name: $(this).find('input[name="trans_name"]').val(),
	                    j_remark: $(this).find('input[name="j_remark"]').val()
	                });
	            }
	        });
	    	
	     	// 합계 일치 여부 확인
	        if (totalDebit !== totalCredit) {
	            alert("차변과 대변의 합계가 일치하지 않습니다.");
	            return; // 함수 종료
	        }
	     	// 필수 입력란 검증
	        if (journalizings.length === 0 || !isValid) {
	            alert("모든 필수 항목을 입력해야 합니다.");
	            return;
	        }
	     	// 전표 정보 수집
	     	formData['voucher_dateStr']=$('#voucher_date').val();
	     	formData['voucher_no']=$('#voucher_no').val();
	     	formData['voucher_type']=$('#voucherType').val();
	     	formData['trans_cname']=$('#trans_cname').val();
	     	formData['deptno']=$('#deptno').val();
	     	formData['remarks']=$('#remarks').val();
	     	formData['total_amount'] = totalDebit;
	     	formData['journalizings'] = journalizings;
	     	
	     	console.log("Final Data to Send: ", formData);
	    	// 등록 로직
	        $.ajax({
	            url: "${path}/insertVoucher",
	            method: "POST",
	            data: JSON.stringify(formData),
	            contentType: 'application/json',
	            dataType :"json",
	            success: function(response) {
	                if(response.status ==="success"){
	                	alert("전표 등록이 완료되었습니다.");
	                	$('#registerModal').modal('hide'); // 모달창 닫기
	                    location.reload(); // 페이지 새로고침
	                }else{
	                	alert("전표 등록 실패:"+response.message)
	                }
	            },
	            error: function(err) {
	                console.log(err)
	                console.log(err.responseText)
	                alert("전표 등록 중 오류가 발생하였습니다.");
	            }
	        });

	    });

	    // 수정 버튼 클릭 이벤트 (폼 제출2)
	    $("#uptBtn").click(function() {
	    	// 콤마 제거
	        $('input[name="debit_amount"], input[name="credit_amount"]').each(function() {
	            $(this).val($(this).val().replace(/,/g, ''));
	        });
	    	
	    	var formData = {};
	        var journalizings = [];
	        var isValid = true;
	        var totalDebit = 0, totalCredit = 0;

	        $('#modalTable tr').each(function() {
	            var acc_code = $(this).find('input[name="acc_code"]').val();
	            var debit = $(this).find('input[name="debit_amount"]').val() || 0;
	            var credit = $(this).find('input[name="credit_amount"]').val() || 0;
	            var journal_id = $(this).find('input[name="journal_id"]').val(); // 분개 데이터의 식별자

	            totalDebit += parseFloat(debit);
	            totalCredit += parseFloat(credit);

	            if(acc_code) {
	                journalizings.push({
	                    journal_id: journal_id,
	                    acc_code: acc_code,
	                    debit_amount: debit,
	                    credit_amount: credit,
	                    trans_name: $(this).find('input[name="trans_name"]').val(),
	                    j_remark: $(this).find('input[name="j_remark"]').val()
	                });
	            }
	        });

	        if (totalDebit !== totalCredit) {
	            alert("차변과 대변의 합계가 일치하지 않습니다.");
	            return;
	        }

	        if (journalizings.length === 0 || !isValid) {
	            alert("모든 필수 항목을 입력해야 합니다.");
	            return;
	        }

	        formData['voucher_id'] = $('#voucher_id').val(); // 전표의 식별자
	        formData['voucher_dateStr'] = $('#voucher_date').val();
	        formData['voucher_no'] = $('#voucher_no').val();
	        formData['voucher_type'] = $('#voucherType').val();
	        formData['trans_cname'] = $('#trans_cname').val();
	        formData['deptno'] = $('#deptno').val();
	        formData['remarks'] = $('#remarks').val();
	        formData['total_amount'] = totalDebit;
	        formData['journalizings'] = journalizings;

	        console.log("Final Data to Send: ", formData);
	        
	        $.ajax({
	            url: "${path}/updateVoucher",
	            method: "POST",
	            data: JSON.stringify(formData),
	            contentType: 'application/json',
	            dataType: "json",
	            success: function(response) {
	                if (response.status === "success") {
	                    alert("전표 및 분개 수정이 완료되었습니다.");
	                    $('#registerModal').modal('hide'); // 모달창 닫기
	                    location.reload(); // 페이지 새로고침
	                } else {
	                    alert("전표 및 분개 수정 실패: " + response.message);
	                }
	            },
	            error: function(err) {
	                alert("전표 및 분개 수정 중 오류가 발생하였습니다.");
	                console.log(err);
	            }
	        });
	    });
	    
		// 전체 선택/해제
	    $("#selectAll").click(function() {
	        $(".selectRow").prop('checked', $(this).prop('checked'));
	    }); 
		// '선택삭제' 버튼 클릭 이벤트 (폼제출3)
	    $("#delBtn").click(function() {
	    	if (deptAuth !== 1 && deptAuth !== 20) {
	            alert("권한이 없는 이용자입니다.");
	        } else {
	            // 선택삭제 로직
		        var selectedIds = $(".selectRow:checked").map(function() {
		            return $(this).val();
		        }).get();
	
		        if (selectedIds.length === 0) {
		            alert("삭제할 전표를 선택하세요.");
		            return;
		        }
		     	// 사용자에게 삭제 확인 요청
		        var confirmDelete = confirm("선택한 전표를 삭제하시겠습니까?");
		        if (!confirmDelete) {
		            return; // 함수 종료, 삭제 요청 중단
		        }
	
		        // AJAX 요청으로 백엔드에 삭제 요청
		        $.ajax({
		            url: '${path}/deleteVouchers', // 백엔드 URL 변경 필요
		            method: 'POST',
		            contentType: 'application/json', // 서버로 전송할 데이터의 MIME 타입 지정
		            data: JSON.stringify(selectedIds), // JavaScript 객체나 배열을 JSON 문자열로 변환
		            success: function(response) {
		                if(response.status === "success") {
		                    alert("선택한 전표가 삭제되었습니다.");
		                    location.reload(); // 성공 시 페이지 새로고침
		                } else {
		                    alert("삭제 실패: " + response.message);
		                }
		            },
		            error: function(xhr, status, err) {
		                alert("삭제 중 오류 발생");
		                console.error("Error: ", status, err);
		            }
		        });
	        }
	        
	    });
		
		// 숫자 입력 필드에 대해 키 입력 시 콤마 처리
	    $('#modalTable').on('input', 'input[name="debit_amount"], input[name="credit_amount"]', function() {
	        var input = $(this).val().replace(/,/g, ''); // 먼저 콤마를 제거
	        if (!isNaN(input) && input) { // 입력 값이 숫자인 경우
	            $(this).val(addCommas(input)); // 콤마 추가
	        }
	    });

	}); // $(document).ready 끝
	
	// 날짜 형식 포맷
	function formatDate(timestamp){
		var date = new Date(timestamp);
		var year = date.getFullYear();
		var month = ('0'+(date.getMonth() + 1)).slice(-2);
		var day = ('0' + date.getDate()).slice(-2);
		return year+'-'+month+'-'+day;
	}
	
	// 상세조회
	function detailVC(voucher_id) {
		console.log("상세 조회 - 모달창 열림");
		console.log(voucher_id)
	    $.ajax({
	        url: '${path}/getVoucherDetail', 
	        method: 'GET',
	        data: {'voucher_id': voucher_id},
	        dataType: 'json',
	        success: function(data) {
	            var voucher = data.voucherDetail;
	            console.log(voucher) 
	            $('#frm02 #voucher_id').val(voucher.voucher_id);
	            $('#frm02 #voucher_date').val(formatDate(voucher.voucher_date));
	            $('#frm02 #voucher_no').val(voucher.voucher_no);
	            $('#frm02 #voucherType').val(voucher.voucher_type);
	            $('#frm02 #trans_cname').val(voucher.trans_cname);
	            $('#frm02 #deptno').val(voucher.deptno);
	            $('#frm02 #remarks').val(voucher.remarks);
	            
	            var journalizings = voucher.journalizings;
	            var tbody = $('#modalTable').empty(); // 테이블 초기화
	            journalizings.forEach(function(journal) {
	            	// null 값 공백 문자열로 처리
	                var trans_name = journal.trans_name ? journal.trans_name : "";
	                var j_remark = journal.j_remark ? journal.j_remark : "";
	                // 천단위 콤마 추가
	                var debitWithCommas = addCommas(journal.debit_amount);
                	var creditWithCommas = addCommas(journal.credit_amount);
	            	
	                var row = '<tr class="text-center">' +
	                    '<td><input type="hidden" name="journal_id" value="'+journal.journal_id+'"/>'+
	                	'<input type="number" class="form-control" name="acc_code" value="' + journal.acc_code + '"></td>' +
	                    '<td><input type="text" class="form-control" style="text-align:right;" name="debit_amount" value="' + debitWithCommas + '"></td>' +
	                    '<td><input type="text" class="form-control acc-name" value="' + journal.acc_name + '" readonly></td>' +
	                    '<td><input type="text" class="form-control" style="text-align:right;" name="credit_amount" value="' + creditWithCommas + '"></td>' +
	                    '<td><input type="text" class="form-control" name="trans_name" value="' + trans_name + '"></td>' +
	                    '<td><input type="text" class="form-control" name="j_remark" value="' + j_remark + '"></td>' +
	                    '</tr>';
	                tbody.append(row);
	            });
	            // 모달창 제목 변경
	            $('#registerModalLabel').text('전표 수정').parent().css
				({'background-color': '#868a83', 'color': '#ffffff'});
	            $('#regFrmBtn').hide();  // 등록 버튼 숨기기
	            $('#addRowBtn').hide();  // 행 추가 버튼 숨기기
	            $('#delRowBtn').hide();  // 행 삭제 버튼 숨기기
	         	// 권한에 따른 수정 버튼 활성화/비활성화
	            if (deptAuth !== 1 && deptAuth !== 20) {
	                $('#uptBtn').hide(); // 수정 버튼 숨기기
	            } else {
	                $('#uptBtn').show(); // 수정 버튼 보여주기
	            }
	            $('#registerModal').modal('show');
	        },
	        error: function(err) {
	            console.error('데이터 가져오기 오류: ', err);
	        }
	    });
	}
	
	// 차변과 대변 입력란에 이벤트 핸들러 추가
	$(document).on('keyup', 'input[name="debit_amount"], input[name="credit_amount"]', function() {
	    var $row = $(this).closest('tr');
	    var $debitInput = $row.find('input[name="debit_amount"]');
	    var $creditInput = $row.find('input[name="credit_amount"]');

	    // 입력 값이 있을 때, 다른 필드를 readonly로 설정
	    if ($debitInput.val()) {
	        $creditInput.prop('readonly', true).val(''); // 대변 필드를 readonly로 설정하고 값을 비웁니다.
	    } else if ($creditInput.val()) {
	        $debitInput.prop('readonly', true).val(''); // 차변 필드를 readonly로 설정하고 값을 비웁니다.
	    } else {
	        // 두 필드 모두 비어있을 때, readonly 해제
	        $debitInput.prop('readonly', false);
	        $creditInput.prop('readonly', false);
	    }
	});
	
	// 숫자에 콤마를 추가하는 함수
    function addCommas(nStr) {
    	nStr = parseFloat(nStr); // 입력 값을 숫자로 변환
        if (nStr === 0) { // 값이 0인 경우 공백 반환
            return "";
        }
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
 	// 콤마 제거하기
    function removeComma() {
        $('input[name="debit_amount"], input[name="credit_amount"]').each(function() {
            var valueWithCommas = $(this).val();
            var valueWithoutCommas = valueWithCommas.replace(/,/g, '');
            $(this).val(valueWithoutCommas);
        });
    }
 	// 다운로드
    function downloadVoucherDetail(voucherId) {
	    Swal.fire({
	        title: '다운로드 확인',
	        text: "해당 전표를 다운로드 하시겠습니까?",
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        confirmButtonText: '다운로드',
	        cancelButtonText: '취소'
	    }).then((result) => {
	    	if (result.isConfirmed) {
	            // 다운로드 URL로 이동
	            window.location.href = "${path}/downloadExcel?voucher_id=" + voucherId;
	            // 다운로드 시작 알림
	            Swal.fire({
	                title: '다운로드 완료!',
	                text: voucherId + '번 전표를 다운로드했습니다..!',
	                icon: 'success',
	                timer: 3000, // 알림이 3초 후에 자동으로 닫히도록 설정
	                timerProgressBar: true, // 타이머 진행 상태를 보여주는 프로그레스 바
	                showConfirmButton: false // 확인 버튼 없이 타이머로 자동 닫힘
	            });
	        }
	    });
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
						<h1 class="h3 mb-0 text-gray-800">※ 전표 조회</h1>
					</div>
					<!-- 테이블 -->
					<div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">날짜로 전표 조회</h6>
                            <form id="frm01" class="form"  method="POST">
	                            <div class="form-row align-items-center">
	                            	<div class="col-auto">
		                            	시작날짜 : <input type="date" name="startDate" value="${selectedStartDate}"/>~
		                            </div>
		                            <div class="col-auto">
										마지막날짜 :<input type="date" name="endDate"  value="${selectedEndDate}"/>
									</div>
									<div class="col-auto">
		                            	<button type="button" id="schBtn" class="btn btn-secondary">검색</button>
		                            </div>
								</div>
								<br>
									<h6 class="m-0 font-weight-bold text-secondary">전표유형으로 조회</h6>
								<div class="form-row align-items-center">
									<div class="col-auto">
										<select name="voucher_type" id="selectSch" class="form-control">
										    <option value="">전체</option>
										    <option value="일반전표">일반전표</option>
										    <option value="매출전표">매출전표</option>
										    <option value="매입전표">매입전표</option>
										</select>
									</div>
		                        </div>
	                            <div style="text-align:right;">
	                            	<button type="button" id="newBtn" class="btn btn-primary btn-icon-split">
	                            	<span class="icon text-white-50"><i class="fas fa-check"></i></span>
	                            	<span class="text">신규</span></button>
	                            </div>
	                        </form>
                        </div>
                        <div class="card-body">
                        	<span>테이블의 행을 더블클릭시, 전표 상세정보를 볼 수 있습니다.</span>
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable">
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox" id="selectAll"></th>
                                            <th>전표번호</th>
                                            <th>전표유형</th>
                                            <th>금액</th>
                                            <th>거래(처)명</th>
                                            <th>적요</th>
                                            <th>부서</th>
                                            <th>전표</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="vc" items="${vlist}">
                                        <tr ondblclick="detailVC('${vc.voucher_id}')">
                                        	<td><input type="checkbox" class="selectRow" value="${vc.voucher_id}"></td>
                                            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${vc.voucher_date}"/>/${vc.voucher_no}</td>
                                            <td>${vc.voucher_type}</td>
                                            <td style="text-align:right;"><fmt:formatNumber value="${vc.total_amount}" groupingUsed="true" maxFractionDigits="0" /></td>
                                            <td>${vc.trans_cname}</td>
                                            <td>${vc.remarks}</td>
                                            <td>${vc.dname}</td>
                                            <td><button type="button" id="downloadBtn" class="btn btn-warning btn-icon-split"
                                            	onclick="downloadVoucherDetail('${vc.voucher_id}')">
				                            	<span class="icon text-white-50"><i class="fas fa-download"></i></span>
				                            	<span class="text">다운로드</span></button></td>
                                        </tr>
                                    	</c:forEach>
                                    </tbody>
                                </table>
                                <button type="button" id="delBtn" class="btn btn-danger btn-icon-split">
                                <span class="icon text-white-50"><i class="fas fa-trash"></i></span>
                                        <span class="text">선택삭제</span></button>
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
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="registerModalLabel">전표 등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="frm02" method="POST" class="text-left">
				    <div class="form-group row">
				    	<div class="col-md-4">
					    <!-- 전표일자 입력 -->
					        <label for="voucerDate">전표일자</label>
					        <input type="date" class="form-control" id="voucher_date" name="voucher_dateStr" required/>
					    <!-- 거래처명 표시 -->
					        <label for="accCode">거래처명</label>
					        <input type="text" class="form-control" id="trans_cname" name="trans_cname" placeholder="거래(처)명 입력.." required>
				        </div>
						<div class="col-md-4">
						<!-- 전표번호 입력 -->
					        <label for="voucherNo">전표번호</label>
					        <input type="number" class="form-control" id="voucher_no" name="voucher_no" placeholder="전표 No. 입력" required>
					    <!-- 부서명 표시 -->
					        <label for="accName">부서명</label>
					        <select id="deptno" name="deptno" class="form-control">
					        	<c:forEach var="dept" items="${dlist}">
					        		<option value="${dept.deptno}">${dept.dname}[${dept.deptno}]</option>
					        	</c:forEach>
					        </select>
				        </div>
						<div class="col-md-4">
					    <!-- 전표유형 선택 -->
					        <label for="voucherType">전표 유형</label>
					        <select id="voucherType" name="voucher_type" class="form-control">
					        	<option value="일반전표">일반전표</option>
					        	<option value="매출전표">매출전표</option>
					        	<option value="매입전표">매입전표</option>
					        </select>
				        </div>
				    </div>
				    <!-- 적요 입력/숨은 총계창 -->
				    <div class="form-group">
					    <label for="remarks">적요</label>
					    <input type="text" class="form-control underlined-input" id="remarks" name="remarks" placeholder="적요를 입력하세요">
					    <input type="hidden" id="total_amount" name="total_amount"/>
					    <input type="hidden" id="voucher_id" name="voucher_id"/>
				    </div>
				    <hr>
				    <h5>분개 상세 입력</h5>
				    <!-- 테이블 행 추가/제거 버튼 -->
				    <div style="text-align:right;">
                   		<button type="button" id="addRowBtn" class="btn btn-success btn-icon-split">
                   		<span class="icon text-white-50"><i class="fas fa-plus"></i></span>
	                            	<span class="text">행 추가</span></button>
                   		<button type="button" id="delRowBtn" class="btn btn-secondary btn-icon-split">
                   		<span class="icon text-white-50"><i class="fas fa-minus"></i></span>
	                            	<span class="text">행 제거</span></button>
                    </div>
                    <br>
		            <div class="table-responsive" >
					   <table class="table table-hover table-striped table-bordered" style="width:100%;">
						   <thead>
				               <tr class="table-primary text-center">
					               <th>계정코드</th>
					               <th>차변</th>
					               <th>계정명</th>
					               <th>대변</th>
					               <th>거래(처)명</th>
					               <th>적요</th>
				               </tr>
			               </thead>
			               <tbody id="modalTable">
			
			               </tbody>
					   </table>
					</div>     
				</form>
            </div>
            <hr style="border-color: #46bcf2;">
            <div class="modal-footer d-flex justify-content-between" >
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" id="regFrmBtn" form="registerForm" class="btn btn-primary">등록</button>
                <button type="button" id="uptBtn" form="registerForm" class="btn btn-info">수정</button>
            </div>
        </div>
    </div>
</div>
<!-- 모달창 종료 -->
<!-- 계정과목 조회 모달창 -->
<%@ include file="/WEB-INF/views/a04_financeResource/z01_modalAccsub.jsp" %>


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