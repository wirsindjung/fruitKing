package notify;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class NotifyDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public NotifyDAO() {
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
	
	public ArrayList<NotifyDTO> getNotify(int pageNumber) {
		String SQL = "select * from notify where id < ? order by id desc limit 10";
		ArrayList<NotifyDTO> notify = new ArrayList<NotifyDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				NotifyDTO NotifyDTO = new NotifyDTO();
				NotifyDTO.setId(rs.getInt(1));
				NotifyDTO.setTitle(rs.getString(2));
				NotifyDTO.setContent(rs.getString(3));
				NotifyDTO.setDate(rs.getString(4));
				notify.add(NotifyDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return notify;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "select * from notify where id < ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public int write(String title, String content) {
		String SQL = "insert into notify values(?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setString(4, getDate());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int getNext() {
		String SQL = "select id from notify order by id desc";
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

	public String getDate() {
		String SQL = "select now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public NotifyDTO getNextNotify(int id) {
		String SQL = "select * from notify where id > ? order by id asc limit 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				NotifyDTO NotifyDTO = new NotifyDTO();
				NotifyDTO.setId(rs.getInt(1));
				NotifyDTO.setTitle(rs.getString(2));
				NotifyDTO.setContent(rs.getString(3));
				NotifyDTO.setDate(rs.getString(4));
				return NotifyDTO;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public NotifyDTO getPriorNotify(int id) {
		String SQL = "select * from notify where id < ? order by id desc limit 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				NotifyDTO NotifyDTO = new NotifyDTO();
				NotifyDTO.setId(rs.getInt(1));
				NotifyDTO.setTitle(rs.getString(2));
				NotifyDTO.setContent(rs.getString(3));
				NotifyDTO.setDate(rs.getString(4));
				return NotifyDTO;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public NotifyDTO getNotifyDTO(int id) {
		String SQL = "select * from notify where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				NotifyDTO NotifyDTO = new NotifyDTO();
				NotifyDTO.setId(rs.getInt(1));
				NotifyDTO.setTitle(rs.getString(2));
				NotifyDTO.setContent(rs.getString(3));
				NotifyDTO.setDate(rs.getString(4));
				return NotifyDTO;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
