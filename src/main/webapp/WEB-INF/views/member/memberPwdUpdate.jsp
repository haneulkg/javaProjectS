<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberPwdUpdate.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	
  	$(function() {
			$("#pwdForm").hide();	
			$("#myform").show();
		});
  	
  	function pwdCheck() {
			let pwd = $("#pwd").val();
			
			if(pwd.trim() == "") {
				alert("현재 비밀번호를 입력해주세요.");
				$("#pwd").focus();
				return false;
			}
			
			$.ajax({
				type : "post",
				url  : "${ctp}/member/memberpwdCheck",
				data : {pwd : pwd},
				success : function(res) {
					if(res == "1") {
						$("#pwdForm").show();
						$("#myform").hide();
						$("#newPwd1").focus();
					}
					else {
						alert("비밀번호를 다시 확인해주세요.");
							$("#pwd").focus();
							return false;
					}
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
  	
  	function newPwd() {
			let newPwd1 = $("#newPwd1").val();
			let newPwd2 = $("#newPwd2").val();
			
			if(newPwd1 != newPwd2) {
				alert("새로운 비밀번호가 일치하지 않습니다, 확인 후 변경해주세요.");
				$("#newPwd1").focus();
				return false;
			} 
			
			$.ajax({
				type : "post",
				url  : "${ctp}/member/memberNewPwdUpdate",
				data : {newPwd : newPwd1},
				success : function(res) {
					if(res == "1") {
						alert("비밀번호가 변경되었습니다, 다시 로그인해주세요.");
						location.href="${ctp}/member/memberLogin";
					}
					else {
						alert("비밀번호 변경 실패, 다시 시도해주세요.");
						location.reload();
					}
				},
				error : function() {
					alert("전송 오류");
				}
			});
		}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<form name="myform" method="post">
		<div id="myform">
			<h3 class="text-center">비밀번호 변경</h3>
			<table class="table table-bordered">
				<tr>
					<th>현재 비밀번호 :</th>
					<td><input type="password" name="pwd" id="pwd" placeholder="현재 비밀번호를 입력해주세요." class="form-control" autofocus required /></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" value="비밀번호 확인" onclick="pwdCheck()" class="btn btn-outline-secondary form-control" /></td>
				</tr>
			</table>
		</div>
	</form>  
	<form name="pwdForm">
		<div id="pwdForm">
			<table class="table table-bordered">
				<tr>
					<th>새 비밀번호 :</th>
					<td><input type="password" name="newPwd1" id="newPwd1" placeholder="새 비밀번호를 입력해주세요." class="form-control" required/></td>
				</tr>
				<tr>
					<th>새 비밀번호 확인 :</th>
					<td><input type="password" name="newPwd2" id="newPwd2" placeholder="위의 비밀번호와 동일한 비밀번호를 입력해주세요." class="form-control" required/></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" value="비밀번호 변경" onclick="newPwd()" class="btn btn-outline-secondary form-control" /></td>
				</tr>
			</table>
		</div>
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>