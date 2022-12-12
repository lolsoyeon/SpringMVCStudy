<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/* 문자 셋 */
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	/* FileWrite.jsp */
	
	// 1. 어플리케이션 루트(경로) 얻어내기
	String appRoot = "/";
	appRoot = pageContext.getServletContext().getRealPath(appRoot);
	//--> C:\SpringMVCStudy\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\fileSystemApp02\
	
	// 2. 파일을 쓰기 위해 File 객체를 생성
	File newFile = new File(appRoot, "data/test.txt");
	//-->C:\SpringMVCStudy\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\fileSystemApp02\data\test.txt
	
	// 3. 파일이 존재할 경로(디렉터리)가 존재하지 않는 경우는
	//	  파일이 위치할 곳까지의 디렉터리를 생성해준다.
	if (!newFile.getParentFile().exists())
	{
		newFile.getParentFile().mkdirs();
	}

	// 4-1. 파일을 쓰기 위한 FileWriter 객체 생성
	FileWriter fw = new FileWriter(newFile);

	// 4-2. FileWriter 객체를 조금 더 편하게 사용하기 위해(문자열 확인용)
	//	   PrintWriter 로 감싸주기
	// 	→ 출력 스트림을 활용하여 건네는 구문으로 파일 구성을 하기 위해 처리
	PrintWriter pw = new PrintWriter(fw);
	
	// 5. 실질적으로 파일에 내용을 작성
	pw.println("테스트이다...");
	pw.println("확인해보자...");
	
	
	// 6-1. PrintWriter 리소스 반납(닫아줌)
	pw.close();
	
	
	// 6-2. FileWriter 리소스 반납(닫아줌)
	fw.close();
%>

