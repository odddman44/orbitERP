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
<style>
body {
	margin: 40px 10px;
	padding: 0;
	font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	font-size: 14px;
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

#chatArea {
	width: 80%;
	height: 100px;
	overflow-y: auto;
	text-align: left;
	border: 1px solid green;
}

#calendar {
	max-width: 1000px;
	margin: 0 auto;
}

.ko_holiday {
    color: #ffffff;
  }
.fc-day-mon a {color:#000000;}
.fc-day-tue a {color:#000000;}
.fc-day-wed a {color:#000000;}
.fc-day-thu a {color:#000000;}
.fc-day-fri a {color:#000000;}
.fc-day-sun a {color:#e31b23;}
.fc-day-sat a {color:#007dc3;}


</style>
<%--
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
 --%>
<!-- jQuery -->
<script src="${path}/a00_com/jquery-3.6.0.js"></script>
<script src="${path}/a00_com/dist/index.global.js"></script>
<!-- 공휴일 표시를 위한 스크립트 -->
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.8/index.global.min.js"></script>
<!--  <script src="https://unpkg.com/@popperjs/core@2"></script>
<script src="https://unpkg.com/tippy.js@6"></script>-->


<script type="text/javascript">
	$(document).ready(function() {

						var calendarEl = document.getElementById('calendar');
						var today = new Date();
						var todayTitle = today.toISOString().split("T")[0];

						var calendar = new FullCalendar.Calendar(calendarEl, {
									locale : 'ko', // 한글로 변경
									//한글 '일'표시 없애기
									dayCellContent : function(info) {
										var number = document
												.createElement("a");
										number.classList
												.add("fc-daygrid-day-number");
										number.innerText = info.dayNumberText
												.replace("일", "");
										if (info.view.type === "dayGridMonth") {
											return {
												html : number.outerHTML
											};
										}
										return {
											domNodes : []
										};

									},
									googleCalendarApiKey: String,
									googleCalendarApiKey : 'AIzaSyCKX_iGgeWAxLr-yT3njsCdlIT-IK_Slnw',
									headerToolbar : { // 헤더에 표시할 툴 바
										left : 'prev,next today',
										center : 'title',
										right : 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
									},
									initialDate : todayTitle,
									navLinks : true, // can click day/week names to navigate views
									selectable : true,
									selectMirror : true,
							

									// 맨 마지막 한 주 없애기
									fixedWeekCount : false,

									//공휴일 추가 코드 넣기
									eventSources : [ {
										googleCalendarId : 'ko.south_korea#holiday@group.v.calendar.google.com',
										className : 'ko_holiday',
										overlap: true,
								        display: 'background',
								        backgroundColor: "#e31b23"
									} ],
									
									events : function(info, successCallback,
											failureCallBack) {
										$.ajax({
											url : "${path}/calList",
											dataType : "json",
											success : function(data) {
												// 서버단에서 받은 json데이터를
												// calendar api에 할당 처리..
												successCallback(data.callist)
											},
											error : function(err) {
												console.log(err)
												failureCallBack(err)
											}
										})
									},
									editable : true,
									dayMaxEvents : true,
								});

						calendar.render();


						//일정 클릭했을 때 해당 일정 정보를 표시하는
						function addForm(evt) {
							// evt.속성 : 기본적으로 fullcalendar에서 사용하는 속성 
							// evt.extendedProps.속성 : 기본속성이 아닌 추가적으로 
							//		상세화면에 출력시 사용되는 속성
							$("[name=id]").val(evt.id)
							$("[name=title]").val(evt.title)
							$("[name=writer]").val(evt.extendedProps.writer)
							$("#start").val(evt.start.toLocaleString())
							$("[name=start]").val(evt.startStr)
							$("#end").val(evt.end.toLocaleString())
							$("[name=end]").val(evt.endStr)

							$("[name=backgroundColor]")
									.val(evt.backgroundColor)
							$("[name=textColor]").val(evt.textColor)
							$("[name=content]").val(evt.extendedProps.content)
							$("[name=urlLink]").val(evt.extendedProps.urlLink)
							$("[name=allDay]").val(evt.allDay ? 1 : 0)
						}
					});
</script>

<!-- Custom styles for this template-->
<link href="${path}/a00_com/css/sb-admin-2.min.css" rel="stylesheet">
<link href="${path}/a00_com/css/custom-style.css" rel="stylesheet">
</head>
<div class="col-xl-6 col-lg-6">
	<div id="content">
		<div class="card shadow mb-4">
			<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
				<h6 class="m-0 font-weight-bold text-primary">연간 일정</h6>
				 <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${path}/planCalendar">연간 일정이동</a>
			</div>
			<div class="card-body">
				<h3 style="text-align: center; background-color: #87CEEB;"></h3>
				<div id='calendar'></div>
			</div>
		</div>
	</div>
</div>