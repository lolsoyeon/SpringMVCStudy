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
<title>EmployeeUpdateFrom.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/jquery-ui.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">

	#content
	{
		border: 1px solid #ccc;
		border-radius: 5px;
		width: 500px;
		padding: 15px;
		margin: 30px;	
	}
	.input-group
	{
		margin: 10px;
	}

</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/jquery-ui.js"></script>

<!-- 
<script type="text/javascript">
	$(document).ready(function()
	{
		$("#basicPay").change(function()
		{
			alert("확인");
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
		
		// 직위의 선택된 옵션이 변경되었을 경우 수행할 코드 처리
		$("#positionId").change(function()
		{
// 			alert("변경 확인~!!");
			ajaxRequest();

		});
		
		
		// 직원 수정 버튼이 클릭 되었을경우 수행할 코드 처리
		$("#submitBtn").click(function()
		{
			// 에러(span 엘리먼트) 안내 초기화 하고 시작 (초기화 기억, 위치 기억~!!!)
			$("#err").css("display", "none");
			
			// 1. 데이터 검사
			//--공란(입력항목 누락)없이 모두 작성되었는지에 대한 여부 확인
			if ($("#name").val()=="" || $("#ss1").val()=="" ||$("#ssn2").val()=="" 
				||$("#birtday").val()=="" || $("#telephone").val()=="" 
				||$("#basicPay").val()=="")
			{
				$("#err").html("입력 항목이 누락되었습니다.");
				$("#err").css("display", "inline");
				return;				//-- submit 액션 처리 중단되도록 필수 return 
			}
			
			// 2. 최소 기본급 유효성 검사
			//-- 입력한 기본급이 최소 기본급보다 작은지에 대한 여부 확인
			// 크기비교는 산술적으로 한다
			// 최소 기본급 → parseInt($("#minBasicPay").text())
			// 입력 기본급 → parseInt($("#basicPay").val())
			/*
			if (최소기본급 > 입력기본급)
			{
				$("#err").html("입력한 기본급이 최소 기본급보다 작습니다.");
				$("#err").css("display","inline");
				return;				//-- submit 액션 처리 중단
			}
			*/
			if (parseInt($("#minBasicPay").text()) > parseInt($("#basicPay").val()))
			{
				$("#err").html("입력한 기본급이 최소 기본급보다 작습니다.");
				$("#err").css("display","inline");
				return;				//-- submit 액션 처리 중단
			}
			
			/*
			내가 한것 문제점1. error 가 생기는 시점의 부등호!
			문제점2. $("#minBasicPay").text(), parseInt(전체 데이터)
			ajaxRequest();
			if ($("#minBasicPay").val(data) < $("#basicPay").val(data))
			{
				$("#err").html("입력하신 금액이 최소 기본급보다 작습니다.");
				$("#err").css("display", "inline");
				return;
			}
			*/
			
			// 함수 호출
			ajaxSsn2();
			
			// submit 액션 처리 수행
			$("#employeeForm").submit();
			
		});		
		
		// 직원 리스트 버튼이 클릭되었을 경우 수행할 코드 처리
		// onclick="location.href='employeeinsertform.action'"
		$("#listBtn").click(function()
		{
			$(location).attr("href","employeelist.action");
		});
		
		
	});
	
	function ajaxRequest()
	{
		//『jquery.post()』 / 『jquery.get()』 
		//『$.post()』 / 『$.get()』 
		//--jQuery 에서 AJAX 를 사용해야 할 졍우 지원해주는 함수.
		//  (서버등에서 요청한 데이터를 받아오는 기능의 함수)
		
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
	
	function ajaxSsn2()
	{	
		$.post("ajax2.action", {employeeId :$("#employeeId").val(), ssn2 : $("#ssn2").val()}, function(data)
		{
			if (data == 0)	// 특정 employeeId의 주민번호 뒷자리가 틀릴경우 count 결과 0
			{
				$("#err").html("주민번호 뒷자리가 틀렸습니다.");
				$("#err").css("display", "inline");
				$("#ssn2").val('');
				$("#ssn2").css("background-color", "#eee");
				$("#ssn2").focus();
				return;
			}
			else if (data == 1)	// 특정 employeeId의 주민번호 뒷자리가 맞을경우 count 결과 1
			{
				$("#employeeForm").submit();	
			}
		});
		
	}
	
	
</script>

</head>
<body>

<!----------------------------------------------------------------------------
   #25. EmployeeUpdateFrom.jsp		2022-11-21
  - 직원 데이터 수정 폼 페이지.
  - 관리자가 접근하는 직원 데이터 입력 폼 페이지
------------------------------------------------------------------------------->


	<!-- 메뉴 영역 -->
<div>
	<c:import url="EmployeeMenu.jsp"></c:import>
</div>
<br>
<label style="text-align: left;">직원 관리 > 직원 정보 수정</label>
<hr>

<div align="center">
	<!-- 콘텐츠 영역 -->
	<div id="content" align="left">

		
		<form action="employeeupdate.action" method="post" id="employeeForm">
			
			<div class="form-group">
			
				<!-- EmployeeInsertForm.jsp 와 비교하여 -->
				<!-- 기존 내용에 대한 직원 항목 추가 -->
				<div class="input-group">
					<div class="input-group-addon">직원번호</div>
					<input type="text" id="employeeId" name="employeeId" 
					value="${employee.employeeId }" readonly="readonly"/>
				</div>
			
			
				<div class="input-group">
					<div class="input-group-addon">이름</div>
					<input type="text" id="name" name="name"
					 class="form-control" value="${employee.name }"/>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">주민번호</div>
					<input type="text" id="ssn1" name="ssn1"class="form-control"
					value="${employee.ssn1 }"/>
					<div class="input-group-addon"> - </div>
					<input type="password" id="ssn2" name="ssn2"class="form-control"/>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">생년월일</div>
					<input type="text" id="birthday" name="birthday"
					 class="form-control" value="${employee.birthday }" />
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">양 / 음력</div>
					<div class="form-control">
					<input type="radio" value="0" name="lunar" id="lunar0" 
					${employee.lunar==0 ? "checked=\"checked\"" : "" } />
					<label for="lunar0">양력</label>
					<input type="radio" value="1" name="lunar" id="lunar1"
					${employee.lunar==1 ? "checked=\"checked\"" : "" } />
					<label for="lunar1">음력</label>
					</div>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">전화번호</div>
					<input type="tel" id="telephone" name="telephone"
					 class="form-control" value="${employee.telephone }"/>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">지역</div>
					<select id="regionId" name="regionId" class="form-control">
					
						<c:forEach var="region" items="${regionList }">
						<option value="${region.regionId }"
							${employee.regionId == region.regionId ? "selected=\"selected\"" : ""}>
							${region.regionName }
						</option>
						</c:forEach>
					
					</select>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">부서</div>
					<select id="departmentId" name="departemntId" class="form-control">
					
						<c:forEach var="department" items="${departmentList }">
						<option value="${department.departmentId }"
							${employee.departmentId == department.departmentId ? "selected=\"selected\"" : ""}>
							${department.departmentName }
						</option>
						</c:forEach>
						
					</select>
				</div>
			
				<div class="input-group">
					<div class="input-group-addon">직위</div>
					<select id="positionId" name="positionId" class="form-control">
					
						<c:forEach var="position" items="${positionList }">
						<option value="${position.positionId }"
							${employee.positionId == position.positionId ? "selected=\"selected\"" : ""}>
							${position.positionName }
						</option>
						</c:forEach>
						
					</select>
				</div>
			
				 <div class="input-group">
					 <div class="input-group-addon">기본급</div>
					 <input type="text" id="basicPay" name="basicPay"
					 class="form-control"
					 value="${employee.basicPay }"/>
					 <div class="input-group-addon">원</div>
					 
					<div class="input-group-addon">수당</div>
					 <input type="text" id="extraPay" name="extraPay"
					 class="form-control"
					 value="${employee.extraPay }"/>
					 <div class="input-group-addon">원</div>
				</div>
			
				<div class="input-group" style="text-align: left;">
					(최소 기본급
					<span id="minBasicPay"
					style="color: red; font-weight: bold;">0</span>
					원)				 
				</div>
				<br><br>
				
				<div class="input-group">
					 <div class="input-group" role="group" style="width: 100%;">
					 <button type="button" class="btn btn-primary btn-lg" 
					 id="submitBtn">직원 수정</button>
					 <button type="button" class="btn btn-default btn-lg" 
					 id="listBtn">직원 리스트</button>
					 </div>
				</div>
				<br><br>
				
				<span id="err" style="color: red; font-weight: bold; display: none;">
				</span>			
			</div>
			
		</form>
		
	</div>
</div>
	<!-- 회사 소개및 어플리케이션 소개 영역 -->
	<div id="footer">
		 
	</div>

</body>
</html>