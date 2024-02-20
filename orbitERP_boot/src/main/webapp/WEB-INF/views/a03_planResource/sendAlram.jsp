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
 <style type="text/css">
 body {
  background-color: #f5f5f5;
}
 .notification-form {
  color: #333333;
  padding: 20px 30px;
}

.header {
 padding: 10px 0
 }
.input-group-text {
  width: 90px;
}
#sendBtn {
  float: right;
}
 </style>
<!-- jQuery -->
<script src="${path}/a00_com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});
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
<div class="notification-form">
  <div class="header">
    <h5>알림보내기페이지</h5>
  </div>
  <div class="body">
    <form id="frm01" class="form" method="post">
      <input type="hidden" name="id" value="0" />
      <div class="input-group mb-3">
        <label for="title" class="input-group-text">제목</label>
        <input type="text" name="title" class="form-control" />
      </div>
      <div class="input-group mb-3">
        <label for="sender" class="input-group-text">보내는사람</label>
        <input type="text" id="sender" readonly class="form-control" value="${sender}" />
      </div>
      <div class="input-group mb-3">
        <label for="receiver" class="input-group-text">받는사람</label>
        <input type="text" id="receiver" class="form-control" />
      </div>
      <div class="input-group mb-3">
        <label for="category" class="input-group-text">카테고리</label>
        <select name="category" class="form-control">
          <option value="">선택</option>
          <option value="공지">공지사항</option>
          <option value="회의">회의</option>
          <option value="일정">일정</option>
          <option value="개인">개인</option>
          </select>
      </div>
      <div class="input-group mb-3">
        <label for="content" class="input-group-text">내용</label>
        <textarea id="content" name="content" class="form-control" rows="8"></textarea>
      </div>
    </form>
  </div>
    <button type="button" id="sendBtn" class="btn btn-primary">보내기</button>
</div>

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