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
<title>EmployeeUpdateForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
</head>
<body>

<!----------------------------------------------------------------------------
   #25. EmployeeUpdateForm.jsp	2022-11-18 
  - 직원 데이터 수정 폼 페이지.
  - 관리자가 접근하는 직원 데이터 수정 폼 페이지
------------------------------------------------------------------------------->

<div>

	<!-- 메뉴 영역 -->
	<div>
		<c:import url="EmployeeMenu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
	
		<h1>[직원 관리] > [수정]</h1>
		<hr>
		
		<form action="employeeupdate.action" method="post" id="employeeForm">
			<table>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="name" id="name" placeholder="이름을 입력하세요" value="${dto.name }"/>
					</td>
				</tr>
				<tr>
					<th>주민번호</th>
					<td>
						<input type="text" name="ssn1" id="ssn1" 
						style="width: 100px;" value="${dto.ssn1 }"/>
						- <input type="text" name="ssn2" id="ssn2" 
						style="width: 110px;"/>
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>
						<input type="text" name="birthday" id="birthday" placeholder="생년월일" value="${dto.birthday }"/>
					</td>
				</tr>
				<tr>
					<th>양/음력</th>
					<td>
						<input type="radio" value="0" name="lunar" id="lunar0" 
						checked="checked"/>
						<label for="lunar0">양력</label>
						<input type="radio" value="1" name="lunar" id="lunar1"/>
						<label for="lunar1">음력</label>
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="tel" name="telephone" id="telephone"
						 placeholder="ex) 010-1234-1234" value="${dto.telephone }"/>
					</td>
				</tr>
				<tr>
					<th>지역</th>
					<td>
						<select id="regionId" name="regionId">
							<!-- 
							<option value="1">마포</option>
							<option value="2">서초</option>
							<option value="3">은평</option>
							 -->
							 <c:forEach var="region" items="${regionList }">
							 <c:if test="${region.regionId == employee.regionId }">
							 	<option value="${region.regionId }" selected="selected">
							 		${region.regionName }
							 	</option>
							 </c:if>
							 </c:forEach>
							 
						</select>
					</td>
				</tr>
				<tr>
					<th>부서</th>
					<td>
						<select id="departmentId" name="departmentId">
							<!-- 
							<option value="1">독서부</option>
							<option value="2">바둑부</option>
							<option value="3">축구부</option>
							 -->
							 <c:forEach var="department" items="${departmentList }">
							 <c:if test="${department.departmentId == employee.departmentId }">
							 	<option value="${department.departmentId }" selected="selected">
							 		${department.departmentName }
							 	</option>
							 </c:if>
							 </c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>직위</th>
					<td>
						<select id="positionId" name="positionId">
						<!-- 
							<option value="1">반장</option>
							<option value="2">부반장</option>
							<option value="3">팀장</option>
						 -->
						 	<c:forEach var="position" items="${positionList }">
						 		<option value="${position.positionId }">
						 			${position.positionName }
						 		</option>
						 	</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>기본급</th>
					<td>
						<input type="text" id="basicPay" name="basicPay" value="${dto.basicPay }"/>
						(최소기본급
						 <span id="minBasicPay" 
						 style="color: red; font-weight: bold;">0</span>
						 원)
					</td>
				</tr>
				<tr>
					<th>수당</th>
					<td>
						<input type="text" id="extraPay" name="extraPay" value="${dto.extraPay }" />
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<br><br>
					
						<button type="button" class="btn" id="submitBtn"
						style="width: 40%;"
						onclick="location.href='employeelist.action'">
						수정 하기</button>
						<button type="button" class="btn" id="listBtn"
						style="width: 40%;"
						onclick="location.href='employeelist.action'">
						직원 리스트</button>
						<br><br>
					
						<span id="err" style="color: red; font-weight: bold; display: none;"  >
						</span>
					</td>
				</tr>
			</table>
		</form>
		
	</div>
</div>

	<!-- 회사 소개및 어플리케이션 소개 영역 -->
	<div id="footer">
		 
	</div>


</body>
</html>