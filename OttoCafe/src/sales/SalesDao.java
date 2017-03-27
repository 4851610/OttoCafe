package sales;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DBUtil;

public class SalesDao {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	ArrayList<Sales> list = new ArrayList<Sales>();

	/**
	 * 판매 현황
	 * @param managerId
	 * @param date1
	 * @param date2
	 * @return
	 */
	public ArrayList<Sales> getAll(String managerId, String date1, String date2) {
		conn = DBUtil.connection();
		String sql = "SELECT DISTINCT m.MERCHANDISE_UNIQUE_KEY, m.MERCHANDISE_NAME, COUNT(m.MERCHANDISE_NAME) FROM MERCHANDISE m, USER_ORDER o WHERE o.MERCHANDISE_UNIQUE_KEY = m.MERCHANDISE_UNIQUE_KEY AND o.IS_SELL = 1 AND o.CAFE_UNIQUE_KEY = (SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?) AND o.ORDER_DATE BETWEEN ? AND ? GROUP BY MERCHANDISE_NAME ORDER BY COUNT(m.MERCHANDISE_NAME) DESC, m.MERCHANDISE_UNIQUE_KEY ASC limit 0, 8;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			pstmt.setString(2, date1);
			pstmt.setString(3, date2);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int merchandiseUniqueKey = rs.getInt("m.MERCHANDISE_UNIQUE_KEY");
				String merchandiseName = rs.getNString("m.MERCHANDISE_NAME");
				int count = rs.getInt("COUNT(m.MERCHANDISE_NAME)");
				
				Sales sales = new Sales(merchandiseUniqueKey, merchandiseName, count);
				
				list.add(sales);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
    public ArrayList<Sales> selectOrder() {
        ArrayList<Sales> lists = new ArrayList<Sales>();
        String sql = "SELECT `ORDER_UNIQUE_KEY`,`USER_UNIQUE_KEY`,`ORDER_MERCHANDISE`, `ORDER_MERCHANDISE_COUNT` FROM `ORDER` WHERE `MAKING_CHECK` = '0' ORDER BY `ORDER_DATE` ASC LIMIT 0,3;" ;
        conn = DBUtil.connection();
        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
            	int orderUniqueKey= rs.getInt("ORDER_UNIQUE_KEY");
                int userUniqueKey = rs.getInt("USER_UNIQUE_KEY");
                String merchandises = rs.getString("ORDER_MERCHANDISE");
                String merchandisCounts = rs
                        .getString("ORDER_MERCHANDISE_COUNT");

                Sales sales = new Sales(orderUniqueKey,userUniqueKey, merchandises,
                        merchandisCounts);

                lists.add(sales);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return lists;
    }
}
