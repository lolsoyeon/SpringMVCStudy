/*========================================
 	 #21. AjaxController.java
 	- 사용자 정의 컨트롤러 클래스
 	- 직위에 따른 최소 기본급 반환 액션
 	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비
 	 → 인터페이스 자료형 구성
 	 → setter 메소드 정의.
 ========================================*/
package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class AjaxController implements Controller
{
	private IEmployeeDAO dao;
	
	public void setDao(IEmployeeDAO dao)
	{
		this.dao = dao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		ModelAndView mav = new ModelAndView();
		
		// 이전 페이지(EmployeeInsertForm.jsp)로부터 데이터 수신
		
		String positionId = request.getParameter("positionId");
		
		int result = 0;
		
		
		try
		{
			result = dao.getMinBasicPay(positionId);
			
			// System.out.println(result);
			
			mav.addObject("result", result);
			
			mav.setViewName("/WEB-INF/view/Ajax.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
		
		/*
		EmployeeDAO em = new EmployeeDAO();
		ArrayList<Position> position = new ArrayList<Position>();
		Position po = new Position();
		
		try
		{
			em = dao.getMinBasicPay(Position.getPositionId());
			
			
			mav.addObject("em", em);
			
			mav.setViewName("/WEB-INF/view/Ajax.jsp");	
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		*/
		
		
	}
	
}
