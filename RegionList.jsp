<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>  - #35. RegionList.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">


<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<style type="text/css">
	#coutomers
	{
		width: 40%;
	}

</style>
</head>
<body>

<!----------------------------------------------------------------------------
  #. RegionInsertForm.jsp		2022-11-16
  - 직원 리스트 출력 페이지.
  - 관리자가 접근하는 지역 리스트 출력 페이지
------------------------------------------------------------------------------->
<div>
	<div align="left">
	
		<!-- 메뉴 영역 -->
		<div>
			<c:import url="EmployeeMenu.jsp"></c:import>
		</div>
		<br>
		
		<label>지역 관리 > 지역 리스트</label>
		<hr>
	
		
		<!-- 콘텐츠 영역 -->
		<div id="content">
			<div>
				<form action="">
					<input type="button" value="지역 추가" class="btn btn-primary"
					onclick="location.href='regioninsertform.action'" >
				</form>
			</div>
			<br><br>
			<!------------------------------------
			 REGIONID REGIONNAME      DELCHECK              
			-------------------------------------->
			<table id="coutomers" class="table">
				<tr>
					<th>번호</th>
					<th style="width: 200px;">지역명</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				
			<%--
				<tr>
					<td>1</td>
					<td>서울</td>
				</tr>
					<tr>
						<c:forEach var="region" items="${rigionList }">
							<td>${region.regionId }</td>
							<td>${region.regionName }</td>
						
							<td>
						 		<button type="button"
						 		 class="btn btn-primary btnUpdate" 
						 		value="${region.regionId }">수정</button>
				 			</td>
					 		<td>
						 		<button type="button"
						 		 class="btn btn-primary btnDedate" 
						 		value="${employee.regionId }">삭제</button>
					 		</td>
						</c:forEach>
					</tr>
			--%>
			<c:forEach var="region" items="${regionList }">
				<tr>
					<td>${region.regionId }</td>
					<td>${region.regionName }</td>
					
					<td>
				 		<button type="button"
				 		 class="btn btn-primary btn-xs btnUpdate" 
				 		value="${region.regionId }">수정</button>
		 			</td>
			 		<td>
			 		
			 		
<!-- 				 		<button type="button" -->
<%-- 				 		value="${region.regionId }"  --%>
<%-- 				 		${region.delCheck==0 ? "class=\"btn btn-danger btn-xs btnDelete\"" : "class=\"btn btn-xs\""} --%>
<%-- 				 		${region.delCheck==0 ? "" : "disabled=\"disabled\""}>삭제</button> --%>
				 		
				 		
				 		<c:choose>
				 			<c:when test="${region.delCheck==0 }">
				 				<button type="button"
				 		 		class="btn btn-primary btnDelete" 
				 				value="${region.regionId }">삭제</button>
				 			</c:when>
				 			
				 			<c:otherwise>
				 				<button type="button"
				 		 		class="btn btn-primary btnDelete" 
				 				value="${region.regionId }" disabled="disabled">삭제</button>
				 			</c:otherwise>
				 		</c:choose>
				 		
			 		</td> 
				</tr>
			</c:forEach>				
				
					
			</table>

			
		</div>
	</div>
	
	<!-- 회사 소개및 어플리케이션 소개 영역 -->
	<div id="footer">
		 
	</div>
</div>
</body>
</html>