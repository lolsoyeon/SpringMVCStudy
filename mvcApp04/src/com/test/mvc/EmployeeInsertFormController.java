/*============================================
 	#19. EmployeeInsertFormController.java 
 	- 사용자 정의 컨트롤러 클래스
 	- 직원 데이터 입력폼 요청에 대한 액션 처리.
 	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비.
 	   (db한테 데이터 물어보고 그것을 뿌려주는게 필요하기 때문)
 	→ 인터페이스 자료형 속성 구성.
 	→ setter 메소드 정의
 =============================================*/
package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class EmployeeInsertFormController implements Controller
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
		
		// 깡통
		ArrayList<Region> regionList = new ArrayList<Region>();
		ArrayList<Department> departmentList = new ArrayList<Department>();
		ArrayList<Position> positionList = new ArrayList<Position>();
		
		try
		{
			// dao 의 메소드  호출하면  깡통 채워짐
			regionList = dao.regionList();
			departmentList = dao.departmentList();
			positionList = dao.positionList();
			
			// 적재
			mav.addObject("regionList", regionList);
			mav.addObject("departmentList", departmentList);
			mav.addObject("positionList", positionList);
			
			mav.setViewName("/WEB-INF/view/EmployeeInsertForm.jsp");
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		

		return mav;
		
		
	}
	
}
