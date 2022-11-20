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
<title>EmployeeMeun.jsp</title>

<style type="text/css">
	.btn-group {width: 100%;}
	.menubtn {width: 20%; font-weight: bold;}
</style>

</head>
<body>

<!------------------------------------
  #13. EmployeeMeun.jsp 	2022-11-16
  - 메인 메뉴 페이지 구성.
  - 로그 아웃 기능(버튼) 추가 구성
--------------------------------------->

<div class="btn-group" role="group">

		<a href="employeelist.action" role="button" class="menubtn btn btn-success btn-lg">직원 관리</a>
		<a href="regionlist.action" role="button" class="menubtn btn btn-success btn-lg">지역 관리</a>
		<a href="departmentlist.action" role="button" class="menubtn btn btn-success btn-lg">부서 관리</a>
		<a href="positionlist.action" role="button" class="menubtn btn btn-success btn-lg">직위 관리</a>
		
		<a href="logout.action" role="button" class="menubtn btn btn-success btn-lg">로그 아웃</a>
	
</div>



</body>
</html>