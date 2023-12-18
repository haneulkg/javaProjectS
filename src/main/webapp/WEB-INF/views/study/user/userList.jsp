<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>userList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  
  	function userDelete(idx) {
			let ans = confirm("선택한 회원을 삭제하시겠습니까 ?");
			if(!ans) return false;
			else location.href="userDelete?idx="+idx;			
		}
  	
  	function nameSearch() {
			let name = document.getElementById("name").value;
			location.href= "userSearch?name="+name;
		}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">회원 리스트</h2>
  <br/>
  <div class="text-right">
  	개별검색&nbsp;:&nbsp; 
  		<input type="text" name="name" id="name" />&nbsp;
  		<input type="button" value="🔍" onclick="nameSearch()" class="btn btn-outline-warning" />
  </div>
  <br/>
  <table class="table table-hover">
  	<tr style="background-color: #EDC6C6">
  		<th>번호</th>
  		<th>아이디</th>
  		<th>성명</th>
  		<th>나이</th>
  		<th>주소</th>
  		<th>비고</th>
  	</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${vo.idx}</td>
				<td>${vo.mid}</td>
				<td>${vo.name}</td>
				<td>${vo.age}</td>
				<td>${vo.address}</td>
				<td><a href="javascript:userDelete(${vo.idx})" class="btn btn-outline-danger btn-sm">삭제</a></td>
			</tr>
		</c:forEach>
		<tr><td colspan="6" class="m-0 p-0"></td></tr>
  </table>
  <br/>
  <div><a href="${ctp}/" class="btn btn-outline-secondary form-control">HOME</a></div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>