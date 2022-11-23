<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EmpList.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/jquery-ui.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">


<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/jquery-ui.js"></script>


</head>
<body>

<!------------------------------------------------
  - #33. EmpList.jsp		2022-11-23
  - 직원 리스트 출력 페이지.
  - 일반직원이 접근하는 직원 리스트 출력 페이지
--------------------------------------------------->

<div align="left">

	<!-- 메뉴 영역 -->
	<div>
		<c:import url="EmployeeMenu.jsp"></c:import>
	</div>
	<br>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
	
		<label>직원 정보 > 직원 리스트</label>
		<hr>
	
		
		<!--------------------------------------------------
		EMPLOYEEID, NAME, SSN, BIRTHDAY, LUNARNAME
		, TELEPHONE , DEPARTMENTNAME, POSITIONNAME, REGIONNAME
		 ---------------------------------------------------->
		<table id="coutomers" class="table">
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>주민번호</th>
				<th>생년월일</th>
				<th>양/음력</th>
				<th>전화번호</th>
				<th>지역</th>
				<th>부서</th>
				<th>직위</th>
			</tr>
			
			<!-- 
			<tr>
				<td>1</td>
				<td>조현하</td>
				<td>981212</td>
				<td>1998-12-12</td>
				<td>양력</td>
				<td>010-1234-1234</td>
				<td>서울</td>
				<td>개발부</td>
				<td>사원</td>
	
			</tr>
			
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>주민번호</th>
				<th>생년월일</th>
				<th>양/음력</th>
				<th>전화번호</th>
				<th>지역</th>
				<th>부서</th>
				<th>직위</th>

			</tr>
			<tr>
				<td>2</td>
				<td>정영준</td>
				<td>991111</td>
				<td>1999-11-11</td>
				<td>양력</td>
				<td>010-2345-2345</td>
				<td>경기</td>
				<td>인사부</td>
				<td>사원</td>

			</tr>
		 -->
		 
		 <%--
		 <c:forEach var="employee" items="${employeeList }">
		 <tr>
		 	<td>${employee.employeeId }</td>
		 	<td>${employee.name }</td>
		 	<td>${employee.ssn }-*******</td>
		 	<td>${employee.birthday }</td>
		 	<td>${employee.lunarName }</td>
		 	<td>${employee.telephone }</td>
		 	<td>${employee.regionName }</td>
		 	<td>${employee.departmentName }</td>
		 	<td>${employee.positionName }</td>
		 </tr>
		 </c:forEach>
		
		 --%>
		 
		 <c:forEach var="employee" items="${employeeList }">
		 <tr>
		 	<td>${employee.employeeId }</td>
		 	<td>${employee.name }</td>
		 	<td>${employee.ssn1 }-*******</td>
		 	<td>${employee.birthday }</td>
		 	<td>${employee.lunarName }</td>
		 	<td>${employee.telephone }</td>
		 	<td>${employee.regionName }</td>
		 	<td>${employee.departmentName }</td>
		 	<td>${employee.positionName }</td>
		 </tr>
		 </c:forEach>
		</table>
		
	</div>
	
	
	<!-- 회사 소개및 어플리케이션 소개 영역 -->
	<div id="footer">
		 
	</div>
	
</div>


</body>
</html>