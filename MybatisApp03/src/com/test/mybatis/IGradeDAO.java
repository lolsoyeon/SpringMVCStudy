/*==========================
 	IGradeDAO.java
 	- 인터페이스
 ==========================*/
package com.test.mybatis;

import java.util.ArrayList;

public interface IGradeDAO
{
	// 성적 정보 인원 수 확인
	public int count();
	
	// 성적 정보 리스트 확인
	public ArrayList<GradeDTO> list();

	// 성적 정보 입력(추가)
	public int add(GradeDTO g);
	
	
}
