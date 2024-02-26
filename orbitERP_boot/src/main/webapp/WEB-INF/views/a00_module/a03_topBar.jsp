<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<%@ page import="jakarta.servlet.http.HttpSession"%>
<!-- 실시간 알림용 스크립트 -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs/lib/stomp.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script type="text/javascript">
   var socket = new SockJS('/ws');
   var stompClient = Stomp.over(socket);
   var empno="${emem.empno}"

   stompClient.connect({}, function(frame) {
        console.log('Connected: ' + frame);
        stompClient.subscribe('/topic/greetings', function(greeting){
            //console.log(greeting.body);
            //console.log(JSON.parse(greeting.body).content);
            var obj = JSON.parse(greeting.body);
            //console.log(obj) //{rename: '김길동', msg: '너 이름이 뭐야?'}
            var curName = document.getElementById('curName').value;
            //접속중인 내가 보내고 싶은 사람 이름하고
            if(curName==obj.rename){ //현재 사람하고 이름이 같으면
               const Toast = Swal.mixin({
                   toast: true,
                   position: 'top-right',
                   showConfirmButton: false,
                   timer: 1500,
                   timerProgressBar: true,
                   didOpen: (toast) => {
                       toast.addEventListener('mouseenter', Swal.stopTimer)
                       toast.addEventListener('mouseleave', Swal.resumeTimer)
                   }
               })
   
               Toast.fire({
                   icon: 'info',
                   title: '새로운 알림이 도착했습니다.\n('+obj.msg+')'
               })
               realram(obj.rename)
            }

        });
    });
   
   function sendName() {
        var rename = document.getElementById('rename').value; // 보낼사람 이름
        var msg = document.getElementById('msg').value; // 보낼 메시지
        stompClient.send("/app/hello", {}, JSON.stringify({'rename': rename, 'msg':msg}));
    }
   
   function receiverList(receivers,msg){ //받는사람 리스트 받아오기
         document.getElementById('msg').value = msg;
      receivers.forEach(function(receiver) {
         document.getElementById('rename').value = receiver.empno;
         sendName()
      });
   }
   
   
   $(document).ready(function() {
      var auth = "${emem.auth}";
       if(auth==null || auth =="") {
          alert("로그인이 필요한 페이지입니다.\n 로그인 화면으로 이동합니다.")
           window.location.href = "${path}/login";
       }
      realram(empno)
   });
   
   function realram(empno){
      //탑바로 정보 보내기
      $.ajax({
         type: "POST",
            url: "/topAlram",
            data: { receiver: empno },
            dataType: "json",
            success: function (data) {
               var alList=data.alList
               $("#length").text(alList.length)
                  var dropdownMenu = $("#alDropdown");
                  var newAnchor = "";
                  dropdownMenu.empty();
                  if(alList.length==0){
                     newAnchor +='<a class="dropdown-item d-flex align-items-center"><h6>알림이 없습니다.</h6></a>'
                  }else{
                     $.each(alList, function (idx, alram) {
                        if(idx<5){
                           newAnchor += '<a class="dropdown-item d-flex align-items-center" onclick="checkUp(' + alram.idx + ')">'
                           newAnchor += '<div class="mr-3" style="min-height: 60px; display: flex; align-items: center;">'
                           newAnchor += '<div class="icon-circle bg-'+alram.color+'">'
                           newAnchor += '<i class="text-white fas fa-'+alram.icon+'"></i></div></div>'
                           newAnchor += '<div><div class="small text-gray-500">'+alram.sender +'&nbsp;&nbsp;&nbsp;&nbsp;'+alram.create_date+'</div>'
                           newAnchor += '<span class="font-weight-bold">'+alram.altitle+'</span></div></a>'
                        }
                      })
                  }
                  dropdownMenu.append(newAnchor);
            },
            error: function (err) {
                console.log(err);
                // Handle form submission error here
            }
      })
   }
   function checkUp(idx){
      $.ajax({
         type:"POST",
         url:"/checkUp",
         data:{idx:idx},
         success: function (data) {
            $("#ck1_"+idx).css('background-color', '#f0f0f0');
            $("#ck2_"+idx).text('읽음')
            realram(empno)
            alDtail(idx)
            },
            error: function (err) {
                console.log(err);
           }
      })
      
   }
   function alDtail(idx){
      $.ajax({
         type:"POST",
         url:"/alDtail",
         data:{idx:idx},
         success: function (data) {
            var alram=data.alram
            //모달값 리셋
            $("[name=title]").val(alram.altitle)
            $("[name=sender]").val(alram.sender)
            $("[name=create_date]").val(alram.create_date)
            $("[name=category]").val(alram.alcategory)
            $("[name=content]").val(alram.alcontent)
            $("#alarmModal").click()
            },
            error: function (err) {
                console.log(err);
           }
      })
   }
