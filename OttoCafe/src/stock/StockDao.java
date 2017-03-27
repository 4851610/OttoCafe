package stock;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import util.DBUtil;

public class StockDao {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	ArrayList<Stock> list = new ArrayList<Stock>();

	/**
	 * 총 레코드 수
	 * */
	public int totalRecord() {
		conn = DBUtil.connection();
		String sql1 = "SELECT COUNT(MATERIAL_UNIQUE_KEY) AS TOTAL_RECORD FROM MATERIAL;";
		int totalRecord = 0;
		try {
			pstmt = conn.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			rs.next();
			totalRecord = rs.getInt(1);
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
		return totalRecord;
	}

	/**
	 * 
	 * */
	public int totalRecord(String managerId) {
		conn = DBUtil.connection();
		String sql1 = "SELECT COUNT(MATERIAL_UNIQUE_KEY) AS TOTAL_RECORD FROM MATERIAL_STOCK WHERE CAFE_UNIQUE_KEY = (SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?);";
		int totalRecord = 0;
		try {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, managerId);
			rs = pstmt.executeQuery();
			rs.next();
			totalRecord = rs.getInt(1);
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
		return totalRecord;
	}

	/**
	 * 마이페이지 재고 리스트
	 * */
	public ArrayList<Stock> stockList(int pageno) {
		conn = DBUtil.connection();
		if (pageno == 1) {
			pageno -= 1;
		} else {
			pageno = (pageno - 1) * 5;
		}
		String sql = "SELECT m.MATERIAL_UNIQUE_KEY, c.CATEGORY_NAME, s.MATERIAL_STORE_NAME, m.MATERIAL_NAME, m.IMAGE, m.PRICE, m.VOLUME, u.MATERIAL_UNIT_NAME FROM MATERIAL m, MATERIAL_CATEGORY c, MATERIAL_STORE s, MATERIAL_UNIT u WHERE m.MATERIAL_UNIT_UNIQUE_KEY = u.MATERIAL_UNIT_UNIQUE_KEY AND m.MATERIAL_STORE_UNIQUE_KEY = s.MATERIAL_STORE_UNIQUE_KEY AND m.MATERIAL_CATEGORY_UNIQUE_KEY = c.MATERIAL_CATEGORY_UNIQUE_KEY ORDER BY m.MATERIAL_UNIQUE_KEY ASC LIMIT ?, 5;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pageno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int materialUniqueKey = rs.getInt("m.MATERIAL_UNIQUE_KEY");
				String categoryName = rs.getString("c.CATEGORY_NAME");
				String materialStoreName = rs
						.getString("s.MATERIAL_STORE_NAME");
				String materialName = rs.getString("m.MATERIAL_NAME");
				String image = rs.getString("m.IMAGE");
				int price = rs.getInt("m.PRICE");
				float volume = rs.getFloat("m.VOLUME");
				String materialUnitName = rs.getString("u.MATERIAL_UNIT_NAME");

				Stock stocks = new Stock(materialUniqueKey, categoryName,
						materialStoreName, materialName, image, price, volume,
						materialUnitName);

				list.add(stocks);
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

	/**
	 * 마이페이지 재고 등록
	 * */
	public boolean addMaterial(int materialCategoryUniqueKey,
			int materialStoreUniqueKey, String materialName, int price,
			int volume, int materialUnitUniqueKey, String url, String image) {
		conn = DBUtil.connection();
		String sql = "insert into MATERIAL (MATERIAL_CATEGORY_UNIQUE_KEY, MATERIAL_STORE_UNIQUE_KEY, MATERIAL_NAME, IMAGE, PRICE, URL, VOLUME, MATERIAL_UNIT_UNIQUE_KEY) values(?,?,?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, materialCategoryUniqueKey);
			pstmt.setInt(2, materialStoreUniqueKey);
			pstmt.setString(3, materialName);
			pstmt.setString(4, image);
			pstmt.setInt(5, price);
			pstmt.setString(6, url);
			pstmt.setInt(7, volume);
			pstmt.setInt(8, materialUnitUniqueKey);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	/**
	 * 재고현황 재고 리스트
	 * */
	public ArrayList<Stock> stockStatus(String managerId, int pageno) {
		conn = DBUtil.connection();
		if (pageno == 1) {
			pageno -= 1;
		} else {
			pageno = (pageno - 1) * 5;
		}
		String sql = "SELECT m.MATERIAL_UNIQUE_KEY, m.MATERIAL_NAME, s.AMOUNT, u.MATERIAL_UNIT_NAME, m.IMAGE, m.PRICE FROM MATERIAL m, MATERIAL_STOCK s, MATERIAL_UNIT u WHERE s.MATERIAL_UNIQUE_KEY = m.MATERIAL_UNIQUE_KEY AND s.CAFE_UNIQUE_KEY = (SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?) AND s.MATERIAL_UNIT_UNIQUE_KEY = u.MATERIAL_UNIT_UNIQUE_KEY LIMIT ?, 5;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			pstmt.setInt(2, pageno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int materialUniqueKey = rs.getInt("m.MATERIAL_UNIQUE_KEY");
				String materialName = rs.getString("m.MATERIAL_NAME");
				int amount = rs.getInt("s.AMOUNT");
				String materialUnitName = rs.getString("u.MATERIAL_UNIT_NAME");
				String image = rs.getString("m.IMAGE");
				int price = rs.getInt("m.PRICE");

				Stock stocks = new Stock(materialUniqueKey, materialName,
						amount, materialUnitName, image, price);

				list.add(stocks);
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

	/**
	 * 장바구니에 추가된 재료 취소
	 * */
	public boolean putBasketCancel(int putBasketUniqueKey) {
		conn = DBUtil.connection();
		String sql = "DELETE FROM PUT_BASKET WHERE PUT_BASKET_UNIQUE_KEY = ?;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, putBasketUniqueKey);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	/**
	 * 장바구니 리스트
	 * */
	public ArrayList<Stock> cartList(String managerId) {
		conn = DBUtil.connection();
		String sql = "SELECT m.MATERIAL_UNIQUE_KEY, m.MATERIAL_NAME, m.IMAGE, m.PRICE, p.AMOUNT, p.PRICE, p.PUT_BASKET_UNIQUE_KEY FROM PUT_BASKET p, MATERIAL m WHERE CAFE_UNIQUE_KEY = (SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?) AND m.MATERIAL_UNIQUE_KEY = p.MATERIAL_UNIQUE_KEY AND BASKET_UNIQUE_KEY IS NULL ORDER BY PUT_BASKET_UNIQUE_KEY DESC;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int materialUniqueKey = rs.getInt("m.MATERIAL_UNIQUE_KEY");
				String materialName = rs.getString("m.MATERIAL_NAME");
				String image = rs.getString("m.IMAGE");
				int price = rs.getInt("m.PRICE");
				int amount = rs.getInt("p.AMOUNT");
				int total = rs.getInt("p.PRICE");
				int putBasketUniqueKey = rs.getInt("p.PUT_BASKET_UNIQUE_KEY");

				Stock stocks = new Stock(materialUniqueKey, materialName,
						image, price, amount, total, putBasketUniqueKey);

				list.add(stocks);
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

	/**
	 * 주문 히스토리 리스트
	 * */
	public ArrayList<Stock> orderHistoryList(String managerId) {
		conn = DBUtil.connection();
		String sql = "SELECT DISTINCT b.BASKET_UNIQUE_KEY, b.DATE, b.TOTAL_PRICE, m.MATERIAL_NAME, COUNT(m.MATERIAL_NAME) FROM BASKET b, MATERIAL m, PUT_BASKET p WHERE p.MATERIAL_UNIQUE_KEY = m.MATERIAL_UNIQUE_KEY AND b.BASKET_UNIQUE_KEY = p.BASKET_UNIQUE_KEY AND p.CAFE_UNIQUE_KEY = (SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?) GROUP BY BASKET_UNIQUE_KEY;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int basketUniqueKey = rs.getInt("b.BASKET_UNIQUE_KEY");
				String date = rs.getString("b.DATE");
				int totalPrice = rs.getInt("b.TOTAL_PRICE");
				String materialName = rs.getString("m.MATERIAL_NAME");
				int count = rs.getInt("COUNT(m.MATERIAL_NAME)");

				Stock stocks = new Stock(basketUniqueKey, date, totalPrice,
						materialName, count);

				list.add(stocks);
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

	/**
	 * 주문 히스토리 디데일
	 * */
	public ArrayList<Stock> orderHistoryDetail(int basketUniqueKey,
			String managerId) {
		conn = DBUtil.connection();
		String sql = "SELECT DISTINCT p.MATERIAL_UNIQUE_KEY, m.MATERIAL_NAME, m.IMAGE, p.PRICE, p.AMOUNT FROM BASKET b, PUT_BASKET p, MATERIAL m WHERE b.BASKET_UNIQUE_KEY=? AND p.BASKET_UNIQUE_KEY = b.BASKET_UNIQUE_KEY AND p.MATERIAL_UNIQUE_KEY = m.MATERIAL_UNIQUE_KEY AND p.CAFE_UNIQUE_KEY = (SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?);";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, basketUniqueKey);
			pstmt.setString(2, managerId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int materialUniqueKey = rs.getInt("p.MATERIAL_UNIQUE_KEY");
				String materialName = rs.getString("m.MATERIAL_NAME");
				String image = rs.getString("m.IMAGE");
				int price = rs.getInt("p.PRICE");
				int total = rs.getInt("p.AMOUNT");

				Stock stocks = new Stock(materialUniqueKey, materialName,
						image, price, total);

				list.add(stocks);
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

	/**
	 * 재료등록 카테고리 리스트
	 * */
	public ArrayList<Stock> categoryList() {
		conn = DBUtil.connection();
		String sql = "SELECT MATERIAL_CATEGORY_UNIQUE_KEY, CATEGORY_NAME FROM MATERIAL_CATEGORY";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int materialCategoryUniqueKey = rs
						.getInt("MATERIAL_CATEGORY_UNIQUE_KEY");
				String categoryName = rs.getString("CATEGORY_NAME");

				Stock stocks = new Stock(materialCategoryUniqueKey,
						categoryName);

				list.add(stocks);
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

	/**
	 * 재료등록 단위 리스트
	 * */
	public ArrayList<Stock> unitList() {
		conn = DBUtil.connection();
		String sql = "SELECT MATERIAL_UNIT_NAME, MATERIAL_UNIT_UNIQUE_KEY FROM MATERIAL_UNIT";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String materialUnitName = rs.getString("MATERIAL_UNIT_NAME");
				int materialUnitUniqueKey = rs
						.getInt("MATERIAL_UNIT_UNIQUE_KEY");

				Stock stocks = new Stock(materialUnitName,
						materialUnitUniqueKey);

				list.add(stocks);
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

	/**
	 * 재고 그래프
	 * */
	public ArrayList<Stock> stockList(String managerId) {
		conn = DBUtil.connection();
		String sql = "SELECT DISTINCT m.MATERIAL_UNIQUE_KEY, LEFT(m.MATERIAL_NAME, 6) AS MATERIAL_NAME, s.AMOUNT, s.MINIMUM, (s.MINIMUM / s.AMOUNT * 100) AS PERCENTAGE, (100 - (s.MINIMUM / s.AMOUNT * 100)) AS USABLE FROM MATERIAL m, MATERIAL_STOCK s WHERE CAFE_UNIQUE_KEY = (SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?) AND m.MATERIAL_UNIQUE_KEY = s.MATERIAL_UNIQUE_KEY ORDER BY PERCENTAGE DESC LIMIT 8;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int materialUniqueKey = rs.getInt("m.MATERIAL_UNIQUE_KEY");
				String materialName = rs.getString("MATERIAL_NAME");
				int amount = rs.getInt("s.AMOUNT");
				int minimum = rs.getInt("s.MINIMUM");
				float percentage = rs.getFloat("PERCENTAGE");
				float usable = rs.getFloat("USABLE");
				if (percentage > 100) {
					percentage = 100;
					usable = 0;
				}
				Stock stocks = new Stock(materialUniqueKey, materialName,
						amount, minimum, percentage, usable);

				list.add(stocks);
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

	/*
	 * 재료 삭제
	 */
	public boolean materialDelete(String[] materialUniqueKey) {
		conn = DBUtil.connection();
		String sql = "DELETE FROM MATERIAL WHERE MATERIAL_UNIQUE_KEY = ?;";
		try {
			pstmt = conn.prepareStatement(sql);
			for (int i = 0; i < materialUniqueKey.length; i++) {
				pstmt.setInt(1, Integer.parseInt(materialUniqueKey[i]));
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	/**
	 * 재고 주문
	 * */
	public boolean addPutBasket(String managerId, int materialUniqueKey,
			int orderAmount) {
		conn = DBUtil.connection();
		String sql = "INSERT INTO PUT_BASKET (MATERIAL_UNIQUE_KEY, PRICE, AMOUNT, CAFE_UNIQUE_KEY) VALUES (?, (SELECT PRICE FROM MATERIAL WHERE MATERIAL_UNIQUE_KEY = ?)*?, ?, (SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?));";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, materialUniqueKey);
			pstmt.setInt(2, materialUniqueKey);
			pstmt.setInt(3, orderAmount);
			pstmt.setInt(4, orderAmount);
			pstmt.setString(5, managerId);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	/**
	 * 재료 출력 셀렉트 박스...
	 * */
	public ArrayList<Stock> selectMaterial(int categoryUniqueKey) {
		conn = DBUtil.connection();
		String sql = "SELECT MATERIAL_UNIQUE_KEY, MATERIAL_NAME FROM MATERIAL WHERE MATERIAL_CATEGORY_UNIQUE_KEY=?;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categoryUniqueKey); 
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int materialUniqueKey = rs.getInt("MATERIAL_UNIQUE_KEY");
				String materialName = rs
						.getString("MATERIAL_NAME");

				Stock stocks = new Stock(materialUniqueKey,
						materialName);

				list.add(stocks);
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
	
	/**
	 * 카테고리 선택하면 관련 재료 출력해서 셀렉트 박스에 ...
	 * */
	public ArrayList<Stock> selectMaterial() {
		conn = DBUtil.connection();
		String sql = "SELECT MATERIAL_UNIQUE_KEY, MATERIAL_NAME FROM MATERIAL";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int materialUniqueKey = rs.getInt("MATERIAL_UNIQUE_KEY");
				String materialName = rs
						.getString("MATERIAL_NAME");

				Stock stocks = new Stock(materialUniqueKey,
						materialName);

				list.add(stocks);
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
	
	/**
	 * 제작완료
	 * */
	public boolean complete(int orderUniqueKey) {
		conn = DBUtil.connection();
		String sql = "UPDATE 020cafe.ORDER SET MAKING_CHECK=1 WHERE ORDER_UNIQUE_KEY = ?;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, orderUniqueKey);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	
	/**
	 * 재고 추가
	 * */
	public boolean addStock(String managerId, int materialUniqueKey, int volume, int materialUnitUniqueKey, int minimum) {
		conn = DBUtil.connection();
		String sql = "INSERT INTO MATERIAL_STOCK (CAFE_UNIQUE_KEY, MATERIAL_UNIQUE_KEY, AMOUNT, MATERIAL_UNIT_UNIQUE_KEY, MINIMUM) VALUES ((SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?), ?, ?, ?, ?);";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			pstmt.setInt(2, materialUniqueKey);
			pstmt.setInt(3, volume);
			pstmt.setInt(4, materialUnitUniqueKey);
			pstmt.setInt(5, minimum);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	
	/**
	 * 제작완료 그래프
	public boolean completeGraph(int managerId, String[] merchandiseUniqueKey, String orderDate) {
		conn = DBUtil.connection();
		String sql = "INSERT INTO USER_ORDER (CAFE_UNIQUE_KEY, MERCHANDISE_UNIQUE_KEY, ORDER_DATE, IS_SELL) VALUES ((SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?), ?, ?, 1);";
		try {
			pstmt = conn.prepareStatement(sql);
			for (int i = 0; i < merchandiseUniqueKey.length; i++) {
				pstmt.setInt(1, managerId);
				pstmt.setInt(2, Integer.parseInt(merchandiseUniqueKey[i]));
				pstmt.setString(3, orderDate);
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	 * */
}
