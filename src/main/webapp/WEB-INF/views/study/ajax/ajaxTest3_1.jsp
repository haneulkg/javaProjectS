<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ajaxTest3_1.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	
   	$(function(){
			$("#dodo").change(function(){ 
				let dodo = $("#dodo").val();
				if(dodo == "") {
					alert("지역을 선택하세요");
					return false;
				}
				$.ajax({
					url  : "${ctp}/study/ajax/ajaxTest3_1",
					type : "post",
					data : {dodo : dodo},
					success : function(res) {
						let str = '<option>도시선택</option>';
						for(let i=0; i<res.length; i++) {
							if(res[i] == null) break;
							str += '<option>'+res[i]+'</option>';
						}
						$("#city").html(str);
					},
					error : function() {
						alert("전송오류");
					}
				});
			});
		}); 

  	
  	function fCheck() {
			let dodo = $("#dodo").val();
			let city = $("#city").val();
			
			if(dodo == "" || city == "") {
				alert("지역을 선택하세요");
				return false;
			}
			let str = "선택한 지역 : <b>" + dodo +"</b><br/>선택한 도시 : <b>" + city+"</b><br/>";
			str += '<input type="button" value="🔍" onclick="location.reload()" class="btn btn-outline-secondary btn-sum" />';
			$("#demo").html(str);
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>ajaxTest3_1.jsp (AJax - 문자열 배열처리)</h2>
  <hr/>
  <form>
  	<h3>지역을 선택하세요</h3>
  	<br/>
  	<select name="dodo" id="dodo" class="form-control">
  		<option value="">지역선택</option>
  		<option>서울</option>
  		<option>경기</option>
  		<option>충북</option>
  		<option>충남</option>
  	</select>&nbsp;
  	<select name="city" id="city" class="form-control">
  		<option>도시선택</option>
  	</select>&nbsp;&nbsp;
  	<input type="button" value="🔍" onclick="fCheck()" class="btn btn-outline-info form-control mb-2" />
  	<input type="button" value="이전으로" onclick="location='ajaxForm';" class="btn btn-outline-secondary form-control" />
  </form>
	<br/>
  <div id="demo"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>