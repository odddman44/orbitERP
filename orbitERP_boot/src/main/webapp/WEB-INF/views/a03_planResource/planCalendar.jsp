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
                  var sessionCk="${emem.auth}"//로그인된 session값
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
                           select : function(arg) {
                        	   if (sessionCk !== '총괄관리자' && sessionCk !== '계획관리자') {
                        	        return; // 아무 동작도 하지 않고 콜백을 종료합니다.
                        	    }
                              // 날짜 클릭시 등록처리되는 이벤트
                              // form name값에 기본데이터를 넣어 등록하기위해 초기화 처리
                              $("#frm01")[0].reset()
                              // 모달창을 같이 쓰기 때문에 타이틀 변경
                              $("#calTitle").text("일정등록")

                              $("#start").val(
                                    arg.start.toLocaleString())
                              $("[name=start]").val(arg.startStr)
                              $("#end").val(arg.end.toLocaleString())
                              $("[name=end]").val(arg.endStr)
                              $("#allDay").show()
                              $("[name=allDay]").val(
                                    arg.allDay ? 1 : 0)
                              $("#writer").val('계획관리자')
                              $("[name=writer]").val('PR0001')
                              
                                 $("#regBtn").show()
                                 $("#uptBtn").hide()
                                 $("#delBtn").hide()
                                 $("#alBtn").hide()
                              
                              // 모달창 로딩을 위해 강제 클릭
                              $("#calModal").click()

                              calendar.unselect()
                           },
                           eventClick : function(arg) {
                              // 일정을 클릭했을 때
                              $("#frm01")[0].reset()
                              addForm(arg.event)
                              $("#allDay").hide()

                              $("#calTitle").text("일정상세")
                              if(sessionCk!=='총괄관리자' && sessionCk!=='계획관리자'){
                                 $("#regBtn").hide()
                                 $("#uptBtn").hide()
                                 $("#delBtn").hide()
                                 $("#alBtn").hide()
                                 $("#frm01 :input").prop("readonly", true);
                              }else{
                                 $("#regBtn").hide()
                                 $("#uptBtn").show()
                                 $("#delBtn").show()
                                 $("#alBtn").show()
                              }

                              $("#calModal").click()
                           },
                           eventDrop : function(arg) {
                              addForm(arg.event)
                              ajaxFunc("updateCalendar", "post")
                           },
                           eventResize : function(arg) {
                              addForm(arg.event)
                              ajaxFunc("updateCalendar", "post")
                           },

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

                  $("#regBtn").click(function() {
                     ajaxFunc("insertCalendar", "post")
                  })
                  $("#uptBtn").click(function() {
                     if (confirm("일정을 수정하시겠습니까?")) {
                        ajaxFunc("updateCalendar", "post")
                     }
                  })
                  $("#delBtn").click(function() {
                     if (confirm("일정을 삭제하시겠습니까?")) {
                        ajaxFunc("deleteCalendar", "post")
                     }
                  })

                  function ajaxFunc(url, type) {
                     $.ajax({
                        type : type,
                        url : "${path}/" + url,
                        data : $("#frm01").serialize(),
                        // 데이터를 입력하고 요청데이터 서버에 전송
                        dataType : "json",

                        success : function(data) {
                           alert(data.msg) // 등록성공/등록실패
                           $("#clsBtn").click() // 등록 모달창 닫기..
                           // 기존일정 삭제(full api에 등록된 데이터 삭제 js) 
                           calendar.removeAllEvents();
                           calendar.render();
                           // 새로운 일정 추가..(서버에서 controller로 넘겨온 데이터)
                           // 다시 추가 처리..
                           calendar.addEventSource(data.callist)
                           window.location.reload();
                        },
                        error : function(err) {
                           console.log(err)
                        }
                     })

                  }
                  //일정 클릭했을 때 해당 일정 정보를 표시하는
                  function addForm(evt) {
                     // evt.속성 : 기본적으로 fullcalendar에서 사용하는 속성 
                     // evt.extendedProps.속성 : 기본속성이 아닌 추가적으로 
                     //      상세화면에 출력시 사용되는 속성
                     if(evt.allDay){
                        $("#start").val(evt.startStr)
                        $("#end").val(evt.endStr)
                     }else{
                        $("#start").val(evt.start.toLocaleString())
                        $("#end").val(evt.end.toLocaleString())
                     }
                     $("[name=id]").val(evt.id)
                     $("[name=title]").val(evt.title)
                     $("#writer").val('계획관리자')
                     $("[name=writer]").val(evt.extendedProps.writer)
                     $("[name=start]").val(evt.startStr)
                     $("[name=end]").val(evt.endStr)
                     $("[name=backgroundColor]")
                           .val(evt.backgroundColor)
                     $("[name=textColor]").val(evt.textColor)
                     $("[name=content]").val(evt.extendedProps.content)
                     $("[name=urlLink]").val(evt.extendedProps.urlLink)
                     $("[name=allDay]").val(evt.allDay ? 1 : 0)
                  }
               });
   function sendAlramPl(sender) {
	   var pltitle=$("[name=title]").val()
	    window.open("sendAlram2?sender=" + sender+"&altitle="+pltitle, "AlramWindow", "width=700 height=600 left=500 top=200");
	}
