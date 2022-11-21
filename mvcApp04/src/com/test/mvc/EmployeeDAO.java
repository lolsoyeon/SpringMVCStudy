/*=========================================================
 	#09. EmployeeDAO.java 
 	- 데이터베이스 액션 처리 클래스.
 	- 직원 데이터 입력/ 출력/ 수정/ 삭제 액션.
 	- Connection 객체에 대한 의존성 주입을 위한 준비.
	→ 인터페이스 형태의 속성 구성(DataSource)
	→ setter 메소드 정의. 
 =========================================================*/

package com.test.mvc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

public class EmployeeDAO implements IEmployeeDAO
{
	// 주요 속성 구성 → 인터페이스 형태
	public DataSource dataSource;

	//  setter 구성
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	// 직원 리스트 전체 출력 OK
	@Override
	public ArrayList<Employee> list() throws SQLException
	{
		ArrayList<Employee> employeeList = new ArrayList<Employee>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT EMPLOYEEID, NAME, SSN, BIRTHDAY"
				+ ", LUNAR, LUNARNAME , TELEPHONE, DEPARTMENTID"
				+ ", DEPARTMENTNAME, POSITIONID"
				+ ", POSITIONNAME, REGIONID, REGIONNAME, BASICPAY"
				+ ", EXTRAPAY, PAY, GRADE"
				+ " FROM EMPLOYEEVIEW"
				+ " ORDER BY EMPLOYEEID";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next())
		{
			 Employee employee = new Employee();
			 
			 employee.setEmployeeId(rs.getString("EMPLOYEEID"));
			 employee.setName(rs.getString("NAME"));
			 employee.setSsn(rs.getString("SSN"));
			 employee.setBirthday(rs.getString("BIRTHDAY"));
			 employee.setLunar(rs.getInt("LUNAR"));
			 employee.setLunarName(rs.getString("LUNARNAME"));
			 employee.setTelephone(rs.getString("TELEPHONE"));
			 employee.setDepartmentId(rs.getString("DEPARTMENTID"));
			 employee.setDepartmentName(rs.getString("DEPARTMENTNAME"));
			 employee.setPositionId(rs.getString("POSITIONID"));
			 employee.setPositionName(rs.getString("POSITIONNAME"));
			 employee.setRegionId(rs.getString("REGIONID"));
			 employee.setRegionName(rs.getString("REGIONNAME"));
			 employee.setBasicPay(rs.getInt("BASICPAY"));
			 employee.setExtraPay(rs.getInt("EXTRAPAY"));
			 employee.setPay(rs.getInt("PAY"));
			 employee.setGrade(rs.getInt("GRADE"));
			 
			 employeeList.add(employee);
			 
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return employeeList;
	}

