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
 <style>
 #chatArea{
   height:300px;
}
#text{

width:70%;
    margin-left: auto;
    margin-right: auto;
}
.input-group-text{width:100%;background-color:linen;
      color:black;font-weight:bolder;}
.input-group-prepend{width:20%;}
.input_value {
    display: flex;
    align-items: center;
    width: 35%;
}
 </style>
<!-- jQuery -->
<script src="${path}/a00_com/jquery-3.6.0.js"></script>
<script type="text/javascript">
      // form 하위에 있는 모든 요소객체들을  enter키 입력시, submit
      // 되는 기본 이벤트 속성이 있다. ajax처리시 충돌되는 이 이벤트 속성을
      // 아래의 코드로 방지 처리..
      document.addEventListener('keydown', function(event) {
           if (event.key === "Enter") {
             event.preventDefault();
           }
      });   
      var snoList=[] //등록처리된 sno들
      
   $(document).ready(function() {
	  if($("[name=lec_snum]").val()==0) alert("수강학생이 없습니다.")
      var sessionCk="${emem.auth}"//로그인된 session값
      if(sessionCk!=='총괄관리자' && sessionCk!=='계획관리자'){
         $("#uptBtn").hide()
         $("#delBtn").hide()
         $("#mainBtn").hide()
         $("#schTch").hide()
         $("#schStu1").hide() //학생변경하는 모달창
         $("#gradeStu").hide()
         $(".score").hide() //id값은 중복될 수 없지만 class는 해당요소에 모두 적용가능하다!
         $(".modal-title").text("수강학생조회");
      }else{
         $("#schStu2").hide() //학생조회하는 테이블
      }
      console.log("${lecture.lecno}")
      searchStu()
      // 등록된 강사 색상 바꾸기
       $("#color").find("tr").css("background-color", "#f4d03f");
      // 숫자에 콤마를 추가하는 함수
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
      // 강의료, 교재비 초기로딩시 콤마표시
         $('#textbook_fee').val((addCommas(${lecture.textbook_fee})))
         $('#tuition_fee').val((addCommas(${lecture.tuition_fee})))
      // 키 입력시 자동으로 콤마 처리
          $('#tuition_fee,#textbook_fee').on('input', function() {
              var input = $(this).val().replace(/,/g, ''); // 먼저 콤마를 제거
              if (!isNaN(input)) { // 입력 값이 숫자인 경우
                  $(this).val(addCommas(input)); // 콤마 추가
              }
          });
       // 개강일자와 종강일자 input 요소를 가져옴
       var startDateInput = $("input[name='start_date']");
       var endDateInput = $("input[name='end_date']");
   
       // input 요소의 값이 변경될 때마다 체크하는 함수
       function checkDateValidity() {
         // input 요소의 값 가져오기
         var startDate = new Date(startDateInput.val());
         var endDate = new Date(endDateInput.val());
   
         // 개강일자가 종강일자보다 늦을 때
         if (startDate > endDate) {
           // 경고 알림창 표시
           alert("개강일자는 종강일자보다 빨라야 합니다!");
           // 현재 입력값 초기화
           startDateInput.val("${lecture.start_date}");
           endDateInput.val("${lecture.end_date}");
         }
       }
   
       // 개강일자와 종강일자 input 요소에 change 이벤트 리스너 등록
       startDateInput.change(checkDateValidity);
       endDateInput.change(checkDateValidity);
       
      
   $("#uptBtn").click(function(){
      var inputField = $('#tuition_fee');
        var valueWithCommas = inputField.val();
        // 콤마를 제거합니다.
        var valueWithoutCommas = valueWithCommas.replace(/,/g, '');
        // 콤마가 제거된 값을 다시 입력 필드에 설정합니다.
        inputField.val(valueWithoutCommas);
       var inputField = $('#textbook_fee');
        var valueWithCommas = inputField.val();
        // 콤마를 제거합니다.
        var valueWithoutCommas = valueWithCommas.replace(/,/g, '');
        // 콤마가 제거된 값을 다시 입력 필드에 설정합니다.
        inputField.val(valueWithoutCommas);
           
         if($("[name=lec_name]").val()==""){
            alert("강의명을 입력하세요")
            return;
         }
         if($("[name=start_date]").val()==""){
            alert("개강일자를 입력하세요")
            return;
         }
         if($("[name=end_date]").val()==""){
            alert("종강일자를 입력하세요")
            return;
         }
         if($("[name=lec_num]").val()==""){
            alert("강의실을 입력하세요")
            return;
         }
         if($("[name=tuition_fee]").val()==""||
               isNaN($("[name=tuition_fee]").val())){
            alert("강의료를 숫자로 입력하세요")
            return;
         }
         if($("[name=textbook_fee]").val()==""||
               isNaN($("[name=textbook_fee]").val())){
            alert("교재비를 숫자로 입력하세요")
            return;
         }
         if($("[name=lec_content]").val()==""){
            alert("강의내용을 입력하세요")
            return;
         }
         
         if(confirm("수정하시겠습니까?")){
            $.ajax({
                  type: "POST",
                  url: "/lectureUpdate",
                  data: $("#mainform").serialize(),
                  dataType: "json",
                  success: function (data) {
                     alert(data.msg)
                      snoList.forEach(function (sno) {
                          insertEnroll(sno, $("[name=lecno]").val(), $("[name=empno]").val());
                      });
                      window.location.reload();
                  },
                  error: function (err) {
                      console.log(err);
                      // Handle form submission error here
                  }
              })
      }
      
   })
   $("#delBtn").click(function(){
      if(confirm("${lecture.lec_code}${lecture.lecno}를 삭제하시겠습니까?")){
         $.ajax({
               type: "POST",
               url: "/lectureDelete",
               data: $("#mainform").serialize(),
               dataType: "json",
               success: function (data) {
                  alert(data.msg)
                  location.href="lectureList"
               },
               error: function (err) {
                   console.log(err);
                   // Handle form submission error here
               }
           })
      }
   
   })
   
   $("#schTBtn").click(function(){ //강사 모달창 검색
      searchTch()
   })
   $("#schTch").click(function(){ // 강사변경 클릭시
      $("[name=subject]").val($("[name=lec_code]").val());
       searchTch() 
   });
   
   $("#gradeStu").click(function(){ // 성적등록버튼 클릭시
      alert("추가등록/삭제된 학생은 수정 후 반영됩니다.")
   })
   
   $("#schBtn").click(function(){ //학생 모달창 검색
      searchStu()
   })
   $("[name=name],[name=final_degree]").keyup(function(){
      if(event.keyCode==13) // 없으면 실시간으로 조회 처리해줌
      searchStu()
   })
   $("[name=ename],[name=subject]").keyup(function(){
      if(event.keyCode==13) // 없으면 실시간으로 조회 처리해줌
      searchTch()
   })
   $("#tot").text('수강학생('+snoList.length+')') // 초기화면 총 수 나타내기
   
   $("#insertStu").click(function(){
       $("[name=lec_snum]").val(snoList.length);
       $("#frm02")[0].reset() //검색값 리셋
       searchStu() //다시 학생조회했을 때 전체출력
       $("#stuModal").modal("hide");//모달 닫기
       $(".modal-backdrop").remove();//뒷배경 제거
   });
   table('dataTable3')
});
      
   // 강사 세션확인
   <%--function sessCk(empno){
      $.ajax({
         type: "POST",
         url: "/sessCk",
         data : {
            empno: empno
         },
         dataType: "text",
         success: function (data) {
            if (data) {
               tch="강사";
               console.log(tch); //여기는 강사
               } 
         },
         error: function (err) {
            console.log(err)
         }
      })
   }--%>
   //수강테이블 insert
   function insertEnroll(sno,lecno,empno) {
      $.ajax({
         //type: "POST",
         url: "/insertEnroll",
         data: {
           sno: sno,
           lecno:lecno,
           empno: empno
         },
         dataType: "text",
         success: function (data) {
            console.log("수강 "+data)
         },
           error: function (err) {
             console.log(err)
         }
      });
   }
   
   //테이블 페이징처리
   function table(id){
      $("#"+id).DataTable({
          //"paging": true,        // 페이지 나누기 기능 사용
          "pageLength": 10, 
           "lengthChange": true, // 한 페이지에 표시되는 행 수 변경 가능
           "searching": false, // 검색 기능 사용
           "ordering": true, // 정렬 기능 사용
           "info": true, // 표시 건수 및 현재 페이지 표시
           "autoWidth": false, // 컬럼 너비 자동 조절 해제
           "language" : {
               "emptyTable" : "검색한 데이터가 없습니다.",
               "info": "현재 _START_ - _END_ / 총 _TOTAL_건",
               "lengthMenu" : "_MENU_행 조회",
               "paginate": {
                      "next": "다음",
                    "previous": "이전"
                   }
           }
       })
   }
   
   function searchTch() {
       $.ajax({
           url: "/schTch",
           data: $("#frm01").serialize(),
           dataType: "json",
           success: function (data) {
               var stuhtml = "";
               $("#dataTable1").DataTable().destroy();
               $.each(data.teacherList, function (idx, tch) {
                  stuhtml += "<tr ondblclick=\"location.href='detailEmp?empno=" + tch.empno + "'\">";
                   stuhtml += "<td>" + tch.empno + "</td>"
                   stuhtml += "<td>" + tch.ename + "</td>"
                   stuhtml += "<td>" + tch.subject + "</td>"
                   stuhtml += "<td>" + tch.email + "</td>"
                   stuhtml += '<td><button class="btn btn-success" type="button" onclick="addTch(\'' + tch.empno + '\',\'' + tch.ename + '\',\'' + tch.subject + '\')">변경</button></td>';
                   stuhtml += "</tr>"
               })

               $("#tch").html(stuhtml);
               table('dataTable1')

           },
           error: function (err) {
               console.log(err)
           }
       });
   }
   
   function addTch(empno,ename,subject){
      $("[name=lec_teacher]").val(ename);
      $("[name=empno]").val(empno);
      $("#frm01")[0].reset() //검색값 리셋
      searchTch() //다시 강사조회했을 때 전체출력
      $("#tchModal").modal("hide");//모달 닫기
       $(".modal-backdrop").remove();//뒷배경 제거
   }
   
   function searchStu() {
       $.ajax({
           url: "/stuSch",
           data: $("#frm02").serialize(),
           dataType: "json",
           success: function (studentList) {
              $("#totStu").text('총 학생 수 : '+studentList.length+'명')
               $("#dataTable2").DataTable().destroy();
               var stuhtml = "";
               $.each(studentList, function (idx, stu) {
                  stuhtml += "<tr ondblclick=\"location.href='detailStudent?sno=" + stu.sno + "'\">";
                   stuhtml += "<td>" + stu.sno + "</td>"
                   stuhtml += "<td>" + stu.name + "</td>"
                   stuhtml += "<td>" + stu.birth + "</td>"
                   stuhtml += "<td>" + stu.final_degree + "</td>"
                   stuhtml += "<td>" + stu.phone + "</td>"
                   stuhtml += "<td>" + stu.address + "</td>"
                   stuhtml += '<td><button class="btn btn-success" type="button" onclick="addStu(\'' + stu.sno + '\',\'' + stu.name + '\',\'' + stu.final_degree + '\',\'' + stu.phone + '\')">등록</button></td>';
                   stuhtml += "</tr>"
               })
               $("#stu").html(stuhtml);
               //$("#dataTable2").DataTable().draw();
               table('dataTable2')
           },
           error: function (err) {
               console.log(err)
           }
       });
   }
   
   function addStu(sno, name, final_degree,phone) {   
      //이미 등록된 학생 중복X
      //snoList의 값들과 sno를 비교하는 코드
      if(snoList.includes(sno)){
         alert('이미 등록된 학생입니다.')
         return;
      }else{
          snoList.push(sno)
      }
      
       var row = "";
       row += "<tr><td>" + sno + "</td>";
       row += "<td>" + name + "</td>";
       row += "<td>" + final_degree + "</td>";
       row += "<td>" + phone + "</td>";
       row += "<td><button class='btn btn-danger' type='button' onclick='deleteStu(this)'>삭제</button></td>";
       row += "</tr>";

       $("#add").append(row);
       $("#tot").text('수강학생('+snoList.length+')') //등록시 총 수 변경
       console.log(snoList)
   }

   function deleteStu(button) {
      // 삭제 버튼을 클릭한 행을 찾아 삭제
       var deletedSno = $(button).closest("tr").find("td:first").text();
       $(button).closest("tr").remove();

       // snoList에서 해당 sno번호 삭제
       var index = snoList.indexOf(deletedSno);
       if (index !== -1) {
           snoList.splice(index, 1);
       }
       $("#tot").text('수강학생('+snoList.length+')') //삭제시 총 수 변경
       if(snoList.length==0) alert('수강학생이 없습니다.')
   }
   function sendAlramLec(sender) {
	   var lectitle=$("[name=lec_name]").val()
	    window.open("sendAlram2?sender=" + sender+"&altitle="+lectitle, "AlramWindow", "width=700 height=600 left=500 top=200");
	}
   
