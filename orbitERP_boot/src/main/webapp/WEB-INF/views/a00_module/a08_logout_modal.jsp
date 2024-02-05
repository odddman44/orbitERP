<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<%@ page import="jakarta.servlet.http.HttpSession"%>

<script type="text/javascript">
$(document).ready(function() {
    $("#lgBtn").click(function() {
        alert("${emem.ename}님, 로그아웃되었습니다!");
        window.location.href = "${path}/logout";
    });
});
</script>

<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			
			<div class="modal-body">로그아웃 하시겠습니까?</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">돌아가기</button>
				<a class="btn btn-primary" id="lgBtn">로그아웃</a>
			</div>
		</div>
	</div>
</div>