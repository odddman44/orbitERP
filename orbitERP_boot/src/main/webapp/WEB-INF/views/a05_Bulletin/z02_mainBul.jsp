<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<style>
h6 {
	text-align: left; /* 왼쪽 정렬 */
}
table {
	text-align: center;
	border: 0;
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
<script>

$(document).ready(function() {
   
    loadData(); 
});

function loadData() {
    $.ajax({
        type: "GET", // HTTP 요청 방식 (GET, POST 등)
        url: "bulletinList", // 데이터를 불러올 컨트롤러의 엔드포인트 URL
        success: function(data) {
            // AJAX 요청이 성공했을 때 실행되는 함수
            // data는 서버에서 받아온 데이터를 가리킵니다.

            // 받아온 데이터를 테이블에 추가
            $('#bulListTableBody').html(data);
        },
        error: function() {
            // AJAX 요청이 실패했을 때 실행되는 함수
            alert("데이터를 불러오는 데 실패했습니다.");
        }
    });
}

	
</script>
<div class="col-xl-6 col-lg-6">
	<div class="card shadow mb-4">
			
		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold text-primary">공지사항</h6>
		</div>
		<div class="card-body">
			
					<div class="table-responsive">
							<table class="table" id="dataTable" width="100%"
							cellspacing="0">
							
							
							<col width="55%">
							<col width="25%">
							<col width="20%">

							<thead class="thead-light">

								<tr class="table-success text-center">
									
									
									<th>제목</th>
									<th>등록일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody id="bulListTableBody">

								<c:forEach var="bul" items="${bulletinList}">
									<tr ondblclick="goDetail(${bul.no})">
										
										
										<td>${bul.title}</td>
										<td><fmt:formatDate value="${bul.regdte }" /></td>
										<td>${bul.readcnt}</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
							
						</table>
						</div>
						
						
						<!-- 등록 버튼과 페이지 위치 못 맞추는 문제 있음 -->

						
					</div>
				</div>
			</div>