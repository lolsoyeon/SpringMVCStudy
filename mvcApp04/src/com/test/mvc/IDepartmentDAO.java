/*==================================
 	#06. IDepartmentDAO.java
 	- 인터페이스.
 ==================================*/

package com.test.mvc;

import java.sql.SQLException;
import java.util.ArrayList;

public interface IDepartmentDAO
{
	// 추후 DeartmentDAO 에서 정의할 것으로 예상되는 메소드에 대한 선언
	public ArrayList<Department>list() throws SQLException;
	public int add(Department department) throws SQLException;
	public int remove(String departmentId) throws SQLException;
	public int modify(Department department) throws SQLException;
	
}
