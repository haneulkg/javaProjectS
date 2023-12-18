<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ajaxTest4_1.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	
  	function fCheck1() {
			let mid = document.getElementById("mid").value;
			if(mid.trim() == "") {
				alert("아이디를 입력하세요");
				document.getElementById("mid").focus();
				return false;
			}
			
			$.ajax({
				url   : "${ctp}/study/ajax/ajaxTest4_1",
				type  : "post",
				data  : {mid : mid},
				success : function(vo) {
					let str = '<h5>VO로 전송된 자료 출력하기</h5>';
					if(vo != ''){
						str += '아이디 : <b>'+vo.mid+'</b><br/>';
						str += '성명 : <b>'+vo.name+'</b><br/>';
						str += '나이 : <b>'+vo.age+'</b><br/>';
						str += '주소 : <b>'+vo.address+'</b>';
					}
					else {
						str += '<b>찾으시는 아이디를 가진 회원이 존재하지 않습니다</b>';
					}
					
					$("#demo").html(str);
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
  	
  	function fCheck2() {
			let mid = document.getElementById("mid").value;
			if(mid.trim() == "") {
				alert("아이디를 입력하세요");
				document.getElementById("mid").focus();
				return false;
			}
			
			$.ajax({
				url   : "${ctp}/study/ajax/ajaxTest4_2",
				type  : "post",
				data  : {mid : mid},
				success : function(vos) {
					console.log(vos);
					let str = '<h5>VOS로 전송된 자료 출력하기</h5>';
					
					if(vos == '') {
						str += '<b>찾으시는 아이디를 가진 회원이 존재하지 않습니다</b>';
					}
					else {
						str += '<table class="table table-bordered text-center">';
						str += '<tr class="table-dark text-dark"><th>아이디</th><th>성명</th><th>나이</th><th>주소</th></tr>';
						for(let i=0; i<vos.length; i++) {
							str += '<tr>';
							str += '<td>'+vos[i].mid+'</td>';
							str += '<td>'+vos[i].name+'</td>';
							str += '<td>'+vos[i].age+'</td>';
							str += '<td>'+vos[i].address+'</td>';
							str += '</tr>';
						}
						str += '<tr><td colspan="4" class="m-0 p-0"></td></tr>';
						str += '</table>';
					}
						
					$("#demo").html(str);
				},
				error : function() {
					alert("전송오류");
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
  <h2>ajaxTest4_1.jsp (AJax - 개별검색(vo) 처리)</h2>
  <hr/>
  <form>
		<div>아이디 :
			<input type="text" name="mid" id="mid" class="form-control mb-3" required autofocus />
		</div>
		<div>
	  	<input type="button" value="아이디일치(vo)" onclick="fCheck1()" class="btn btn-outline-secondary form-control mb-2" />
	  	<input type="button" value="아이디부분일치(vos)" onclick="fCheck2()" class="btn btn-outline-secondary form-control mb-2" />
	  	<input type="button" value="다시입력" onclick="location.reload()" class="btn btn-outline-secondary form-control mb-2" />
	  	<input type="button" value="이전으로" onclick="location='ajaxForm';" class="btn btn-outline-info form-control" />
  	</div>
  </form>
	<br/>
  <div id="demo"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>