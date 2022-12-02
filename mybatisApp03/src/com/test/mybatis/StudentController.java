/*============================
 	StudentController.java
 	- 사용자 정의 컨트롤러
 ============================*/

package com.test.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class StudentController
{
	@Autowired
	private SqlSession sqlSession;

	// 매개변수를 등록하는 과정에서 매개변수 목록(인자 리스트)에 적혀있는
	// 클래스의 객체 정보는 스프링이 제공한다.
	
	// 사용자의 요청 주소와 메소드를 매핑하는 과정 필요
	// 『@RequestMapping(value = "요청주소", method = "전송방식")』
	//  ★나머지 모든 전송 방식은 GET 으로 처리한다.
	
	@RequestMapping(value = "/studentlist.action", method = RequestMethod.GET)
	public String studentList(Model model)
	{
		String result = null;
		
		IStudentDAO dao = sqlSession.getMapper(IStudentDAO.class);
		
		model.addAttribute("count", dao.count());
		model.addAttribute("list", dao.list());

		result = "/WEB-INF/view/StudentList.jsp";
		
		return result;
	}
	
	

}
