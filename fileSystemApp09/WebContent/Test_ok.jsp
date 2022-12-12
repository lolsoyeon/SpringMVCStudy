<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
// 	Test_ok.jsp


	// 경로 확보 및 구성
	String root = pageContext.getServletContext().getRealPath("/");
	String savaPath = root + "pds" + File.separator + "savaFile";
	//     				임의디렉터리
	// 경로 운영 
	
	// 구성한 경로를 기반으로 파일 객체 생성
	File dir = new File(savaPath);

	// 지정한 경로대로 디렉터리가 존재하지 않는 상황이라면
	if (!dir.exists())
		dir.mkdirs();
		//-- 디렉터리 생성
		
	String encType = "UTF-8";			//-- 인코딩 방식 → UTF-8
	int maxFileSize = 5*1024*1024;		//-- 업로드 파일 최대 용량 → 5mb
	
	MultipartRequest req = null;
	
	try
	{
		req = new MultipartRequest(request, savaPath, maxFileSize, encType, new DefaultFileRenamePolicy());
		
		out.println("<h2>작성자 : " + req.getParameter("userName") + "</h2>");
		out.println("<h2>제목 : " + req.getParameter("subject") + "</h2>");
		out.println("*****************************<br>");
		
		
		out.println("<h2>업로드된 파일</h2>");
		
		// check~!!! 중요 ~!!!
		// MultipartRequest 객체의 『getFileNames()』
		// → 요청으로 넘어온 파일들의 이름을 Enumeration 타입으로 반환
		Enumeration files = req.getFileNames();
		
		while (files.hasMoreElements())
		{
			 String name= (String)files.nextElement();
			 
			 if (req.getFilesystemName(name) != null)
			 {
				 out.println("<h3> - 서버에 저장된 파일 명 : " + req.getFilesystemName(name) + "</h3>");
				 out.println("<h3> - 업로드한 실제 파일 명 : " + req.getOriginalFileName(name) + "</h3>");
				 out.println("<h3> - 파일 타입 : " + req.getContentType(name) + "</h3>");
				 
				 File f = req.getFile(name);
				 if (f != null)
				 {
					 out.println("<h3> - 파일 크기 : " + f.length() + "Bytes. </h3>");
				 }
				 
			 }
		}
		
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
</head>
<body>

</body>
</html>