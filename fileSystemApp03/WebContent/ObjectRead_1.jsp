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
	
	/*
		key1 의 값은 적재데이터1 입니다.
		key2 의 값은 적재데이터2 입니다.
	*/

	String appRoot = "/";
	appRoot = pageContext.getServletContext().getRealPath(appRoot);
	
	// 파일을 읽기 위해 객체 생성
	File newFile = new File(appRoot,"objdata/data.ser");
	
	// 지정된 경로에 파일이 존재 하는지
	if(newFile.exists())
	{
		try
		{
			FileInputStream fis = new FileInputStream(newFile);
			
			ObjectInputStream ois = new ObjectInputStream(fis);
			
			//@SuppressWarnings("unchecked")
			Hashtable<String, String> h = (Hashtable<String, String>)ois.readObject();
			
			//Iterator<String> it = h.keySet().iterator();
			
// 			Enumeration em = new Enumeration(h);
			for(String key : h.keySet())
			{
				h.get(key);
				
// 				System.out.println(key + "의 값은" + h.get(key) + " 입니다");
				out.println(key + "의 값은 " + h.get(key) + " 입니다" + "<br>");
			}
			
			
			fis.close();
			ois.close();
			
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
	}
	
		
		
		
		
	
	
	
	
	
%>
