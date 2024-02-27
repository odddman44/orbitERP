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

.fc-day-mon a {color:#000000;}
.fc-day-tue a {color:#000000;}
.fc-day-wed a {color:#000000;}
.fc-day-thu a {color:#000000;}
.fc-day-fri a {color:#000000;}
.fc-day-sun a {color:#e31b23;}
.fc-day-sat a {color:#007dc3;}

.ko_holiday {
    color: #ffffff;
  }
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
                  $("#textColor").hide()
                  $("#backgroundColor").hide()
               if(sessionCk!=='총괄관리자' && sessionCk!=='계획관리자'){
               }
                  var calendarEl = document.getElementById('calendar');
                  var today = new Date();
                  var todayTitle = today.toISOString().split("T")[0];

                  var calendar = new FullCalendar.Calendar(calendarEl,
                        {
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
                           headerToolbar : {
                              left : 'prev,today',
                              center : 'title',
                              right : 'next'
                           },
                           // 한글로 변경
                           locale : 'ko',
                           eventResize : false,
                           eventDrop : false,
                           editable: false, // 수정 가능
                           droppable: false,
                           eventChange : false,
                           gotoDate : false,
                           initialDate : todayTitle,
                           navLinks : false, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
                           selectable : false, // 달력 일자 드래그 설정가능
                           selectMirror : true,
                           select : false, // 날짜 클릭시 일정등록 못하게 막음(상세조회 및 조회용)
                           //계획관리자가 눌렀을 떄 강의등록으로 갈지말지 생각
                           eventClick : function(arg,jsEvent, view) {
                              // 일정을 클릭했을 때
                              $("#frm01")[0].reset()
                              addForm(arg.event)//모달창에 데이터 넣기
                              var lec_code= arg.event.extendedProps.lec_code
                              var lecno= arg.event.extendedProps.lecno
                              $("#calTitle").text("["+lec_code+lecno+"]")
                              $("#regBtn").show() // 강의 상세보러가기

                              $("#calModal").click() //모달창열기
                              return false;
                           },
                           // 맨 마지막 한 주 없애기
                           fixedWeekCount : false,

                           //공휴일 추가 코드 넣기
                           eventSources : [ {
                              googleCalendarId : 'ko.south_korea#holiday@group.v.calendar.google.com',
                              className : 'ko_holiday',
                              overlap: true,
                                display: 'background',
                                backgroundColor: "#ff1111"
                           } ],
                           
                           events : function(info, successCallback,
                                 failureCallBack) {
                              $.ajax({
                                 url : "${path}/lecCalList",
                                 dataType : "json",
                                 success : function(data) {
                                    // 서버단에서 받은 json데이터를
                                    // calendar api에 할당 처리..
                                    //console.log(data.lecCalList)
                                    successCallback(data.lecCalList)
                                 },
                                 error : function(err) {
                                    console.log(err)
                                    failureCallBack(err)
                                 }
                              })
                           },
                           editable : false,
                           dayMaxEvents : true,
                        });

                  calendar.render();

                  //일정 클릭했을 때 해당 일정 정보를 표시하는
                  function addForm(evt) {
                     var title = evt.title.match(/\[(.*?)\]/)[1]
                     $("[name=id]").val(evt.id)
                     $("[name=title]").val(title)
                     $("#start").val(evt.startStr)
                     $("#end").val(evt.endStr)
                     //$("#end").val(evt.end.toLocaleString())
                     $("[name=lec_snum]").val(evt.extendedProps.lec_snum)
                     $("[name=lec_num]").val(evt.extendedProps.lec_num)
                     $("[name=lec_teacher]").val(evt.extendedProps.lec_teacher)

                     $("[name=backgroundColor]").val(evt.backgroundColor)
                     $("[name=textColor]").val(evt.textColor)
                     $("#detailBtn").click(function() { // 상세페이지 이동
                        showDetails(evt.extendedProps.lecno)
                     })
                  }
               });
   
   function showDetails(lecno){
      location.href="/lectureDetail?lecno="+lecno
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
            <h3 style="text-align: center; background-color: #87CEEB;">[ 강의 스케줄 ]</h3>
            <div id='calendar'></div>
            <button id="calModal" class="btn btn-success d-none"
               data-toggle="modal" data-target="#exampleModalCenter" type="button">등록</button>

            <div class="modal fade" id="exampleModalCenter" tabindex="-1"
               role="dialog" aria-labelledby="exampleModalCenterTitle"
               aria-hidden="true">
               <div class="modal-dialog modal-dialog-centered" role="document">
                  <div class="modal-content">
                     <div class="modal-header">
                        <h5 class="modal-title" id="calTitle"></h5>
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
                                    강의명</span>
                              </div>
                              <input type="text" name="title" class="form-control" readonly/>
                           </div>
                           <div class="input-group mb-3">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    개강일자</span>
                              </div>
                              <input type="text" id="start" readonly class="form-control" />
                           </div>
                           <div class="input-group mb-3">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    종강일자</span>
                              </div>
                              <input type="text" id="end" readonly class="form-control" />
                           </div>
                           <div class="input-group mb-3">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    강의실</span>
                              </div>
                              <input name="lec_num" class="form-control" readonly/>
                           </div>
                           <div class="input-group mb-3">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    강사명</span>
                              </div>
                              <input name="lec_teacher" class="form-control" readonly/>
                           </div>
                           <div class="input-group mb-3">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    학생수</span>
                              </div>
                              <input name="lec_snum" class="form-control" readonly/>
                           </div>
                           <div class="input-group mb-3" id="backgroundColor">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    배경색상</span>
                              </div>
                              <input type="color" name="backgroundColor"
                                 class="form-control" value="#0099cc" />
                           </div>
                           <div class="input-group mb-3" id="textColor">
                              <div class="input-group-prepend ">
                                 <span class="input-group-text  justify-content-center">
                                    글자색상</span>
                              </div>
                              <input type="color" name="textColor" class="form-control"
                                 value="#ccffff" />
                           </div>
                        </form>
                     </div>
                     <div class="modal-footer">
                        <!-- -->
                        <button type="button" id="detailBtn" class="btn btn-primary">강의상세조회</button>
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