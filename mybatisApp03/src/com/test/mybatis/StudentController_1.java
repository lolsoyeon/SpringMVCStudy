/*======================================
 	 - StudentController.java	
 	 → mybatis 객체 활용(Controller)
 ======================================*/
package com.test.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class StudentController_1
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/studentlist.action", method = RequestMethod.POST)
	public String StudentList(ModelMap modelMap)
	{
		IStudentDAO dao = sqlSession.getMapper(IStudentDAO.class);
		
		modelMap.addAttribute("count", dao.count());
		modelMap.addAttribute("list",dao.list());
		
		return "WEB-INF/view/StudentList.jsp";
		
	}
	
	@RequestMapping(value = "/studentinsert.action", method = RequestMethod.POST)
	public String StudentInsert(StudentDTO s)
	{
		IStudentDAO dao = sqlSession.getMapper(IStudentDAO.class);
		
		dao.add(s);
		
		return "redirect:studentlist.action";
		
	}
	
	@RequestMapping(value = "/studentlist.action" , method = RequestMethod.GET)
	public String StudentSearch(String sid)
	{
		IStudentDAO dao = sqlSession.getMapper(IStudentDAO.class);
		
		dao.search(sid);
		
		return "redirect:studentlist.action";
		
	}
	
}
