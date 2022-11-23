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
<title>RegionInsertForm.jsp</title>
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

<script type="text/javascript">
	
	
</script>

</head>
<body>

<!----------------------------------------------------------------------------
  - #37. RegionInsertForm.jsp 		2022-11-23
  - 지역 데이터 입력 폼 페이지.
  - 관리자가 접근하는 지역 데이터 입력 폼 페이지
------------------------------------------------------------------------------->



	<!-- 메뉴 영역 -->
	<div>
		<c:import url="EmployeeMenu.jsp"></c:import>
	</div>
	<br>
	<label style="text-align: left;"> 지역 관리 > 지역 정보 입력 </label>
	
<div align="center">
	<!-- 콘텐츠 영역 -->
	<div id="content" align="left">

		<form action="regioninsert.action" method="post" id="regionForm">
			
			<div class="form-group">
			
				<div class="input-group">
					<div class="input-group-addon">지역명</div>
					<input type="text" id="regionName" name="regionName"
					 class="form-control" placeholder="지역명" />
				</div>
				<br><br>
				
				<span id="err" style="color: red; font-weight: bold; display: none;">
				</span>
<!-- 				이미 사용중인 지역명이 존재합니다. -->
<!-- 				사용할 수 있는 이름입니다. -->

<!-- 				→ 입력 내용이 있을 때 Ajax로 확인 -->
				<div class="input-group">
					 <div class="input-group" role="group" style="width: 100%;">
					 <button type="button" class="btn btn-primary btn-lg" 
					 id="submitBtn">지역 추가</button>
					 <button type="button" class="btn btn-default btn-lg" 
					 id="listBtn">지역 리스트</button>
					 </div>
				</div>
				<br><br>
				
			</div>
			
		</form>		
	</div>
</div>
	<!-- 회사 소개및 어플리케이션 소개 영역 -->
	<div id="footer">
		 
	</div>

</body>
</html>