</script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<style>
.custom-badge {
    padding: 0.25em 0.6em;
    font-size: 90%;
    font-weight: 700;
    line-height: 1;
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;
    border-radius: 0.375rem;
    /* 추가적인 스타일링 */
}
</style>
<nav
   class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow" id="hiden">
   <!-- 알림보내기위해 숨김처리된 입력창 -->
   <div id="al">
   <input id="curName" value="${emem.empno }"/><br>
    <input id="rename" value="" /><br>
    <input id="msg" value=""/><br>
   </div>
   <script>
   document.getElementById('al').style.display = 'none'; //숨김처리
   </script>
       
   <!-- Sidebar Toggle (Topbar) -->
   <button id="sidebarToggleTop"
      class="btn btn-link d-md-none rounded-circle mr-3">
      <i class="fa fa-bars"></i>
   </button>

   <!-- Topbar Search 
   <form
      class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
      <div class="input-group">
         <input type="text" class="form-control bg-light border-0 small"
            placeholder="Search for..." aria-label="Search"
            aria-describedby="basic-addon2">
         <div class="input-group-append">
            <button class="btn btn-primary" type="button">
               <i class="fas fa-search fa-sm"></i>
            </button>
         </div>
      </div>
   </form>-->

   <!-- Topbar Navbar -->
   <ul class="navbar-nav ml-auto">

      <!-- Nav Item - Search Dropdown (Visible Only XS) -->
      <li class="nav-item dropdown no-arrow d-sm-none"><a
         class="nav-link dropdown-toggle" href="#" id="searchDropdown"
         role="button" data-toggle="dropdown" aria-haspopup="true"
         aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
      </a> <!-- Dropdown - Messages -->
         <div
            class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
            aria-labelledby="searchDropdown">
            <form class="form-inline mr-auto w-100 navbar-search">
               <div class="input-group">
                  <input type="text" class="form-control bg-light border-0 small"
                     placeholder="Search for..." aria-label="Search"
                     aria-describedby="basic-addon2">
                  <div class="input-group-append">
                     <button class="btn btn-primary" type="button">
                        <i class="fas fa-search fa-sm"></i>
                     </button>
                  </div>
               </div>
            </form>
         </div></li>

      <!-- Nav Item - Alerts -->
      <li class="nav-item dropdown no-arrow mx-1"><a
         class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
         role="button" data-toggle="dropdown" aria-haspopup="true"
         aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts -->
            <span class="badge badge-danger badge-counter" id="length"></span>
      </a> <!-- Dropdown - Alerts -->
         <div
            class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
            aria-labelledby="alertsDropdown">
            <h6 class="dropdown-header">알림</h6>
               <div id="alDropdown"></div>
            <a class="dropdown-item text-center small text-gray-500" href="alramAll?receiver=${emem.empno}">
               전체보기</a>
         </div></li>

      <!-- Nav Item - User Information -->
      <li class="nav-item dropdown no-arrow"><a
         class="nav-link dropdown-toggle" href="#" id="userDropdown"
         role="button" data-toggle="dropdown" aria-haspopup="true"
         aria-expanded="false"> <span
            class="mr-2 d-none d-lg-inline text-gray-600 small" data-toggle="tooltip" title="부서: ${emem.dname}">
            <c:choose>
                <c:when test="${emem.auth == '총괄관리자'}">
                    <span class="badge badge-primary custom-badge">${emem.auth}</span>
                </c:when>
                <c:when test="${emem.auth == '재무관리자' or emem.auth == '시스템관리자' 
                            or emem.auth == '계획관리자' or emem.auth == '인사관리자'}">
                    <span class="badge badge-warning custom-badge">${emem.auth}</span>
                </c:when>
                <c:otherwise>
                    <span class="badge badge-success custom-badge">${emem.auth}</span>
                </c:otherwise>
            </c:choose>
            ${emem.ename}님 접속중..</span>
             <img class="img-profile rounded-circle"
            src="${path}/a00_com/img/undraw_profile.svg">
      </a> <!-- Dropdown - User Information -->
         <div
            class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
            aria-labelledby="userDropdown">
            <a class="dropdown-item" href="${path}/mypage?empno=${emem.empno}"> <i
               class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> Profile
            </a> 
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#" data-toggle="modal"
               data-target="#logoutModal"> <i
               class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
               로그아웃
            </a>
         </div></li>

   </ul>
</nav>

   <!-- Modal -->
<button id="alarmModal" class="btn btn-success d-none"
               data-toggle="modal" data-target="#alModal" type="button">등록</button>
<div class="modal fade" id="alModal" tabindex="-1" role="dialog" aria-labelledby="alarmModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header text-white" style="background-color: #4E7CD9;">
    <h5 class="modal-title" id="alarmModalLabel" >알림</h5>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
     <div class="modal-body" id="detail">
    <div class="form-group">
        <label for="title">제목</label>
        <input type="text" class="form-control" id="title" name="title" value="" readonly>
    </div>
    <div class="form-group">
        <label for="senderAndCreateDate">보낸사람&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작성일시</label>
        <div class="d-flex">
            <input type="text" class="form-control flex-grow-1 mr-2" id="sender" name="sender" value="" readonly>
            <input type="text" class="form-control" id="create_date" name="create_date" value="" readonly>
        </div>
    </div>
    <div class="form-group">
        <label for="category">카테고리</label>
        <input type="text" class="form-control" id="category" name="category" value="" readonly>
    </div>
    <div class="form-group">
        <label for="content">내용</label>
        <textarea class="form-control" id="content" name="content" rows="4" readonly></textarea>
    </div>
</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>