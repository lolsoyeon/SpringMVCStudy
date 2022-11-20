/*=============================
 	#08. IPositionDAO.java 
 =============================*/

package com.test.mvc;

import java.sql.SQLException;
import java.util.ArrayList;

public interface IPositionDAO
{
	// 추후 PositionDAO 에서 정의할 것으로 예상되는 메소드에 대한 선언
	public ArrayList<Position> list() throws SQLException;
	public int add(Position position) throws SQLException;
	public int remove(String positionId) throws SQLException;
	public int modify(Position position) throws SQLException;
	
}
