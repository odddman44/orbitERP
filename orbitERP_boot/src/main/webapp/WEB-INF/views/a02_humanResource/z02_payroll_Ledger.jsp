<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<script>
	$(document).ready(function() {

		searchStub()

		// 선택 요소에 월 옵션을 추가합니다.
		for (var i = 1; i <= 12; i++) {
			// 옵션 요소를 생성하여 선택 요소에 추가합니다.
			$('#month').append($('<option>', {
				value : i,
				text : i + '월'
			}));
		}

		$("#newBtn2").click(function() {
		    window.open('/insertPaystubFrm', '_blank', 'width=1000' ,'height=500'); 

		 
		});
		
		$("#schBtnFrm").click(function(){
			searchStub()
		})

	});
	
	// 콤마 추가 함수
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

	
	function searchStub() {
    $('#dataTable2').DataTable().destroy(); // 테이블 초기화

    $('#dataTable2').DataTable({
        "paging": true,
        "searching": false,
        "ordering": true,
        "info": true,
        "pagingType": "full_numbers",
        "pageLength": 10,
        "ajax": {
            "url": "/paystubList",
            "type": "POST",
            "data": function() {
                return $("#frm03").serialize(); // 폼 데이터를 직렬화하여 전송
            },
            "dataType": "json",
            "dataSrc": "" // 데이터 소스로 사용할 JSON 배열의 위치를 지정
        },
        "columns": [
            { 
                "data": "payment_date",
                "render": function(data, type, row) {
                    // 데이터가 표시될 때 날짜 형식으로 변환하여 반환
                    if (type === 'display' || type === 'filter') {
                        var date = new Date(data);
                        return date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2);
                    }
                    return data;
                }   
            }, 
            { "data": "stub_name"},
            { "data": "deptno" },         // 두 번째 열: empno
            { "data": "count"}, 
            { 
                "data": "total_net_pay",
                "render": $.fn.dataTable.render.number(',', '.', 0),
                "className": "text-right"
            }    
        ],
        "createdRow": function(row, data, index) {
            // 행 클릭 이벤트 처리
            $(row).on('click', function() {
            	var date = new Date(data.payment_date)
                var payment_dateStr = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2);
                goDetail(payment_dateStr, data.deptno);
            });
        }
    });
}

function goDetail(payment_dateStr, deptno) {
    window.open('/updatePaystubFrm?payment_dateStr=' + payment_dateStr + '&deptno=' + deptno, "", "width=1000", "height=500");
}
	 
</script>
<div class="col-xl-6 col-lg-6">
	<div class="card shadow mb-4">
		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">

			<h6 class="m-0 font-weight-bold text-primary">급여대장 조회</h6>
				<c:if test="${emem.auth eq '인사관리자' || emem.auth eq '총괄관리자'}">
					<button type="button" id="newBtn2"
						class="btn btn-primary btn-icon-split">
						<span class="icon text-white-50"><i class="fas fa-check"></i></span>
						<span class="text">신규</span>
					</button>
			</c:if>
		</div>


		<div class="card-body">
			<form id="frm03">
				<div class="row justify-content-end">
					<div class="col-3">
						<select name="deptno" class="form-control form-control-user">
							<option value="0">부서선택</option>
							<c:forEach var="dept" items="${dlist}">
								<option value="${dept.deptno}">${dept.dname}[${dept.deptno}]</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-3">
						<select id="year" class="form-control" name="year">
							<option value="0">년도</option>
							<c:forEach var="i" begin="2014" end="2024">
								<option value="${i}">${i}년</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-3">
						<select id="month" class="form-control" name="month">
							<option value="0">월</option>
							<c:forEach var="i" begin="1" end="12">
								<option value="${i}">${i}월</option>
							</c:forEach>
						</select>

					</div>
					<div class="col-3">
						<button class="btn btn-info" type="button" id="schBtnFrm">검색</button>
					</div>
				</div>
			</form>
			<br>
			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable2">
					<thead>
						<tr>

							<th>지급일</th>
							<th>대장명</th>
							<th>부서번호</th>
							<th>인원수</th>
							<th>총액</th>


						</tr>
					</thead>
					<tbody id="tbody">

					</tbody>
				</table>

			</div>
		</div>
	</div>
</div>


