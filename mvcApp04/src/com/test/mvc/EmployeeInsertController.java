/*========================================
 	#23. EmployeeInsertColtroller.java
 	- 사용자 정의 컨트롤러 클래스.
 	- 직원 데이터 입력 액션 수행 및 해당 액션 처리 이후 
 	『employeelist.action』 을 요청 할 수 있도록 안내.
 	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비.
 	→ 인터페이스 자료형 구성
 	→ setter 메소드 정의
 ========================================*/
package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공 하는 『Controller』인터페이스를 구현함으로써
//		사용자 정의 컨트롤러 클래스를 구성한다.

public class EmployeeInsertController implements Controller
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
		// 컨트롤러 내부 액션 처리 코드
		ModelAndView mav = new ModelAndView();
		
		// 이전 페이지(EmployeeInsertForm.jsp)에 대한 데이터 수신
		// name, ssn1, ssn2, birthday, lunar, telephone, regionId
		// departmentId, positionId, basicPay, extraPay
		String name = request.getParameter("name");
		String ssn1 = request.getParameter("ssn1");
		String ssn2 = request.getParameter("ssn2");
		String birthday = request.getParameter("birthday");
		String lunar = request.getParameter("lunar");
		String telephone = request.getParameter("telephone");
		String regionId = request.getParameter("regionId");
		String departmentId = request.getParameter("departmentId");
		String positionId = request.getParameter("positionId");
		String basicPay = request.getParameter("basicPay");
		String extraPay = request.getParameter("extraPay");
		
		try
		{
			// 깡통
			Employee employee = new Employee();
			
			employee.setName(name);
			employee.setSsn1(ssn1);
			employee.setSsn2(ssn2);
			employee.setBirthday(birthday);
			employee.setLunar(Integer.parseInt(lunar));
			employee.setTelephone(telephone);
			employee.setRegionId(regionId);
			employee.setDepartmentId(departmentId);
			employee.setPositionId(positionId);
			employee.setBasicPay(Integer.parseInt(basicPay));
			employee.setExtraPay(Integer.parseInt(extraPay));
			
			// 반환값을 활용한 분기 처리 가능~!!!
			dao.employeeAdd(employee);

			//addObject 할 것은 없다 받은것을 들고가는 역할 redirect: 재요청해라
			mav.setViewName("redirect:employeelist.action");
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		/*
		try
		{
			// 깡통
			ArrayList<Employee> employeeAdd = new ArrayList<Employee>();
			Employee employee  = new Employee();
			// 깡통 채워
			employeeAdd = dao.employeeAdd(employee);
			mav.addObject("employee", employeeAdd);
			mav.setViewName("/employeelist.action");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		*/
		return mav;
		
		
	}
	
}
