package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	//db와 접속
	public UserDAO(){
		try {
			String dbURL = "jdbc:mysql://fruitking.czxyyplvdfua.us-east-2.rds.amazonaws.com/fruitking?serverTimezone=UTC&autoReconnect=true&useSSL=false";
			String dbID = "master";
			String dbPassword = "password";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//로그인
	public int login(String ID) {
		String SQL1 = "select id, accesstoken, refreshtoken from user where id = ?";
		String SQL2 = "update user set accesstoken = ?, refreshtoken = ?";
		try {
			pstmt = conn.prepareStatement(SQL1);
			pstmt.setString(1, ID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(ID)) {
					pstmt = conn.prepareStatement(SQL2);
					pstmt.setString(1, rs.getString(2));
					pstmt.setString(2, rs.getString(3));
					pstmt.executeUpdate();
					return 1;	//로그인 성공
				} else {
					return 0;	//id 없음
				}
			} 
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;	//db 오류
	}
	
	//회원 등록
	public int regist(String ID, String Email, String Name, String Age, String Birth, String Gender, String Accesstoken, String Refreshtoken) {
		String SQL = "insert into user values(?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, ID);
			pstmt.setString(2, Email);
			pstmt.setString(3, Name);
			pstmt.setString(4, Age);
			pstmt.setString(5, Birth);
			pstmt.setString(6, Gender);
			pstmt.setString(7, Accesstoken);
			pstmt.setString(8, Refreshtoken);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//db 오류
	}
	
}
