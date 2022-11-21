/*==================================
 	#05. IEmployeeDAO.java 
 	- 인터페이스
 ==================================*/

package com.test.mvc;

import java.sql.SQLException;
import java.util.ArrayList;



public interface IEmployeeDAO
{
	// 추후 EmployeeDAO 에서 정의할 것으로 예상되는 메소드에 대한 선언
	public ArrayList<Employee> list() throws SQLException;
	public ArrayList<Region> regionList() throws SQLException;
	public ArrayList<Department> departmentList() throws SQLException;
	public ArrayList<Position> positionList() throws SQLException;
	
	public int getMinBasicPay(String positionId) throws SQLException;
	public int employeeAdd(Employee employee) throws SQLException;
	public int remove(String employeeId) throws SQLException;
	public int modify(Employee employee) throws SQLException;
	public Employee searchId(String employeeId) throws SQLException;
	public int login(String employeeId, String ssn2) throws SQLException;
}
