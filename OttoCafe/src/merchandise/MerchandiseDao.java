package merchandise;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DBUtil;

public class MerchandiseDao {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	ArrayList<Merchandise> list = new ArrayList<Merchandise>();

	/**
	 * 상품 총 레코드 수
	 * */
	public int totalRecord(String managerId) {
		conn = DBUtil.connection();
		String sql1 = "SELECT COUNT(MERCHANDISE_UNIQUE_KEY) AS TOTAL_RECORD FROM MERCHANDISE WHERE CAFE_UNIQUE_KEY = (SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?);";
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
	 * 마이페이지 상품 리스트
	 * */
	public ArrayList<Merchandise> merchandiseList(String managerId, int pageno) {
		conn = DBUtil.connection();
		if(pageno == 1) {
			pageno -= 1;
		} else {
			pageno = (pageno - 1)*5;
		}
		String sql = "SELECT MERCHANDISE_UNIQUE_KEY, MERCHANDISE_NAME, PRICE, MERCHANDISE_IMAGE FROM MERCHANDISE WHERE CAFE_UNIQUE_KEY = (SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?) LIMIT ?, 5;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			pstmt.setInt(2, pageno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int merchandiseUniqueKey = rs.getInt("MERCHANDISE_UNIQUE_KEY");
				String merchandiseName = rs.getString("MERCHANDISE_NAME");
				int price = rs.getInt("PRICE");
				String image = rs.getString("MERCHANDISE_IMAGE");

				Merchandise merchandises = new Merchandise(
						merchandiseUniqueKey, merchandiseName, price, image);

				list.add(merchandises);
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
	 * 마이페이지 상품 등록
	 * */
	public boolean addMerchandise(String merchandiseName, int price, String image, String managerId) {
		conn = DBUtil.connection();
		String sql = "insert into MERCHANDISE (CAFE_UNIQUE_KEY, MERCHANDISE_NAME, PRICE, MERCHANDISE_IMAGE) values((SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?),?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			pstmt.setString(2, merchandiseName);
			pstmt.setInt(3, price);
			pstmt.setString(4, image);
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
	
	/*
	 * 상품 삭제
	 * */
	public boolean merchandiseDelete(String managerId, String[] merchandiseUniqueKey) {
		conn = DBUtil.connection();
		String sql = "DELETE FROM MERCHANDISE WHERE CAFE_UNIQUE_KEY = (SELECT CAFE_UNIQUE_KEY FROM CAFE_MANAGER WHERE MANAGER_ID = ?) AND MERCHANDISE_UNIQUE_KEY = ?;";
		try {
			pstmt = conn.prepareStatement(sql);
			for (int i = 0; i<merchandiseUniqueKey.length; i++) {
				pstmt.setString(1, managerId);
				pstmt.setInt(2, Integer.parseInt(merchandiseUniqueKey[i]));
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
	 * 상품 재료 리스트
	 * */
	public ArrayList<Merchandise> includeMaterialList(int uniqueKey) {
		conn = DBUtil.connection();
		String sql = "SELECT i.INCLUDE_MATERIAL_UNIQUE_KEY, mtr.MATERIAL_UNIQUE_KEY, mtr.MATERIAL_NAME, c.CATEGORY_NAME, i.AMOUNT, u.MATERIAL_UNIT_NAME, mtr.IMAGE FROM MATERIAL_UNIT u, MATERIAL mtr, MATERIAL_CATEGORY c, MERCHANDISE mcds, INCLUDE_MATERIAL i WHERE mcds.MERCHANDISE_UNIQUE_KEY = ? AND mcds.MERCHANDISE_UNIQUE_KEY = i.MERCHANDISE_UNIQUE_KEY AND i.MATERIAL_UNIQUE_KEY = mtr.MATERIAL_UNIQUE_KEY AND u.MATERIAL_UNIT_UNIQUE_KEY = i.MATERIAL_UNIT_UNIQUE_KEY AND mtr.MATERIAL_CATEGORY_UNIQUE_KEY = c.MATERIAL_CATEGORY_UNIQUE_KEY;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, uniqueKey);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int includeMaterialUniqueKey = rs.getInt("i.INCLUDE_MATERIAL_UNIQUE_KEY");
				int materialUniqueKey = rs.getInt("mtr.MATERIAL_UNIQUE_KEY");
				String materialName = rs.getString("mtr.MATERIAL_NAME");
				String categoryName = rs.getString("c.CATEGORY_NAME");
				float amount = rs.getFloat("i.AMOUNT");
				String materialUnitName = rs.getString("u.MATERIAL_UNIT_NAME");
				String image = rs.getString("mtr.IMAGE");
				
				Merchandise merchandises = new Merchandise(includeMaterialUniqueKey,
						materialUniqueKey, materialName, categoryName, amount, materialUnitName, image);

				list.add(merchandises);
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
	 * 상품 제작에 필요한 재료 추가
	 * */
	public boolean newMerchandiseMaterial(int merchandiseUniqueKey, int materialUniqueKey, float amount, int materialUnitUniqueKey) {
		conn = DBUtil.connection();
		String sql = "INSERT INTO INCLUDE_MATERIAL(MERCHANDISE_UNIQUE_KEY, MATERIAL_UNIQUE_KEY, AMOUNT, MATERIAL_UNIT_UNIQUE_KEY) VALUES (?,?,?,?);";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, merchandiseUniqueKey);
			pstmt.setInt(2, materialUniqueKey);
			pstmt.setFloat(3, amount);
			pstmt.setInt(4, materialUnitUniqueKey);
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
	 * 상품 제작에 필요한 재료 삭제
	 * */
	public boolean delMaterial(String[] includeMaterialUniqueKey) {
		conn = DBUtil.connection();
		String sql = "DELETE FROM INCLUDE_MATERIAL WHERE INCLUDE_MATERIAL_UNIQUE_KEY = ?;";
		try {
			pstmt = conn.prepareStatement(sql);
			for (int i = 0; i<includeMaterialUniqueKey.length; i++) {
				pstmt.setInt(1, Integer.parseInt(includeMaterialUniqueKey[i]));
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
}