</script>
<!-- DB테이블 플러그인 추가 -->
<link rel="stylesheet" href="${path}/a00_com/css/vendor.bundle.base.css">
<link rel="stylesheet"
   href="${path}/a00_com/vendor/datatables/dataTables.bootstrap4.css">
<link rel="stylesheet" type="text/css"
   href="${path}/a00_com/js/select.dataTables.min.css">
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
            <!-- Begin Page Content (여기서부터 페이지 내용 입력) -->
            <div class="container-fluid">
               <div
                  class="d-sm-flex align-items-center justify-content-between mb-4">
                  <h1 class="h3 mb-0 text-gray-800">[${lecture.lec_code}${lecture.lecno}]
                     상세정보</h1>
               </div>
               <div class="card shadow mb-4">
                  <div class="card-body">
                     <div id="text">
                     <form id="mainform">
                     <div class="input-group mb-3">
                        <div class="input-group-prepend ">
                           <span class="input-group-text  justify-content-center">
                              강의코드</span>
                        </div>
                        <input name="lec_code" class="form-control"
                           value="${lecture.lec_code}" readonly/>
                        <div class="input-group-prepend ">
                           <span class="input-group-text  justify-content-center" >
                              강의번호</span>
                        </div>
                        <div class="input_value">
                        <input name="lecno" class="form-control"
                           value="${lecture.lecno}" readonly/>
                        </div>
                     </div>
                     <div class="input-group mb-3">
                        <div class="input-group-prepend ">
                           <span class="input-group-text  justify-content-center">
                              강의명</span>
                        </div>
                        <input name="lec_name" class="form-control"
                           value="${lecture.lec_name}" />
                        <div class="input-group-prepend ">
                           <span class="input-group-text  justify-content-center">
                              강사명</span>
                        </div>
                        <div class="input_value">
                           <input name="lec_teacher" class="form-control" value="${lecture.lec_teacher}" readonly/>
                           <input name="empno" class="form-control" type="hidden"/> 
                           <input type="button" class="btn btn-dark" value="강사변경"
                           data-toggle="modal" data-target="#tchModal" id="schTch"/>
                        </div>
                     </div>
                     <div class="input-group mb-3">
                        <div class="input-group-prepend ">
                           <span class="input-group-text  justify-content-center">
                              개강일자</span>
                        </div>
                        <input type="date" name="start_date" class="form-control"
                           value="${lecture.start_date}" />
                        <div class="input-group-prepend ">
                           <span class="input-group-text  justify-content-center">
                              종강일자</span>
                        </div>
                        <div class="input_value">
                        <input type="date" name="end_date" class="form-control"
                           value="${lecture.end_date}" />
                           </div>
                     </div>
                     <div class="input-group mb-3">
                        <div class="input-group-prepend ">
                           <span class="input-group-text  justify-content-center">
                              강의실</span>
                        </div>
                        <input name="lec_num" class="form-control"
                           value="${lecture.lec_num}" />
                        <div class="input-group-prepend ">
                           <span class="input-group-text  justify-content-center">
                              학생수</span>
                        </div>
                        <div class="input_value">
                           <input name="lec_snum" class="form-control" value="${lecture.lec_snum}" readonly/> 
                           <input type="button" class="btn btn-dark" value="학생조회"
                           data-toggle="modal" data-target="#stuGradeModal" id="schStu2" />
                           <input type="button" class="btn btn-dark" value="학생변경"
                           data-toggle="modal" data-target="#stuModal" id="schStu1" />
                           <input type="button" class="btn btn-dark" value="성적등록"
                           data-toggle="modal" data-target="#stuGradeModal" id="gradeStu" />
                        </div>
                     </div>
                     <div class="input-group mb-3">
                        <div class="input-group-prepend ">
                           <span class="input-group-text  justify-content-center">
                              강의료</span>
                        </div>
                        <input name="tuition_fee" id="tuition_fee" class="form-control"/>
                        <div class="input-group-prepend ">
                           <span class="input-group-text  justify-content-center">
                              교재비</span>
                        </div>
                        <div class="input_value">
                        <input name="textbook_fee" id="textbook_fee" class="form-control"/>
                        </div>
                     </div>
                     <div class="input-group mb-3">
                        <div class="input-group-prepend ">
                           <span class="input-group-text  justify-content-center">
                              강의내용</span>
                        </div>
                        <textarea id="chatArea" name="lec_content" class="form-control">${lecture.lec_content}</textarea>
                     </div>
                     <div style="text-align: right;">
                        <input type="button" class="btn btn-success" value="수정" id="uptBtn" />
                        <input type="button" class="btn btn-danger" value="삭제" id="delBtn" /> 
                        <input type="button" class="btn btn-dark" value="알림보내기" id="mainBtn"  onclick="sendAlramLec('${emem.empno}')"/>
                     </div>
                     </form>
                  </div>
                  </div>
                  </div>
               </div>

               <!-- /.container-fluid (페이지 내용 종료) -->
            </div>
            <!-- End of Main Content -->
