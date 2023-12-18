<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>user2List.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  
  	function userDelete(idx) {
			let ans = confirm("선택한 회원을 삭제하시겠습니까 ?");
			if(!ans) return false;
			else location.href="user2Delete?idx="+idx;			
		}
  	
  	function nameSearch() {
			let name = document.getElementById("name").value;
			location.href= "user2Search?name="+name;
		}
  	
  	function fNewForm() {
			let str = '';
			str += '<form method="post">';
			str += '<table class="table table-bordered">';
			str += '<tr>';
			str += '<th>아이디</th>';
			str += '<td><input type="text" name="mid" class="form-control" required /></td>';
			str += '</tr>';
			str += '<tr>';
			str += '<th>성명</th>';
			str += '<td><input type="text" name="name" class="form-control" required /></td>';
			str += '</tr>';
			str += '<tr>';
			str += '<th>나이</th>';
			str += '<td><input type="text" name="age" value="20" class="form-control" /></td>';
			str += '</tr>';
			str += '<tr>';
			str += '<th>주소</th>';
			str += '<td><input type="text" name="address" class="form-control" /></td>';
			str += '</tr>';
			str += '<tr>';
			str += '<td colspan="2" class="text-center"><input type="submit" value="회원가입" class="btn btn-outline-secondary" />&nbsp;&nbsp;&nbsp;';
			str += '<input type="button" onclick="fNewFormHidden()" value="가입취소" class="btn btn-outline-danger" /></td>';
			str += '</tr>';
			str += '</table>';
			str += '</form>';
			document.getElementById("demo").innerHTML = str;
		}
  	
  	function fNewFormHidden() {
			document.getElementById("demo").innerHTML = "";
		}
  	
  	function userUpdate(idx,name,age,address) {
			$("#myModal .modal-body #idx").val(idx);
			$("#myModal .modal-body #name").val(name);
			$("#myModal .modal-body #age").val(age);
			$("#myModal .modal-body #address").val(address);
		}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">회원 리스트 2</h2>
  <br/>
  <div class="row">
  	<div class="col-7">
			<input type="button" value="회원가입" onclick="fNewForm()" class="btn btn-outline-info" /> 
  	</div>
  	<div class="col-5">
  		<div class="input-group">
		  		<input type="text" value="${name}" name="name" id="name" class="form-control mb-2"/>&nbsp;&nbsp;&nbsp;
		  		<div class="input-group-append"><input type="button" value="🔍" onclick="nameSearch()" class="btn btn-outline-warning" /></div>
	  	</div>
  	</div>
  </div>
  <br/>
  <div id="demo"></div>
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
				<td>
					<a href="#" onclick="userUpdate('${vo.idx}','${vo.name}','${vo.age}','${vo.address}')" class="btn btn-outline-secondary btn-sm" data-toggle="modal" data-target="#myModal">수정</a>
					<a href="javascript:userDelete(${vo.idx})" class="btn btn-outline-danger btn-sm">삭제</a>
				</td>
			</tr>
		</c:forEach>
		<tr><td colspan="6" class="m-0 p-0"></td></tr>
  </table>
  <br/>
  <div><a href="${ctp}/" class="btn btn-outline-secondary form-control">HOME</a></div>
</div>

<!-- The Modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">회원정보수정</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
				<form method="post" action="${ctp}/user2/user2Update">
					<div>성명 : <input type="text" name="name" id="name" class="form-control mb-2" required></div>
					<div>나이 : <input type="number" name="age" id="age" class="form-control mb-2"></div>
					<div>주소 : <input type="text" name="address" id="address" class="form-control mb-2"></div>
					<div><input type="submit" value="수정" class="form-control btn btn-outline-secondary"/></div>
					<div><input type="hidden" name="idx" id="idx" /></div>
				</form>
      </div> 
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-danger" data-dismiss="modal">Close</button>
      </div>
      
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>