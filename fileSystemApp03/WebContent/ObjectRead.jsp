<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	/* ObjectRead.jsp */
	
	/*-----------------------------------------
		key1 의 값은 적재데이터1 입니다.
		key2 의 값은 적재데이터2 입니다.
	-----------------------------------------*/

	String appRoot = "/";
	appRoot = pageContext.getServletContext().getRealPath(appRoot);
	
	// 파일을 읽기 위해 객체 생성
	File newFile = new File(appRoot,"objdata/data.ser");
	
	
	// 읽어들일 대상 파일이 존재하는지의 여부
	if(newFile.exists())
	{
		FileInputStream fis = new FileInputStream(newFile);
		
		// File 에서 object 를 읽어오기 위해
		// ObjectInputStream 을 생성하여 FileInputStream 을 감싼다.
		ObjectInputStream ois = new ObjectInputStream(fis);
		
		// ObjectInputStream 을 이용하여 파일로부터 Object 를 읽어온다.
		//-- 읽어온 Object는 Hashtable 형태
		Hashtable h = (Hashtable)ois.readObject();
		
		// 리소스 반납
		ois.close();
		fis.close();
		
		//-----------------------------여기 까지 수행하면 파일에서 객체 읽어오는 작업은 끝 ~!
		
		Enumeration e = h.keys();
		while(e.hasMoreElements())
		{
			String key = (String)e.nextElement();	//-- 키 얻어내기
			String value = (String)h.get(key);		//-- 얻어낸 키를 활용하여 값 얻어내기
			
			
%>
<%=key %> 의 값은 <%=value %> 입니다.<br>
<%			
		}
		
		
	}
	else
	{
		out.println("해당 파일은 존재하지않습니다 ");
	}
	
		
		
%>
		
		
	
	
	
	
	
