/*===========================
 	#07. IRegionDAO.java  
 ===========================*/

package com.test.mvc;

import java.sql.SQLException;
import java.util.ArrayList;

public interface IRegionDAO
{
	// 추후 RegionDAO 엑서 정의할 것으로 예상되는 메소드에 대한 선언
	public ArrayList<Region> list () throws SQLException;
	public int add(Region region) throws SQLException;
	public int remove(String regionId) throws SQLException;
	public int modify(Region region) throws SQLException;
}
