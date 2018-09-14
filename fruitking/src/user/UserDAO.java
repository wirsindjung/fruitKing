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
	public int login(String Email) {
		String SQL = "select id from user where email = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, Email);
			rs = pstmt.executeQuery();
			if(rs.next()) {	//db에 아이디 존재
				return 1;
			}
			return 0;	//id 없음
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;	//db 오류
	}
	
	//회원 등록
	public int regist(String Email, String Name, int Age, String Birth, Boolean Gender) {
		String SQL = "insert into user values(?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, Email);
			pstmt.setString(3, Name);
			pstmt.setInt(4, Age);
			pstmt.setString(5, Birth);
			pstmt.setBoolean(6, Gender);
			pstmt.setInt(7, 2);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//db 오류
	}
	
	public int getNext() {
		String SQL = "select id from user order by id desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}	
}
