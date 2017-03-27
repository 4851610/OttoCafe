package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
	public static Connection connection() {
		Connection conn = null;

		String jdbc_driver = "com.mysql.jdbc.Driver";
		String jdbc_url = "jdbc:mysql://223.222.25.16:3306/020cafe?useUnicode=true&characterEncoding=utf8";
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "mos", "mosquito");
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}
