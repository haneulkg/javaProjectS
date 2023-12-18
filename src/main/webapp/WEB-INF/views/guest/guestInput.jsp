<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>guestInput.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<p><br/></p>
	<div class="container">
		<h2 style="text-align: center">글쓰기</h2>
		<br/><br/>
		<form name="myform" method="post">
			<table class="table table-bordered">
				<tr>
					<th style="width: 200px">성명</th>
					<td><input type="text" name="name" id="name" class="form-control" required autofocus></td>
				</tr>
				<tr>
					<th>이메일 주소 </th>
					<td><input type="text" name="email" id="email" class="form-control" required></td>
				</tr>
				<tr>
					<th>홈페이지 주소</th>
					<td><input type="text" name="homePage" id="homePage" class="form-control" value="https://" required></td>
				</tr>
				<tr>
					<td colspan="2"><textarea name="content" id="content" rows="10" class="form-control" required></textarea></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" class="btn btn-outline-success form-control"/></td>
				</tr>
				<tr>
					<td colspan="2"><input type="reset" class="btn btn-outline-warning form-control"/></td>
				</tr>
				<tr>
					<td colspan="2"><a href="guestList" class="btn btn-outline-secondary form-control">이전으로</a></td>
				</tr>
			</table>
			<input type="hidden" name="hostIp" value="<%=request.getRemoteAddr() %>" />
		</form>
	</div>
	<p><br/></p>
  <jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>