</script>
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
   <!-- Page Wrapper -->
   <div id="wrapper">
      <!-- Sidebar -->
      <%@ include file="/WEB-INF/views/a00_module/a02_sliderBar.jsp"%>
      <!-- End of Sidebar -->

      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column">

         <!-- Main Content -->
         <div id="content">
            <!-- Topbar  -->
            <%@ include file="/WEB-INF/views/a00_module/a03_topBar.jsp"%>
            <!-- End of Topbar -->
            <div class="card shadow mb-4">
            <div class="card-body">
            <h3 style="text-align: center; background-color: #87CEEB;">[ 연간 학원 스케줄 ]</h3>
            <div id='calendar'></div>
            <button id="calModal" class="btn btn-success d-none"
               data-toggle="modal" data-target="#exampleModalCenter" type="button">등록</button>

            <div class="modal fade" id="exampleModalCenter" tabindex="-1"
               role="dialog" aria-labelledby="exampleModalCenterTitle"
               aria-hidden="true">
               <div class="modal-dialog modal-dialog-centered" role="document">
                  <div class="modal-content">
                     <div class="modal-header">
                        <!-- 

            
             -->
                        <h5 class="modal-title" id="calTitle">일정등록</h5>
                        <button type="button" class="close" data-dismiss="modal"
                           aria-label="Close">
                           <span aria-hidden="true">&times;</span>
                        </button>
                     </div>
                     <div class="modal-body">
                        <form id="frm01" class="form" method="post">
                           <input type="hidden" name="id" value="0" />
                           <div class="input-group mb-3">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    제목</span>
                              </div>
                              <input type="text" name="title" class="form-control" value="" />
                           </div>
                           <div class="input-group mb-3">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    시작일</span>
                              </div>
                              <input type="text" id="start" readonly class="form-control" />
                              <input type="hidden" name="start" />
                           </div>
                           <div class="input-group mb-3">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    종료일</span>
                              </div>
                              <input type="text" id="end" readonly class="form-control" />
                              <input type="hidden" name="end" />
                           </div>
                           <div class="input-group mb-3">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    작성자</span>
                              </div>
                              <input id="writer" class="form-control" readonly/>
                              <input type="hidden" name="writer"/>
                           </div>
                           <div class="input-group mb-3">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    내용</span>
                              </div>
                              <textarea name="content" id="chatArea" class="form-control"></textarea>
                           </div>
                           <div class="input-group mb-3">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    배경색상</span>
                              </div>
                              <input type="color" name="backgroundColor"
                                 class="form-control" value="#0099cc" />
                           </div>
                           <div class="input-group mb-3">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    글자색상</span>
                              </div>
                              <input type="color" name="textColor" class="form-control"
                                 value="#ccffff" />
                           </div>
                           <div class="input-group mb-3" id="allDay">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    종일여부</span>
                              </div>

                              <select name="allDay" class="form-control">
                                 <option value="1">종일</option>
                                 <option value="0">시간</option>
                              </select>
                           </div>
                           <div class="input-group mb-3">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    참고 link</span>
                              </div>
                              <input type="text" name="urlLink" class="form-control"
                                 value="" />
                           </div>
                        </form>
                     </div>
                     <div class="modal-footer">
                        <!-- -->
                        <button type="button" id="regBtn" class="btn btn-primary">일정등록</button>
                        <button type="button" id="uptBtn" class="btn btn-info">일정수정</button>
                        <button type="button" id="delBtn" class="btn btn-warning">일정삭제</button>
                        <button type="button" id="alBtn" class="btn btn-dark" onclick="sendAlramPl('${emem.empno}')">알림보내기</button>
                        <button type="button" id="clsBtn" class="btn btn-secondary"
                           data-dismiss="modal">Close</button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         </div>
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
</body>
</html>