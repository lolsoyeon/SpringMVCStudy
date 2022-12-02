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
<title>MemberList.jsp</title>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js">

</script>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
</head>
<body>

<div>
	<h1>회원 정보</h1>
	<hr />
</div>

</body>
<div class="container">
	<div class="panel-qroup">
		<div class="panel panel-default">
			<div class="panel-heading" id="title">
				회원 정보 입력
			</div>
		
			<div class="panel-body">
				<form role="form" action="memberinsert.action" method="post">
				
					<div class="form-group">
						<label for="name">
							NAME :
						</label>
						<input type="text" class="form-control" id="name" name="name"/>
					</div>
				
					<div class="form-group">
						<label for="telephone">
							TELEPHONE :
						</label>
						<input type="tel" class="form-control" id="telephone" name="telephone"/>
					</div>
				
					<button type="submit" class="btn btn-default btn-sm">SUBMIT</button>
					<button type="submit" class="btn btn-default btn-sm btnCancel"></button>
				
				</form>
		</div><!-- close .panel.panel-default -->

	
	<div class="panel panel-default">
		<div class="panel-heading">
			회원 정보 출력
		</div>
		
		<div class="panel-boby">
			<table class="table">
				<thead>
					<tr>
						<th>MID</th>
						<th>NAME</th>
						<th>TELEPHONE</th>
						<TH>삭제  / 수정</TH>
					</tr>
				
				</thead>
				<tbody>
					<tr>
						<td>1</td>
						<td>최나윤</td>
						<td>010-1234-12344</td>
						<td>
							<button type="button"
							class="btn btn-default btn-xs btnDelete">삭제</button>
							<button type="button"
							class="btn btn-default btn-xs btnUpdate">수정</button>
						</td>
					</tr>
				</tbody>
				
			</table>
			
			<button type="button" class="btn btn-default btn-sm">
				Count <span class="badge" role="badge">1</span>
			</button>
			</div>
		</div>
		</div>
	</div>
</div>

</html>