<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>boardUpdate.jsp</title>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<style>
		text-align: center;
		background-color: lightgray;
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<p><br/></p>
	<div class="container">
		<h2 class="text-center">게시판 수정하기</h2>
		<form name="myform" method="post">
			<table class="table table-bordered">
				<tr>
					<th>글쓴이</th>
					<td>${sNickName}</td>
				</tr>
				<tr>
					<th>글제목</th>
					<td><input type="text" name="title" id="title" value="${vo.title}" autofocus required class="form-control"/></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="email" id="email" value="${vo.email}" class="form-control"/></td>
				</tr>
				<tr>
					<th>홈페이지</th>
					<td><input type="text" name="homePage" id="homePage" value="${vo.homePage}" class="form-control"/></td>
				</tr>
				<tr>
					<th>글내용</th>
					<td><textarea rows="6" name="content" id="CKEDITOR" class="form-control" required>${vo.content}</textarea></td>
					<script>
						CKEDITOR.replace('content',{
							height:470,
							filebrowserUploadUrl:'${ctp}/imageUpload', 	/* 파일(이미지) 업로드시에 매핑경로 */
							uploadUrl : "${ctp}/imageUpload"						/* 여러개의 파일 업로드 */
						});
					</script>
				</tr>
				<tr>
					<th>공개여부</th>
					<td>
						<input type="radio" name="openSw" value="OK" <c:if test="${vo.openSw == 'OK'}">checked</c:if> />공개 &nbsp;
						<input type="radio" name="openSw" value="NO" <c:if test="${vo.openSw == 'NO'}">checked</c:if>  />비공개 &nbsp;
 					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<input type="submit" value="글수정하기" class="btn btn-outline-success"/> &nbsp; 
						<input type="reset" value="다시입력" class="btn btn-outline-info"/> &nbsp; 
						<input type="button" onclick="location.href='boardList?pag=${pag}&pageSize=${pageSize}';" value="돌아가기" class="btn btn-outline-secondary"/> &nbsp; 
					</td>
				</tr>
			</table>
			<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}" />
			<input type="hidden" name="idx" value="${vo.idx}"/>
			<input type="hidden" name="nickName" value="${sNickName}"/>
			<input type="hidden" name="pag" value="${pag}"/>
			<input type="hidden" name="pageSize" value="${pageSize}"/>
		</form>
	</div>
	<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>