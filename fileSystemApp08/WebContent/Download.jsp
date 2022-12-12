<%@page import="com.test.util.FileManager"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	/* Dowmload.jsp */
	
	// 파일 처리와 관련한 경로 구성
	String root = pageContext.getServletContext().getRealPath("/");
	String savePath = root + "pds" + File.separator + "saveFile";
	
	// 이전 페이지(Write_ok.jsp) 로 부터 데이터 수신
	//--savaFileName, originalFileName
	String saveFileName = request.getParameter("saveFileName");
	String originalFileName = request.getParameter("originalFileName");
	
	// 파일 다운로드
	// 『out』 
	// : JSP 페이지가 생성하는 결과를 출력할 떄 사용되는 출력 스트림 내장 객체
	// 『clear』 
	// : 버퍼의 내용을 비우고, 버퍼가 이미 flush 된 상태라면 IOException 발생
	out.clear();
	
	// check~!!!
	// boolean flag = FileManager.doFileDownload(saveFileName, originalFileName, savaPath, response);
	FileManager.doFileDownload(saveFileName, originalFileName, savePath, response);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
</head>
<body>

</body>
</html>