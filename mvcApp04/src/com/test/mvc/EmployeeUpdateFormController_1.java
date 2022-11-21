/*========================================
 	 #24. EmployeeUpdateFormController.java
 	- 사용자 정의 컨트롤러 클래스
 	- 직원 수정 입력 폼 요청에 대한 액션 처리
 	- DAO 객체에 대한 의존성(DI) 주입
 	→ 인터페이스 자료형 속성 구성  
 	→ setter 메소드 정의
 ========================================*/
package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;


public class EmployeeUpdateFormController_1 implements Controller
{
	private IEmployeeDAO dao;
	
	public void setDao(IEmployeeDAO dao)
	{
		this.dao = dao;
	}

	// Controller 인터페이스의 handleRequest() 메소드 정의
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 지역, 부서, 직위
		ArrayList<Region> regionList = new ArrayList<Region>();
		ArrayList<Department> departmentList = new ArrayList<Department>();
		ArrayList<Position> positionList = new ArrayList<Position>();
		String employeeId = request.getParameter("id");
		
		// 컨트롤러 내부 액션 처리 코드
		ModelAndView mav = new ModelAndView();
		
		try
		{
			Employee dto = new Employee();
			// dao의 메소드 호출해서 깡통채워
			dto = dao.searchId(employeeId);
			
			regionList = dao.regionList();
			departmentList = dao.departmentList();
			positionList = dao.positionList();
			
			
			// 적재
			mav.addObject("regionList", regionList);
			mav.addObject("departmentList", departmentList);
			mav.addObject("positionList", positionList);
			
			mav.addObject("dto", dto);
			
			mav.setViewName("EmployeeUpdateForm");
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		

		return mav;
		
		
	}
	
}
