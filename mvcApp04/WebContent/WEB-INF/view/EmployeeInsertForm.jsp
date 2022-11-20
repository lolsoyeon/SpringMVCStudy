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
<title>EmployeeInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/jquery-ui.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/jquery-ui.js"></script>

<!-- 
<script type="text/javascript">
	$(document).ready(function()
	{
		$("#basicPay").change(function()
		{
			alert("sdsd");
			var params = "basicPay=" + $("#basicPay").val();
			
			$.ajax(
			{
				type:"GET"
			  , url : "Ajax.jsp"
			  , data : params
			  , dataType : "json"
				
			});
			
		})
	});
</script>
 -->
<script type="text/javascript">
	$(function()
	{
		// AJAX 요청 및 응답 처리
		//ajaxRequert();
		ajaxRequest();
		
		// jquery-ui 캘린터 (datepicker)를 불러오는 함수 처리
		$("#birthday").datepicker(
		{
			dateFormat : "yy-mm-dd"				// yyyy-mm-dd (X)
			, changeYear : true
			, changeMonth : true
		});
		
		// 직위은 선택된 옵션이 변경되었을 경우 수행할 코드 처리
		$("#positionId").change(function()
		{
// 			alert("변경 확인");
			ajaxRequest();
			

		});
		
	});
	
	function ajaxRequest()
	{
		//『jquery.post()』 / 『jquery.get()』 
		//『$.post()』 / 『$.get()』 
		//--jQuery 에서 AJAX 를 사용해야 할 졍우 지원해주는 함수.
		//  (서버틍에서 요청한 데이터를 받아오는 기능의 함수)
		
		// ※ 이 함수(『$.post()』) 의 사용 방법(방식)
		//--『$.post(요청주소, 전송데이터, 응답액션 처리)』
		//  · 요청주소(url)
		// → 데이터를 요청할 파일에 대한 정보
		//  · 전송데이터(data)
		// → 서버 측에 요청사는 과정에서 내가 전달할 파라미터
		//  · 응답액션처리(function)
		// →  응답을 받을 수 있는 함수 → 단순 기능 구현 및 적용
		// ※ 참고로 data는 파라미터의 데이터 타입을 그대로 취하게 되므로
		//html 이든, 문자열 이든 상관이 없다.
		
		// $.post("Abc.jsp") 뷰 페이지가 아니라 컨트롤러에서 처리할수있도록한다.
		$.post("ajax.action", {positionId : $("#positionId").val()}, function(data)
		{
			//alert(data);
			$("#minBasicPay").html(data);
		} );
		
	}
</script>

</head>
<body>

<!----------------------------------------------------------------------------
   #20. EmployeeInsertForm.jsp 		2022-11-17
  - 직원 데이터 입력 폼 페이지.
  - 관리자가 접근하는 직원 데이터 입력 폼 페이지
------------------------------------------------------------------------------->

<div>

	<!-- 메뉴 영역 -->
	<div>
		<c:import url="EmployeeMeun.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
	
		<h1>[직원 관리] > [직원 정보 입력]</h1>
		<hr>
		
		<form action="" method="post" id="employeeForm">
			<table>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="name" id="name" placeholder="이름을 입력하세요"/>
					</td>
				</tr>
				<tr>
					<th>주민번호</th>
					<td>
						<input type="text" name="ssn1" id="ssn1" 
						style="width: 100px;"/>
						<input type="text" name="ssn2" id="ssn2" 
						style="width: 110px;"/>
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>
						<input type="text" name="birthday" id="birthday" placeholder="생년월일"/>
					</td>
				</tr>
				<tr>
					<th>양/음력</th>
					<td>
						<input type="radio" value="0" name="lunar" id="lunar0" checked="checked"/>
						<label for="lunar0">양력</label>
						<input type="radio" value="1" name="lunar" id="lunar1"/>
						<label for="lunar1">음력</label>
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="tel" name="telephone" id="telephone"
						 placeholder="ex) 010-1234-1234"/>
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
							 	<option value="${region.regionId }">
							 		${region.regionName }
							 	</option>
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
							 	<option value="${department.departmentId }">
							 		${department.departmentName }
							 	</option>
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
						<input type="text" id="basicPay" name="basicPay" />
						(최소기본급
						 <span id="minBasicPay" 
						 style="color: red; font-weight: bold;">0</span>
						 원)
					</td>
				</tr>
				<tr>
					<th>수당</th>
					<td>
						<input type="text" id="extraPay" name="extraPay" />
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<br><br>
					
						<button type="button" class="btn" id="submitBtn"
						style="width: 40%;">직원 추가</button>
						<button type="button" class="btn" id="submitBtn"
						style="width: 40%;">직원 리스트</button>
						<br><br>
					
						<span id="err" style="color: red" >
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