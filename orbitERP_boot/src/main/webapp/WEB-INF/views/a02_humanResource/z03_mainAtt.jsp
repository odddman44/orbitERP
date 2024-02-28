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
</style>
<script>
	var empno = "${emem.empno}"
	// 출퇴근을 위한 오늘 날짜 가져오기
	var today = new Date();
	var yyyy = today.getFullYear();
	var mm = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1이 필요하며, 두 자리로 만들기 위해 padStart를 사용합니다.
	var dd = String(today.getDate()).padStart(2, '0'); // 일자를 두 자리로 만들기 위해 padStart를 사용합니다.
	var todayString = yyyy + '-' + mm + '-' + dd; // 'YYYY-MM-DD' 형식의 문자열로 조합합니다.
	console.log("오늘 날짜: " + todayString)
	$(document).ready(function(){
			
		
			
			detailAttendacne();
			
			$("#arrBtn").click(function(){
				$.ajax({
					type : "POST",
					url : "${path}/isExitsCheckIn", // 작업 날짜 중복을 확인하는 API 엔드포인트
					data : {
						work_date : todayString,
						empno : "${emem.empno}"
					}, // 확인하려는 작업 날짜 데이터를 전달
					success : function(data) {
						// 중복된 작업 날짜가 발견되지 않으면 AJAX 요청 실행
						if (data <= 0) {
							checkIn();
							alert("오늘 출근완료! 오늘 근무도 화이팅 ㅎㅎ")
							location.reload()
							
						} else {
							alert("이미 출근 등록을 했습니다.")
						}
					},
					error : function(err) {
						console.log(err);
					}
				});
				event.preventDefault();
			})
			$("#depBtn").click(function(){
				$.ajax({
					type : "POST",
					url : "${path}/checkOut", // 작업 날짜 중복을 확인하는 API 엔드포인트
					data : {
						work_date : todayString,
						empno : "${emem.empno}"
					}, // 확인하려는 작업 날짜 데이터를 전달
					success : function(data) {

						if (data > 0) {
							alert("퇴근완료 수고하셨습니다.")
							location.reload();
							
						} else {
							console.log("퇴근 실패")
						}
					},
					error : function(err) {
						console.log(err);
					}
				});
				event.preventDefault();
			})
			
			$("#todayDate").text("근무 일자: "+todayString)
	})
	
	// 출근하기 함수
	
		function checkIn() {
		$.ajax({
			type : "POST",
			url : "${path}/checkIn",
			data : {
				empno : "${emem.empno}"
			},
			success : function(data) {
				if (data > 0)
					console.log("출근 기록 저장완료")
			},
			error : function(data) {
				console.log("출근 기록 저장 실패")
			}
		})
	}
	
	function extractTime(date) {
	    // 시간 데이터를 공백을 기준으로 분리하고, 두 번째 요소(시간)를 반환합니다.
	    var time = date.split(" ")[1];
	    return time;
	}
	
	function detailAttendacne(){
		$.ajax({
			type : "POST",
			url : "${path}/detailAttendance",
			data : {
				work_date : todayString,
				empno : "${emem.empno}"
			},
			success : function(att) {
				if (att!=null){
					$("#arrtime").text("출근시간 : "+extractTime(att.arr_time))
					$("#deptime").text("퇴근시간 : "+extractTime(att.dep_time))
					$("#tot_workhours").text("총 근무시간 : "+att.tot_workhours)
				}else{ 
					$("#arrtime").text("출근시간 : ")
					$("#arrtime").text("퇴근시간 : ")
					}
			},
			error : function(data) {
				console.log("상세 정보 불러오기 실패")
			}
		})
	}
	

</script>
<div class="col-xl-6 col-lg-6">
	<div class="card shadow mb-4">
		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold text-primary">출퇴근 정보 관리</h6>
		</div>
		<div class="card-body">
					<div class="text-center">
					<h6 class="m-0 font-weight-bold text-dark" id="todayDate">날짜</h6>
					<br>
					<h6 class="m-0 font-weight-bold text-dark" id="arrtime">출근시간</h6>
					<br>
					<h6 class="m-0 font-weight-bold text-dark" id="deptime">퇴근시간</h6>
					<br>
					<h6 class="m-0 font-weight-bold text-dark" id="tot_workhours">총 근무 시간</h6>
					<br>
					<a href="#" class="btn btn-primary btn-icon-split btn-lg"
						id="arrBtn"> <span class="icon text-white-50"> <i
							class="fas fa-flag"></i>
					</span> <span class="text">출근하기</span>
					</a> <a href="#" class="btn btn-danger btn-icon-split btn-lg"
						id="depBtn"> <span class="icon text-white-50"> <i
							class="fas fa-flag"></i>
					</span> <span class="text">퇴근하기</span>
					</a>
				</div>
		</div>
	</div>
</div>