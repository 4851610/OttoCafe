package manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DBUtil;

public class ManagerDao {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	ArrayList<Manager> list = new ArrayList<Manager>();

	/**
	 * 매니저 회원가입
	 * */
	public boolean addManager(Manager manager) {
		conn = DBUtil.connection();
		String sql = "insert into CAFE_MANAGER (cafe_unique_key, manager_id, manager_pw, manager_name) values(?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, manager.getCafeUniqueKey());
			pstmt.setString(2, manager.getManagerId());
			pstmt.setString(3, manager.getManagerPW());
			pstmt.setString(4, manager.getManagerName());
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
	 * 매니저 로그인
	 * */
	public boolean login(String managerId, String managerPW) {
		conn = DBUtil.connection();
		String sql = "select * from CAFE_MANAGER where MANAGER_ID = ?";
		boolean result = false;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			rs = pstmt.executeQuery();
			rs.next();
			if (rs.getString("MANAGER_PW").equals(managerPW))
				result = true;
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
		return result;
	}

	/**
	 * 아이디 중복확인
	 * */
	public boolean checkId(String managerId) {
		conn = DBUtil.connection();
		String sql = "select MANAGER_ID from CAFE_MANAGER where MANAGER_ID = ?";
		boolean result = false;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			rs = pstmt.executeQuery();
			rs.next();
			if (rs.getString("MANAGER_ID").equals(managerId))
				result = true;
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
		return result;
	}

	/**
	 * 회원가입 카페 목록
	 * */
	public ArrayList<Manager> cafeList() {
		conn = DBUtil.connection();
		String sql = "SELECT CAFE_UNIQUE_KEY, CAFE_NAME FROM CAFE";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int cafeUniqueKey = rs.getInt("CAFE_UNIQUE_KEY");
				String cafeName = rs.getString("CAFE_NAME");

				Manager manager = new Manager(
						cafeUniqueKey, cafeName);

				list.add(manager);
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
	 * 아이디 찾기
	 * */
	public String searchId(int cafeUniqueKey, String name) {
		conn = DBUtil.connection();
		String sql = "SELECT MANAGER_ID FROM CAFE_MANAGER WHERE CAFE_UNIQUE_KEY = ? AND MANAGER_NAME = ?;";
		String id="";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cafeUniqueKey);
			pstmt.setString(2, name);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				id = rs.getString("MANAGER_ID");				
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
		return id;
	}
	
	/**
	 * 비밀번호 찾기
	 * */
	public String searchPasswd(int cafeUniqueKey, String name, String id) {
		conn = DBUtil.connection();
		String sql = "SELECT MANAGER_PW FROM CAFE_MANAGER WHERE CAFE_UNIQUE_KEY = ? AND MANAGER_NAME = ? AND MANAGER_ID = ?;";
		String passwd="";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cafeUniqueKey);
			pstmt.setString(2, name);
			pstmt.setString(3, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				passwd = rs.getString("MANAGER_PW");				
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
		return passwd;
	}
	
	/**
	 * 임시 비밀번호 업데이트
	 * */
	public boolean updatePw(String password, int cafeUniqueKey, String name, String id) {
		conn = DBUtil.connection();
		String sql = "UPDATE CAFE_MANAGER SET MANAGER_PW = ? WHERE CAFE_UNIQUE_KEY = ? AND MANAGER_ID = ? AND MANAGER_NAME = ?;";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, password);
			pstmt.setInt(2, cafeUniqueKey);
			pstmt.setString(3, name);
			pstmt.setString(4, id);
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
}