<!-- start 강사조회modal -->
         <div class="modal" id="tchModal" >
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title">강사조회</h5>
                     <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                     </button>
                  </div>
                  <div class="modal-body">
                  <div class="card shadow mb-4">
                  <div class="card-header py-3">
                     <hr>
                     <form id="frm01" class="form" method="post">
                        <nav class="navbar navbar-expand-sm navbar-light bg-light">

                           <input placeholder="강사명" name="ename" value="${schT.ename}"
                              class="form-control mr-sm-2" /> 
                           <select name="subject"  class="form-control mr-sm-2" >
                              <option value="">전체조회</option>
                              <c:forEach var="subject" items="${subjects}">
                                 <option>${subject}</option>
                              </c:forEach>
                           </select>
                           <button class="btn btn-info" type="button" id="schTBtn">Search</button>
                        </nav>
                     </form>
                  </div>
                  <div class="card-body">
                     <h5>담당강사</h5>
                     <span>더블클릭시, 강사 상세정보 페이지로 이동합니다.</span>
                     <div class="table-responsive">
                        <table class="table table-bordered" id="dataTable1">
                          <col width="20%">
                           <col width="15%">
                           <col width="15%">
                           <col width="35%">
                           <col width="15%">
                           <thead>
                              <tr>
                                 <th>강사번호</th>
                                 <th>이름</th>
                                 <th>담당과목</th>
                                 <th>이메일</th>
                                 <th>선택</th>
                              </tr>
                           </thead>
                           <tbody id="color">
                              <tr>
                                 <td><c:out value="${tch.empno }"></c:out></td>
                                 <td><c:out value="${tch.ename }"></c:out></td>
                                 <td><c:out value="${tch.subject }"></c:out></td>
                                 <td><c:out value="${tch.email }"></c:out></td>
                                 <td>기존등록</td>
                              </tr>
                           </tbody>
                           <tbody id="tch">
                           </tbody>
                        </table>
                     </div>
                  </div>
               </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary"
                        data-dismiss="modal">닫기</button>
                  </div>
               </div>
            </div>
         </div>
      </div>
         
         <!-- start 학생조회modal -->
         <div class="modal" id="stuModal" >
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title">학생변경</h5>
                     <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                     </button>
                  </div>
                  <div class="modal-body">
                  <div class="card shadow mb-4">
                  <div class="card-header py-3">

                     <hr>
                     <form id="frm02" class="form" method="post">
                        <nav class="navbar navbar-expand-sm navbar-light bg-light">

                           <input placeholder="학생명" name="name" value="${sch.name}"
                              class="form-control mr-sm-2" /> 
                           <select class="form-control mr-sm-2" name="final_degree">                           
                              <option value="">학년 선택</option>
                              <option value="초등">초등</option>
                              <option value="중등">중등</option>
                              <option value="고등">고등</option>
                              <option value="성인">성인</option>
                           </select> 
                           <button class="btn btn-info" type="button" id="schBtn">Search</button>
                        </nav>
                        <div class="input-group mt-3 mb-0">
                           <span class="input-group-text" id="totStu"></span>
                        </div>
                     </form>
                  </div>
                  <div class="card-body">
                     <h5 id="tot"></h5>
                     <span>더블클릭시, 학생 상세정보 페이지로 이동합니다.</span>
                     <div class="table-responsive">
                        <table class="table table-bordered">
                        <col width="15%">
                         <col width="20%">
                         <col width="25%">
                         <col width="25%">
                         <col width="15%">
                           <thead>
                              <tr>
                                 <th>학생번호</th>
                                 <th>이름</th>
                                 <th>학년</th>
                                 <th>전화번호</th>
                                 <th>삭제</th>
                              </tr>
                           </thead>
                           <tbody id="add">
                              <c:forEach var="stu" items="${stuList}">
                                 <tr>
                                 <td>${stu.sno}</td>
                                 <td>${stu.name}</td>
                                 <td>${stu.final_degree}</td>
                                 <td>${stu.phone}</td>
                                 <td><button class='btn btn-danger' type='button' onclick='deleteStu(this)'>삭제</td>
                                 </tr>
                                 <script>
                                      snoList.push("${stu.sno}");
                                  </script>
                              </c:forEach>
                           </tbody>
                        </table>
                     </div>
                     <div class="table-responsive">
                        <table class="table table-bordered" id="dataTable2">
                          <col width="8%">
                           <col width="10%">
                           <col width="18%">
                           <col width="15%">
                           <col width="15%">
                           <col width="25%">
                           <col width="9%">
                           <thead>
                              <tr>
                                 <th>학번</th>
                                 <th>이름</th>
                                 <th>생년월일</th>
                                 <th>학년</th>
                                 <th>전화번호</th>
                                 <th>주소</th>
                                 <th>등록</th>
                              </tr>
                           </thead>
                           <tbody id="stu">
                           </tbody>
                        </table>
                     </div>
                     <hr>
                  </div>
               </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary"
                        data-dismiss="modal">닫기</button>
                     <button type="button" class="btn btn-primary" id="insertStu">학생변경</button>
                  </div>
               </div>
            </div>
         </div>
      </div>
         <!-- start 성적등록, 학생조회 modal -->
         <div class="modal" id="stuGradeModal" >
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title">성적등록</h5>
                     <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                     </button>
                  </div>
                  <div class="modal-body">
                  <div class="card shadow mb-4">
                  <div class="card-header py-3">
                  성적 입력 후, Enter를 눌러주세요.(총괄&계획관리자의 경우)
                  </div>
                  <div class="card-body">
                     <div class="table-responsive">
                        <table class="table table-bordered" id="dataTable3">
                        <th=20%>
                        <th=20%>
                        <th=20%>
                        <th=20%>
                        <th=20%>
                           <thead>
                              <tr>
                                 <th style="width: 5%;">no</th>
                                 <th style="width: 15%;">이름</th>
                                 <th style="width: 13%;">학번</th>
                                 <th style="width: 18%;">학년</th>
                                 <th style="width: 25%;">전화번호</th>
                                 <th style="width: 10%;">기존점수</th>
                                 <th class="score" style="width: 17%;">점수</th>
                                 <th style="width: 20%;">등급</th>
                              </tr>
                           </thead>
                           <tbody>
                              <c:forEach var="stu" items="${stuList}" varStatus="no">
                                 <tr>
                                 <td>${no.index+1}</td>
                                 <td>${stu.name}</td>
                                 <td>${stu.sno}</td>
                                 <td>${stu.final_degree}</td>
                                 <td>${stu.phone}</td>
                                 <td>${stu.sscore}</td>
                                 <td class="score">
                                  <input class="scoreInput" data-sno="${stu.sno}" data-index="${no.index}"
                                   id="sscore${no.index}" onkeyup="updateOnEnter(event, this)" style="width: 100%;"/>
                                  </td>
                                     <td id="grade${no.index}">${stu.grade}</td>
                                 </tr>
                              </c:forEach>
                           </tbody>
                        </table>
                        <script>
                        function updateOnEnter(event, input) {
                           if (event.keyCode==13) {
                           // 현재 입력 필드의 인덱스 가져오기
                            var index = input.getAttribute('data-index');
                             // 학생 번호 가져오기
                             var sno = input.getAttribute('data-sno');
                             // 입력된 점수 가져오기
                             var sscore = input.value;
                             if(sscore==''){
                                sscore = 0;
                             }
                             if (isNaN(sscore)) {
                                 alert("숫자를 입력하세요.");
                                 return;
                             }
                             var grade = '';
                             
                             if(sscore>=90){
                                grade = 'A'
                             }else if(sscore>=70){
                                grade = 'B'
                             }else if(sscore>=60){
                                grade = 'C'
                             }else if(sscore>=50){
                                grade = 'D'
                             }else if(sscore>=1){
                                grade = 'F'
                             }else{
                                grade = ''
                             }
                             // 해당 테이블 셀에 등급 업데이트
                             $("#grade" + index).text(grade);
                             
                             upEnscore(sscore,grade,'${lecture.lecno}',sno)
                           }
                         }
                        
                        function upEnscore(sscore,grade,lecno,sno){
                           $.ajax({
                              type: "POST",
                              url:"/setSscore",
                              data:{
                                 sscore: sscore,
                                 grade: grade,
                                 lecno: lecno,
                                 sno: sno
                              },
                              dataType:"text",
                              success: function (data) {
                                 console.log(data)
                              },error: function (err) {
                                     console.log(err);
                                     // Handle form submission error here
                                 }
                              
                           })
                        }
                        </script>
                     </div>
                     </div>
                     <hr>
                  </div>
               </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary"
                        data-dismiss="modal">닫기</button>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
            <!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; Orbit ERP presented by TEAM FOUR</span>
					</div>
				</div>
			</footer>
            <!-- End of Footer -->

         <!-- End of Content Wrapper -->

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
      <script
         src="${path}/a00_com/vendor/jquery-easing/jquery.easing.min.js"></script>

      <!-- Custom scripts for all pages-->
      <script src="${path}/a00_com/js/sb-admin-2.min.js"></script>
      <!-- 추가 plugins:js -->
      <script src="${path}/a00_com/vendor/datatables/jquery.dataTables.js"></script>
      <script
         src="${path}/a00_com/vendor/datatables/dataTables.bootstrap4.js"></script>
      <script src="${path}/a00_com/js/dataTables.select.min.js"></script>
</body>
</html>