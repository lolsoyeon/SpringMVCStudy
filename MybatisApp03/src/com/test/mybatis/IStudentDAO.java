/*=====================
 	IStudentDAO.java
 	- 인터페이스
 =====================*/

package com.test.mybatis;

import java.util.ArrayList;

public interface IStudentDAO
{
	// 인원 수 확인
	public int count();
	
	// 학생 명단 확인
	public ArrayList<StudentDTO> list();
	
	// 학생 정보 추가
	public int add(StudentDTO s);
	
	// 학생 정보 확인 (sid 를 활용하여 학생 정보 검색)
	public StudentDTO search(String sid);
	
	
}
