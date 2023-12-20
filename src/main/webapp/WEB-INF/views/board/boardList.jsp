<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>boardList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
		'use strict';
	
		function pageSizeCheck() {
			let pageSize = $("#pageSize").val();
			location.href="boardList?pageSize="+pageSize;
		}
	</script>
	<style>
		.page-link {
		  color: #000; 
		  background-color: #fff;
		  border: 1px solid #ccc; 
		}
		
		.page-item.active .page-link {
		 z-index: 1;
		 color: black;
		 font-weight:bold;
		 background-color: gray;
		 border-color: #ccc;
		 
		}
		
		.page-link:focus, .page-link:hover {
		  color: #000;
		  background-color: lightgray; 
		  border-color: #ccc;
		}	
	</style>	
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<p><br/></p>
	<div class="container">
		<table class="table table-borderless m-0 p-0">
			<tr>
		   		<td colspan="2"><h2 class="text-center">게시판 리스트</h2></td>
			</tr>
			<tr>
				<td>
					<a href="boardInput" class="btn btn-outline-secondary btn-sm">글쓰기</a>
				<td class="text-right">
					<select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
						<option ${pageSize==3? "selected" : ""}>3</option>
						<option ${pageSize==5? "selected" : ""}>5</option>
						<option ${pageSize==10? "selected" : ""}>10</option>
						<option ${pageSize==15? "selected" : ""}>15</option>
						<option ${pageSize==20? "selected" : ""}>20</option>
					</select>건
				</td>
			</tr>
		</table>
		<table class="table table-hover text-center">
			<tr class="table-dark text-dark">
				<th>글번호</th>
				<th>글제목</th>
				<th>글쓴이</th>
				<th>글쓴날짜</th>
				<th>조회수(좋아요)</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${curScrStartNo}</td>
					<td class="text-left">
						<a href="boardContent?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">${vo.title}</a>
						<c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
						<c:if test="${vo.replyCnt != 0 }">(${vo.replyCnt})</c:if> 
					</td>
					<td>${vo.nickName}</td>
					<td>
						<c:if test="${vo.hour_diff <= 24}">
							<c:if test="${vo.day_diff < 1}">
								${fn:substring(vo.WDate,11,19)}
							</c:if>
							<c:if test="${vo.day_diff >= 1}">
								${fn:substring(vo.WDate,0,10)}
							</c:if>
						</c:if>
						<c:if test="${vo.hour_diff > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
					</td>
					<td>${vo.readNum}(${vo.good })</td>
				</tr>
				<tr><td colspan="5" class="m-0 p-0"></td></tr>
			 	<c:set var="curScrStartNo" value="${curScrStartNo-1}"></c:set>
			</c:forEach>			
		</table>
	</div>
		<!-- 블록페이지 시작(1블록의 크기를 3개(3Page)로 한다, 한페이지 기본은 5개  -->
		<div class="text-center">
		
			<ul class="pagination justify-content-center" style="margin:20px 0">
			
				<li class="page-item">
					<c:if test = "${curBlock > 0}">
						<a class="page-link" href="boardList?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageSize}"> << </a>
					</c:if>
				</li>
	
				
				<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" varStatus="st">
					
						<c:if test="${i<=totPage}">
						
							<c:if test="${i==pag}">
								<li class="page-item active">
									<a class="page-link" href = "boardList?pag=${i}&pageSize=${pageSize}">${i}</a>
								</li>
							</c:if>
							
							<c:if test="${i!=pag}">
								<li class="page-item">
									<a class="page-link" href = "boardList?pag=${i}&pageSize=${pageSize}">${i}</a>
								</li>
							</c:if>
							
						</c:if>
						
				</c:forEach>
				<c:if test = "${curBlock < lastBlock}">
					<li class="page-item">
						<a class="page-link" href="boardList?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}"> >> </a>
					</li>
				</c:if>
			</ul>
		</div>
		<p><br/></p>
		<!-- 검색기 처리하기 -->
		<div class="container text-center">
			<form name="searchForm" id="searchForm" method="post" action="boardSearch">
				<b>검색 : </b>
				<select name="search" id="search">
					<option value="title" selected>글제목</option>
					<option value="nickName">글쓴이</option>
					<option value="content">글내용</option>
				</select>
				<input type="text" name="searchString" id="searchString"/>
				<input type="submit" value="검색" class="btn btn-secondary btn-sm"/>
				<input type="hidden" name="pag" value="${pag}"/>
				<input type="hidden" name="pageSize" value="${pageSize}"/>
 			</form>
		</div>			
	<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>