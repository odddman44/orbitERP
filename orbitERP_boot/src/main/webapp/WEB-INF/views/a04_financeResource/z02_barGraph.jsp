<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<script>
	$(document).ready(function() {
		// 기본 연도 설정
        var defaultYear = new Date().getFullYear();
        // 초기 차트 데이터 로드
        fetchSalesAndPurchasesData(defaultYear);
		
		// 연도선택 이벤트 핸들러
		$("#yearSelect").change(function(){
			var selectedYear = $(this).val();
			fetchSalesAndPurchasesData(selectedYear);
		});
		
		function fetchSalesAndPurchasesData(year){
			$.ajax({
				url: '${path}/salesPurchasesSummary?year=' + year,
				method: 'GET',
				dataType: 'json',
				success: function(response){
					console.log("서버 응답 데이터 : ", response);
					var salesData = response.map(function(item) {
						return item.sales; 
					});
		            var purchaseData = response.map(function(item) {
		            	return item.purchases; 
		            });
		            updateChart(salesData, purchaseData);
				},
				error: function(xhr, status, err){
					console.error("데이터 fetch 오류 : ", err);
				}
			});
		}
		
		function updateChart(salesData, purchaseData){
			console.log("매출 데이터: ", salesData);
		    console.log("매입 데이터: ", purchaseData);
			var ctx = document.getElementById('myChart').getContext('2d');
			if(window.barChart != undefined){
				console.log("이전 차트 인스턴스 제거"); // 차트 인스턴스 존재 확인
				window.barChart.destroy();
			}
			window.barChart = new Chart(ctx, {
			    type: 'bar', // 차트의 타입
			    data: {
			        labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], // x축 레이블
			        datasets: [{
			            label: '매출',
			            data: salesData, // 매출 데이터 배열
			            backgroundColor: 'rgba(54, 162, 235, 0.2)',
			            borderColor: 'rgba(54, 162, 235, 1)',
			            borderWidth: 1
			        }, {
			            label: '매입',
			            data: purchaseData, // 매입 데이터 배열
			            backgroundColor: 'rgba(255, 99, 132, 0.2)',
			            borderColor: 'rgba(255, 99, 132, 1)',
			            borderWidth: 1
			        }]
			    },
			    
			    options: {
			    	responsive: true,
			        maintainAspectRatio: false,
			        scales: {
			            y: {
			            	beginAtZero: true
			            }
			        }
			    }
			});
			console.log("차트 생성 완료"); // 차트 생성 확인
		}
	});
</script>
<div class="col-xl-6 col-lg-6">
	<div class="card shadow mb-4">
		<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold text-primary">매출/매입 분석</h6>
			<form id="yearForm">
				<select id="yearSelect" class="form-control">
					<option value="2024" selected>2024년</option>
					<option value="2023">2023년</option>
				</select>
			</form>
		</div>
		<div class="card-body">
			<span>(단위 : 원)</span>
			<hr>
			<div class="chart-container" style="position: relative; height:40vh; width:100%">
			    <canvas id="myChart"></canvas>
			</div>
		</div>
	</div>
</div>