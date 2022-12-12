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
	/* Write_ok.jsp*/
	
	// 어플리케이션 루트 경로 확보
	String root = pageContext.getServletContext().getRealPath("/");

	// 어플리케이션 루트 경로를 활용하여 업로드 파일의 저장 경로 구성
	String savePath = root + "pds" + File.separator + "saveFile";
	//                               클래스변수(static)

	
	// 파일 객체 생성 → 파일 저장 경로 전달
	File dir = new File(savePath);
	
	// 경로상 디렉터리가 존재하지 않으면 생성한다.
	if (!dir.exists())
		dir.mkdirs();
	
	// 인코딩 방식과 파일 저장 시 최대 크기 지정
	String encType = "UTF-8";
	int maxFileSize = 5*1024*1024;
	
	MultipartRequest req = null;
	String urlFile = "";
	
	try
	{
		// MultipartRequest  객체의 생성자에 전달하는 인자리스트
		// → request 파일저장경로, 최대크기, 인코딩 방식, 중복파일명 처리정책
		req = new MultipartRequest(request, savePath, maxFileSize, encType, new DefaultFileRenamePolicy());
		
		out.println("작성자 : " + req.getParameter("userName") + "<br>");
		out.println("제목 : "+ req.getParameter("subject") + "<br>");
		out.println("서버에 저장된 파일명 : " + req.getFilesystemName("uploadFile") + "<br>");
		out.println("사용자 업로드 파일명 : " +req.getOriginalFileName("uploadFile") + "<br>");
		out.println("업로드파일의 유형 : " + req.getContentType("uploadFile") + "<br>");
		
		// 요청 객체(request)를 활용하여 생성한 MultipartRequest 객체로 부터
		// 얻어낸 파일 객체 생성
		File f = req.getFile("uploadFile");
		
		// 파일 객체가 제대로 생성되었다면...
		if (f != null)
		{
			out.println("업로드 파일의 크기 : " + f.length() + "Bytes. <br>");
		}
		
		// 해당 파일의 URL 구성
		urlFile = "Download.jsp?saveFileName=" + req.getFilesystemName("uploadFile");
		urlFile += "&originalFileName=" + req.getOriginalFileName("uploadFile");
		
// 		System.out.println(savePath);
		
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
	

%>
<br><br>
<a href="<%=urlFile %>">파일 다운로드</a>







