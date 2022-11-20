
/*==============================================
 	EmployeeListController.java
 	- 사용자 정의 컨트롤러 클래스
 	- 리스트 페이지 요청에 대한 액션 처리
 	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비.
 	→ 인터페이스 자료형
 	→ setter 메소드 정의
 ==============================================*/
package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공 하는 『Controller』인터페이스를 구현함으로써
//		사용자 정의 컨트롤러 클래스를 구성한다.

public class EmployeeListController implements Controller
{
	// 인터페이스 형태의 자료형 멤버 구성
	private IEmployeeDAO dao;
	
	// setter 구성
	public void setDao(IEmployeeDAO dao)
	{
		this.dao = dao;
	}

	// Controller 인터페이스의 handleRequest() 메소드 정의
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드 복습하기
		ModelAndView mav = new ModelAndView();
		
		ArrayList<Employee> employeeList = new ArrayList<Employee>();
		
		try
		{
			employeeList = dao.list();
			
			mav.addObject("employeeList", employeeList);
			
			mav.setViewName("WEB-INF/view/EmployeeList.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
		
	}
	
}
