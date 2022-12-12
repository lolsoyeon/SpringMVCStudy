<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	/* ObjectWrite.jsp */
	
	String appRoot = "/";
	appRoot = pageContext.getServletContext().getRealPath(appRoot);
	
	// 경로 확인
	System.out.println(appRoot);
	
	File newFile = new File(appRoot, "objdata/data.ser");
	
	
	// 파일이 존재할 디렉터리가 존재하지 않는 경우는
	// 파일이 위치할 경로까지의 디렉터리를 생성해준다.
	if ( !newFile.getParentFile().exists() )
	{
		newFile.getParentFile().mkdirs();
	}
	
	
	// 파일에 담기 위한 Hashtable 객체를 생성하여
	// 데이터를 넣는다.
	Hashtable<String, String> h = new Hashtable<String, String>();
	h.put("key1", "적재데이터1");
	h.put("key2", "적재데이터2");
	
	// 파일을 내보내기 위한 스트림 구성(파일 출력 스트림)
	FileOutputStream fos = new FileOutputStream(newFile);

	// 객체(Object, Hashtable)를 파일에 쓰기 위해 )ObjectOutputStream 객체 생성
	ObjectOutputStream oos = new ObjectOutputStream(fos);
	
	
	// ObjectOutputStream 을 이용하여 파일에 Object 를 써 넣는다.
	oos.writeObject(h);
	
	// 관련 리소스 반납
	oos.close();
	fos.close();


%>

