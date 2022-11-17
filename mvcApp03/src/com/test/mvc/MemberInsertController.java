
/*==========================================
 	MemberInsertController.java.java
 	- 사용자 정의 컨트롤러 클래스
 	- 회원 데이터 추가add 액션 처리 클래스.
 	- DAO 객체에 대한 의존성 주입을 위한 준비.
 	→ setter injection 
 	① 인터페이스 형태의 자료형 구성
 	② setter 구성
 ==========================================*/
package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공 하는 『Controller』인터페이스를 구현함으로써
//		사용자 정의 컨트롤러 클래스를 구성한다.


// 『implements Controller』 또는 『extends AbstractController』
//-- 서블릿에서 『HttpServlet』 을 상속받은 서블릿 객체 역할
public class MemberInsertController implements Controller
{
	// 인터페이스 자료형 구성
	private IMemberDAO dao;
	
	// setter() 구성
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
		
		// 이전 페이지(MemberList.jsp)부터 넘어온 데이터 수신
		//--name, telephone
		
		request.setCharacterEncoding("UTF-8");
		
		String name = request.getParameter("name");
		String telephone = request.getParameter("telephone");
		
		
		try
		{
			// 깡통
			MemberDTO member = new MemberDTO();
			
			// 깡통 채워
			member.setName(name);
			member.setTelephone(telephone);
			
			dao.add(member);
			

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		// check~!!!!!!!!!
//		mav.setViewName("뷰의 경로 포함 파일 이름");
		// → MemberListController 가 일을 할 수 있도록 처리
		//   → 이 컨트롤러에 의해 MemberList.jsp 가 클라이언트 만남
		//		→ 데이터가 갱신된 내용으로 다시 요청 할 수 있도록 처리
//		mav.setViewName("memberlist.action");

		mav.setViewName("redirect:memberlist.action");
		
		return mav;
		
		
	}

	
}