	// 지역 리스트 전체 출력 sqlOK
	@Override
	public ArrayList<Region> regionList() throws SQLException
	{
		ArrayList<Region> regionList = new ArrayList<Region>();
		
		Connection conn = dataSource.getConnection();
		
		String sql ="SELECT REGIONID, REGIONNAME, DELCHECK"
				+ " FROM REGIONVIEW"
				+ " ORDER BY REGIONID";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next())
		{
			Region region = new Region();
			
			region.setRegionId(rs.getString("REGIONID"));
			region.setRegionName(rs.getString("REGIONNAME"));
			region.setDelCheck(rs.getInt("DELCHECK"));
			
			regionList.add(region);
			
		}
		rs.close();
		pstmt.close();
		conn.close();
				
				
		return regionList;
	}

	// 부서 리스트 전체 출력
	@Override
	public ArrayList<Department> departmentList() throws SQLException
	{
		ArrayList<Department> departmentList = new ArrayList<Department>();
		Connection conn = dataSource.getConnection();
		
		String sql ="SELECT DEPARTMENTID, DEPARTMENTNAME, DELCHECK"
				+ " FROM DEPARTMENTVIEW"
				+ " ORDER BY DEPARTMENTID";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			Department department = new Department();
			
			department.setDepartmentId(rs.getString("DEPARTMENTID"));
			department.setDepartmentName(rs.getString("DEPARTMENTNAME"));
			department.setDelCheck(rs.getInt("DELCHECK"));
			
			departmentList.add(department);
			
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return departmentList;
	}

	// 직위 리스트 전체 출력
	@Override
	public ArrayList<Position> positionList() throws SQLException
	{
		ArrayList<Position> positionList = new ArrayList<Position>();
		Connection conn = dataSource.getConnection();
		
		String sql ="SELECT POSITIONID, POSITIONNAME"
				+ ", MINBASICPAY, DELCHECK"
				+ " FROM POSITIONVIEW"
				+ " ORDER BY POSITIONID";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			Position position = new Position();
			
			position.setPositionId(rs.getString("POSITIONID"));
			position.setPositionName(rs.getString("POSITIONNAME"));
			position.setMinBasicPay(rs.getInt("MINBASICPAY"));
			position.setDelCheck(rs.getInt("DELCHECK"));
			
			positionList.add(position);
			
			
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return positionList;
	}
	// 직위 아이디에 따른 최소 기본급 확인/검색
	@Override
	public int getMinBasicPay(String positionId) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT MINBASICPAY"
				+ " FROM POSITION"
				+ " WHERE POSITIONID = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(positionId));
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next())
		{
			result = rs.getInt("MINBASICPAY");
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	// 직원 데이터 추가
	@Override
	public int employeeAdd(Employee employee) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "INSERT INTO EMPLOYEE(EMPLOYEEID, NAME, SSN1, SSN2, BIRTHDAY"
				+ ", LUNAR, TELEPHONE, DEPARTMENTID, POSITIONID"
				+ ", REGIONID, BASICPAY, EXTRAPAY)"
				+ " VALUES ( EMPLOYEESEQ.NEXTVAL"
				+ ", ?, ?"
				+ ", CRYPTPACK.ENCRYPT(?, ?)"
				+ ", TO_DATE( ?, 'YYYY-MM-DD'), ?, ?"
				+ ", ?, ?, ?"
				+ ", ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, employee.getName());
		pstmt.setString(2, employee.getSsn1());
		pstmt.setString(3, employee.getSsn2());
		pstmt.setString(4, employee.getSsn2());
		pstmt.setString(5, employee.getBirthday());
		pstmt.setInt(6, employee.getLunar());
		pstmt.setString(7, employee.getTelephone());
//		pstmt.setString(8, employee.getDepartmentId());
		pstmt.setInt(8, Integer.parseInt(employee.getDepartmentId()));
//		pstmt.setString(9, employee.getPositionId());
		pstmt.setInt(9, Integer.parseInt(employee.getPositionId()));
//		pstmt.setString(10, employee.getRegionId());
		pstmt.setInt(10, Integer.parseInt(employee.getRegionId()));
		pstmt.setInt(11, employee.getBasicPay());
		pstmt.setInt(12, employee.getExtraPay());
		
		
		// 까먹기좋으니 잊지말자~!!!!
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	
	
	
	// 직원 데이터 삭제
	@Override
	public int remove(String employeeId) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql ="DELETE FROM EMPLOYEEVIEW WHERE EMPLOYEEID = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
//		pstmt.setString(1, employeeId);
		pstmt.setInt(1, Integer.parseInt(employeeId));
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}
	// 직원 데이터 수정 13개 파라미터 5,6,7,13
	@Override
	public int modify(Employee employee) throws SQLException
	{
		 int result = 0;
	      
	      // DB 연결
	      Connection conn = dataSource.getConnection();
	      
	      String sql = "UPDATE EMPLOYEE"
					+ " SET NAME=?, BIRTHDAY=TO_DATE(?,'YYYY-MM-DD'), LUNAR=?"
					+ ", TELEPHONE=?, DEPARTMENTID=?, POSITIONID=?, REGIONID=?"
					+ ", BASICPAY=?, EXTRAPAY=?, SSN1=?, SSN2=CRYPTPACK.ENCRYPT(?,?)"
					+ " WHERE EMPLOYEEID=?";
	      
	      PreparedStatement pstmt = conn.prepareStatement(sql);
	      
	      pstmt.setString(1, employee.getName());
	      pstmt.setString(2, employee.getBirthday());
	      pstmt.setInt(3, employee.getLunar());
	      pstmt.setString(4, employee.getTelephone());
	      pstmt.setInt(5, Integer.parseInt(employee.getDepartmentId()));
	      pstmt.setInt(6, Integer.parseInt(employee.getPositionId()));
	      pstmt.setInt(7, Integer.parseInt(employee.getRegionId()));
	      pstmt.setInt(8, employee.getBasicPay());
	      pstmt.setInt(9, employee.getExtraPay());
	      pstmt.setString(10, employee.getSsn1());
	      pstmt.setString(11, employee.getSsn2());
	      pstmt.setString(12, employee.getSsn2());
	      pstmt.setInt(13, Integer.parseInt(employee.getEmployeeId()));
	      
	      result = pstmt.executeUpdate();
	      
	      pstmt.close();
	      conn.close();
	      
	      return result;

	}

	
	/*
	// 아이디로 직원 검색 11개 sqlok
	@Override
	public Employee searchId(String employeeId) throws SQLException
	{
	      // DB 연결
	      Connection conn = dataSource.getConnection();
	      
	      Employee dto = new Employee();
	      
	      String sql = "SELECT EMPLOYEEID, NAME, SSN1, TO_CHAR(BIRTHDAY, 'YYYY-MM-DD') AS BIRTHDAY"
	      			+ ", LUNAR, TELEPHONE, DEPARTMENTID , POSITIONID, REGIONID"
	      			+ ", BASICPAY, EXTRAPAY"
	      			+ " FROM EMPLOYEE"
	      			+ " WHERE EMPLOYEEID = ?";

			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(employeeId));
			
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				 dto.setEmployeeId(rs.getString("EMPLOYEEID"));
				 dto.setName(rs.getString("NAME"));
				 dto.setSsn1(rs.getString("SSN1"));
				 dto.setBirthday(rs.getString("BIRTHDAY"));
				 dto.setLunar(rs.getInt("LUNAR"));
				 dto.setTelephone(rs.getString("TELEPHONE"));
				 dto.setDepartmentId(rs.getString("DEPARTMENTID"));
				 dto.setPositionId(rs.getString("POSITIONID"));
				 dto.setRegionId(rs.getString("REGIONID"));
				 dto.setBasicPay(rs.getInt("BASICPAY"));
				 dto.setExtraPay(rs.getInt("EXTRAPAY"));

			}
			rs.close();
			pstmt.close();
			conn.close();
			
			return dto;

	}
	*/
	// 아이디로 직원 검색 11개 sqlok
	@Override
	public Employee searchId(String employeeId) throws SQLException
	{
		Employee employee = new Employee();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT EMPLOYEEID, NAME, SSN1"
		 		+ ", TO_CHAR(BIRTHDAY, 'YYYY-MM-DD') AS BIRTHDAY, LUNAR"
		 		+ ", TELEPHONE, DEPARTMENTID, POSITIONID, REGIONID"
		 		+ ", BASICPAY, EXTRAPAY"
		 		+ " FROM EMPLOYEE"
		 		+ " WHERE EMPLOYEEID= ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(employeeId));
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{			
			employee.setEmployeeId(rs.getString("EMPLOYEEID"));
			employee.setName(rs.getString("NAME"));
			employee.setSsn1(rs.getString("SSN1"));
			employee.setBirthday(rs.getString("BIRTHDAY"));
			employee.setLunar(rs.getInt("LUNAR"));
			employee.setTelephone(rs.getString("TELEPHONE"));
			employee.setDepartmentId(rs.getString("DEPARTMENTID"));
			employee.setPositionId(rs.getString("POSITIONID"));
			employee.setRegionId(rs.getString("REGIONID"));
			employee.setBasicPay(rs.getInt("BASICPAY"));
			employee.setExtraPay(rs.getInt("EXTRAPAY"));
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return employee;
	}

	// 특정 employeeId 의 ssn2 가 db와 일치 할경우 1 아닐 경우 0을 반환하는 메소드
	@Override
	public int login(String employeeId, String ssn2) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT COUNT(*)"
				+ " FROM EMPLOYEE"
				+ " WHERE EMPLOYEEID = ? AND SSN2= CRYPTPACK.ENCRYPT(?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		pstmt.setInt(1, Integer.parseInt(employeeId));
		pstmt.setString(2, ssn2);
		pstmt.setString(3, ssn2);
		
		while (rs.next())
		{
			result = Integer.parseInt(rs.getString("COUNT"));
		}
		
		return result;
	}
	
	
	

}
