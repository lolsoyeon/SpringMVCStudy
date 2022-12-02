/*============================
 	MemberMain.java
 	- 사용자 정의 컨트롤러.
============================*/

package com.test.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MemberMain
{
	// 주요 속성 구성
	// mybatis 객체 의존성 (자동) 주입~!!!
	@Autowired
	private SqlSession sqlSession;

	/*
	public void setSqlSession(SqlSession sqlSession)
	{
		this.sqlSession = sqlSession;
	}
	*/
	
	@RequestMapping(value="/memberlist.action", method = RequestMethod.GET)
	public String memberLsit(ModelMap model)
	{
		//IMemberDAO dao = (IMemberDAO)new MemberDAO();
		//IMemberDAO dao = (IMemberDAO)sqlSession.getObject(IMemberDAO);
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		model.addAttribute("count", dao.count());
		model.addAttribute("list", dao.list());
		
		return "/WEB-INF/view/MemberList.jsp";
	}
	
	@RequestMapping(value="/memberinsert.action", method = RequestMethod.POST)
	public String MemberInsert(MemberDTO m)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		dao.add(m);
		
		//return "/WEB-INF/view/MemberList.jsp";
		return "redirect:memberlist.action";
	}

	@RequestMapping(value="/memberdelete.action", method = RequestMethod.GET)
	public String MemberDelete(MemberDTO m)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		dao.remove(m);
		
		//return "/WEB-INF/view/MemberList.jsp";
		return "redirect:memberlist.action";
	}
	
	
}


