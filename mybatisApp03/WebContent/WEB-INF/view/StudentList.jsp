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
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>StudentList.jsp</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js">

</script>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
</head>
<body>

<div class="panel title">
	<h2>성적 관리(SpringMVC + Annotation + mybatis 버전)</h2>
</div>

<!-- 메인 메뉴 영역 -->
<nav class="navbar navbar-default">
	
	<div class="containar-fluid">
	
		<div class="navbar-heaher">
			<a class="navbar-brand" href="#">Home</a>
		</div>
		
		<div class="collapse navbar-collapse"></div>
	</div><!-- .containar-fluid -->
		
</nav><!-- navbar navbar-default -->


</body>
</html>