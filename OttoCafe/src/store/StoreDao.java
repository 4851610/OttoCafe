package store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DBUtil;

public class StoreDao {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	ArrayList<Store> list = new ArrayList<Store>();
	
	/**
	 * 마이페이지 거래처 리스트
	 * */
	public ArrayList<Store> StoreList() {
		conn = DBUtil.connection();
		String sql = "SELECT * FROM MATERIAL_STORE ORDER BY MATERIAL_STORE_UNIQUE_KEY DESC";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int storeUniqueKey = rs.getInt("MATERIAL_STORE_UNIQUE_KEY");
				String storeName = rs.getString("MATERIAL_STORE_NAME");
				String storeHompage = rs.getString("HOMEPAGE");
				String storeTel = rs.getString("TEL");
				String storeRepresentative = rs.getString("REPRESENTATIVE");

				Store stores = new Store(storeUniqueKey, storeName, storeHompage, storeTel, storeRepresentative);

				list.add(stores);
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
	 * 마이페이지 거래처 등록
	 * */
	public boolean addStore(Store store) {
		conn = DBUtil.connection();
		String sql = "insert into MATERIAL_STORE (MATERIAL_STORE_NAME, HOMEPAGE, TEL, REPRESENTATIVE) values(?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, store.getStoreName());
			pstmt.setString(2, store.getStoreHomepage());
			pstmt.setString(3, store.getStoreTel());
			pstmt.setString(4, store.getStoreRepresentative());
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
	 * 재료등록 거래처 리스트
	 * */
	public ArrayList<Store> materialStoreList() {
		conn = DBUtil.connection();
		String sql = "SELECT MATERIAL_STORE_UNIQUE_KEY, MATERIAL_STORE_NAME FROM MATERIAL_STORE ORDER BY MATERIAL_STORE_UNIQUE_KEY DESC";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int storeUniqueKey = rs.getInt("MATERIAL_STORE_UNIQUE_KEY");
				String storeName = rs.getString("MATERIAL_STORE_NAME");

				Store stores = new Store(storeUniqueKey, storeName);

				list.add(stores);
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
	 * 거래처 삭제
	 * */
	public boolean materialStoreDelete(String[] materialStoreUniqueKey) {
		conn = DBUtil.connection();
		String sql = "DELETE FROM MATERIAL_STORE WHERE MATERIAL_STORE_UNIQUE_KEY = ?;";
		try {
			pstmt = conn.prepareStatement(sql);
			for (int i = 0; i<materialStoreUniqueKey.length; i++) {
				System.out.println(materialStoreUniqueKey[i]);
				pstmt.setInt(1, Integer.parseInt(materialStoreUniqueKey[i]));
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
	 * 마이페이지 거래처 등록 리스트 총 레코드
	 * */
	public int totalRecord() {
		conn = DBUtil.connection();
		String sql1 = "SELECT COUNT(MATERIAL_STORE_UNIQUE_KEY) AS TOTAL_RECORD FROM MATERIAL_STORE;";
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
}
