package demo.imp;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.List;

import demo.dao.transferinformation;					  

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class StudentImp {
	/**
	* 初始化iBatis获得一个SqlMapClient对象
	*
	* @param
	* @return SqlMapClient
	*/
	public static SqlMapClient getSqlMapClient() {
		String resource = "demo/xml/SqlMapConfig.xml";
		SqlMapClient sqlMapClient = null;
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapClient = SqlMapClientBuilder.buildSqlMapClient(reader);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return sqlMapClient;
	}
    
	/**
	* 根据姓名在数据表中查找对应的学生
	*
	* @param name: 需要查找的学生姓名
	* @return: 查找后的学生
	*/
	public static List<transferinformation> getStudentByName(int name) {
		SqlMapClient sqlMapClient = getSqlMapClient();
		List<transferinformation> students = null;
		try {
			sqlMapClient.startTransaction();
			students = sqlMapClient.queryForList("transferinformation.findTransferinformationByName", name);
			sqlMapClient.commitTransaction();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				sqlMapClient.endTransaction();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return students;
	}
    
	public static void main(String[] args) throws SQLException {
		List<transferinformation> ti = getStudentByName(21);
		if (null != ti) {
			String aa = String.valueOf(ti.get(0).getProductid());
			System.out.println("Eclipse Build iBatis Success!" + aa);
		}
		else
		{
			System.out.println("Eclipse Build iBatis Fail!");
		}
	}
}