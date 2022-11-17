/*=====================================================================
 	MemberDAO.java
 	- 데이터베이스 액션 처리 클래스
 	- IMemberDAO 인터페이스를 implements 하는 클래스.
 	→ IMemberDAO 인터페이스에 선언된 메소드 재정의.
 	※ Connection 객체에 대한 의존성 주입을 위한 준비
 	 	→ setter injection 
 	    ① 인터페이스 형태의 데이터 타입을 취하는 멤버 구성(변수 선언)
 	    ② setter 구성(setter 메소드 정의)
 =====================================================================*/

package com.test.mvc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;


public class MemberDAO implements IMemberDAO
{
	
	//※ Connection 객체에 대한 의존성 주입을 위한 준비
	
	// ① 인터페이스 형태의 데이터타입
	private DataSource dataSource;
	
	// ② setter만 구성
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

	// ※ IMemberDAO 인터페이스에 선언된 메소드 오버라이딩(Overriding)
	
	//회원 데이터 추가(등록) insert 쿼리문 executeUpdate 
	@Override
	public int add(MemberDTO member) throws SQLException
	{
		int result = 0;
		
		// 커넥션 객체 
		Connection conn = dataSource.getConnection();
		
		String sql = "INSERT INTO TBL_MEMBERLIST(MID, NAME, TELEPHONE)"
				+ " VALUES (MEMBERLISTSEQ.NEXTVAL, ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, member.getName());
		pstmt.setString(2, member.getTelephone());
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public int count() throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT COUNT(*) AS COUNT FROM TBL_MEMBERLIST";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result = rs.getInt("COUNT");
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public ArrayList<MemberDTO> list() throws SQLException
	{
		ArrayList<MemberDTO> result = new ArrayList<MemberDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT MID, NAME, TELEPHONE"
				+ " FROM TBL_MEMBERLIST ORDER BY MID";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			MemberDTO member = new MemberDTO();
			
			member.setMid(rs.getInt("MID"));
			member.setName(rs.getString("NAME"));
			member.setTelephone(rs.getString("TELEPHONE"));
			
			result.add(member);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
		
	}
	

	
}
