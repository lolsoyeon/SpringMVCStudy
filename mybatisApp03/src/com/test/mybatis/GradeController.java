/*
 	GradeController.java
 */
package com.test.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class GradeController
{
	// 주요 속성 구성
	// 의존성 주입
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/gradelist.action",method = RequestMethod.POST)
	public String GradeList(ModelMap modelMap)
	{
		IGradeDAO dao = sqlSession.getMapper(IGradeDAO.class);
		
		modelMap.addAttribute("count", dao.count());
		modelMap.addAttribute("list", dao.list());
		
		return "WEB-INF/view/GradeList.jsp";
	}
	@RequestMapping(value = "/gradeinsert.action", method = RequestMethod.POST)
	public String GradeInsert(GradeDTO g)
	{
		IGradeDAO dao = sqlSession.getMapper(IGradeDAO.class);
		
		dao.add(g);
		
		return "redirect:gradelist.action";
		
	}
	
	
}
