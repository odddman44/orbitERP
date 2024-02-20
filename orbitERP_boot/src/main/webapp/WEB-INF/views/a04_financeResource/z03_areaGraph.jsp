<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<script>
$(document).ready(function() {
    // 기본 연도 설정
    var defaultYear = new Date().getFullYear(); // 현재 연도를 기본값으로 설정
    // 초기 차트 데이터 로드
    fetchNetIncomeData(defaultYear);
    
    // 연도 선택 이벤트 핸들러
    $("#yearSelect2").change(function(){
        var selectedYear = $(this).val();
        fetchNetIncomeData(selectedYear);
    });
    
    function fetchNetIncomeData(year){
        $.ajax({
            url: '/netIncomeGraph?year=' + year, 
            method: 'GET',
            dataType: 'json',
            success: function(response){
                console.log("서버 응답 데이터 : ", response);
                var months = response.map(function(item) {
                    return item.month + '월';
                });
                var netIncomes = response.map(function(item) {
                    return item.netincomes;
                });
                updateChart(months, netIncomes);
            },
            error: function(xhr, status, err){
                console.error("데이터 fetch 오류 : ", err);
            }
        });
    }
    
    function updateChart(months, netIncomes){
        console.log("순이익 데이터: ", netIncomes);
        var ctx = document.getElementById('myChart2').getContext('2d');
        if(window.lineChart != undefined){
            console.log("이전 차트 인스턴스 제거");
            window.lineChart.destroy();
        }
        window.lineChart = new Chart(ctx, {
            type: 'line', // 차트의 타입을 라인으로 변경
            data: {
                labels: months, // x축 레이블로 월 사용
                datasets: [{
                    label: '순이익',
                    data: netIncomes, // 순이익 데이터 배열
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1,
                    fill: false // 라인 아래 영역 채우기 비활성화
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
        console.log("차트 생성 완료");
    }
});
</script>
<div class="col-xl-6 col-lg-6">
	<div class="card shadow mb-4">
		<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold text-primary">손익 분석</h6>
			<form id="yearForm">
				<select id="yearSelect2" class="form-control">
					<option value="2024" selected>2024년</option>
					<option value="2023">2023년</option>
				</select>
			</form>
		</div>
		<div class="card-body">
			<span>(단위 : 원)</span>
			<hr>
			<div class="chart-container" style="position: relative; height:40vh; width:100%">
			    <canvas id="myChart2"></canvas>
			</div>
		</div>
	</div>
</div>