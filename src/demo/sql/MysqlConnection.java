package demo.sql;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

public class MysqlConnection {
	
	public static ResultSet query() throws Exception {
		
		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/test?"
				+ "user=root&password=grids&useUnicode=true&characterEncoding=UTF8";
		Statement stmt = null;
		ResultSet rs = null;
		try{
		  Class.forName("com.mysql.jdbc.Driver");// 动态加载mysql驱动
		  conn = (Connection) DriverManager.getConnection(url);
		  
		  // �f�[�^�x�[�X�ɑ΂��鏈��
		  stmt = (Statement) conn.createStatement();
		  String sql = "SELECT * FROM test.orderinfo";
		  rs = stmt.executeQuery(sql);
		  while (rs.next()) {
              System.out
                      .println(rs.getString(1) + "\t" + rs.getString(2));
          }
		}catch (SQLException e){
			e.printStackTrace();
		}catch (Exception e) {
            e.printStackTrace();
        } finally {
        	conn.close();
        }
		return rs;
	}
	public static void main(String[] args) {
		
	}
}
