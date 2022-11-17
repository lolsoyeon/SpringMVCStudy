/*==================================
 	MemberListController.java
 	- 사용자 정의 컨트롤러 클래스
 	- 회원들의 목록(리스트) 출력 액션.
 	- DAO 객체에 대한 의존성 주입을 위한 준비.
 	→ setter injection
 	  ① 인터페이스 형태의 자료형
 	  ② setter 구성
================================== */
package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공 하는 『Controller』인터페이스를 구현함으로써
//		사용자 정의 컨트롤러 클래스를 구성한다.

public class MemberListController implements Controller
{
	// ※ DAO 객체에 대한 의존성 주입을 위한 준비.
	
	// ① 인터페이스 형태의 자료형
	private IMemberDAO dao;
	 
	// ② setter 구성
	public void setDao(IMemberDAO dao)
	{
		this.dao = dao;
	}

	// Controller 인터페이스의 handleRequest() 메소드 정의
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		ModelAndView mav = new ModelAndView();
		

		// 무조건 뷰는 너야~~ 가 아니라 이거 들고가서 만나
		// 이 작업이 필요하니 복습하기
		int count = 0;
		ArrayList<MemberDTO> memberList = new ArrayList<MemberDTO>();
		
		try
		{
			count = dao.count();
			memberList = dao.list();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		mav.addObject("count", count);
		mav.addObject("memberList", memberList);
		mav.setViewName("/WEB-INF/view/MemberList.jsp");
		
		
		return mav;
		
		
	}
	
}
