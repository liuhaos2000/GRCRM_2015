package demo.process;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Result;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

import javax.transaction.*;

import demo.javabean.OrderInfo;

public class UpdateOrderInfoProcess extends ActionSupport{

	private int orderid = 0;
	private String name = "";
	private String telno = "";
	private String cardtype = "";
	private int quantity;
	private String address = "";
	private String periodtojapan = "";
	private String purposetojapan = "";
	private String destination = "";

	public int getOrderid() {
		return orderid;
	}
	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public String getPeriodtojapan() {
		return periodtojapan;
	}
	public void setPeriodtojapan(String periodtojapan) {
		this.periodtojapan = periodtojapan;
	}
	public String getPurposetojapan() {
		return purposetojapan;
	}
	public void setPurposetojapan(String purposetojapan) {
		this.purposetojapan = purposetojapan;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getCardtype() {
		return cardtype;
	}
	public void setCardtype(String cardtype) {
		this.cardtype = cardtype;
	}
	public String getTelno() {
		return telno;
	}
	public void setTelno(String telno) {
		this.telno = telno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	

	public String execute() throws Exception{

		final long serialVersionUID = 7620009925942346125L;  
		 
		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/weixin?"
				+ "user=root&password=grids&useUnicode=true&characterEncoding=UTF8";
		Statement stmt = null;
		ResultSet rs = null;
		boolean result1= false;
		try{
		  Class.forName("com.mysql.jdbc.Driver");// 动态加载mysql驱动
		  conn = (Connection) DriverManager.getConnection(url);
		  
		  // �f�[�^�x�[�X�ɑ΂��鏈��
		  stmt = (Statement) conn.createStatement();
		  
		  

		  
		  String sql1 = "update weixin.orderinfo set quantity = " + String.valueOf(quantity) + " where orderid = " + orderid;
		  result1=stmt.execute(sql1);
		  	
		  conn.commit();
		 
		}catch (SQLException e){
			e.printStackTrace();
		}catch (Exception e) {
            e.printStackTrace();
        } finally {
        	conn.close();
        }
		
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("orderno", String.valueOf(orderid));
		  
        return "success";

	}
    

	public int maxOrderId() throws Exception{

		final long serialVersionUID = 7620009925942346125L;  
		 
		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/weixin?"
				+ "user=root&password=grids&useUnicode=true&characterEncoding=UTF8";
		Statement stmt = null;
		ResultSet rs = null;
		int orderid = 0;
		try{
		  Class.forName("com.mysql.jdbc.Driver");// 动态加载mysql驱动
		  conn = (Connection) DriverManager.getConnection(url);
		  
		  // �f�[�^�x�[�X�ɑ΂��鏈��
		  stmt = (Statement) conn.createStatement();
		  
		  String sql1 = "select max(orderid) as orderid from weixin.orderinfo";
				  
		  //result1=stmt.execute(sql);
		  rs=stmt.executeQuery(sql1);
		  if(rs.next()){
			  orderid = Integer.parseInt(rs.getString("orderid"));
		  }
		  
	
		 conn.commit();
		 
		}catch (SQLException e){
			e.printStackTrace();
		}catch (Exception e) {
            e.printStackTrace();
        } finally {
        	conn.close();
        }
		  
        return orderid;

	}
}
