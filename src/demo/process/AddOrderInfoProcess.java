package demo.process;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.ServletContext;
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
import demo.javabean.UserInfo;
import demo.util.MD5Util;

public class AddOrderInfoProcess extends ActionSupport{

	private String name = "";
	private String telno = "";
	private String cardtype = "";
	private int quantity;
	private String address = "";
	private String periodtojapan = "";
	private String purposetojapan = "";
	private String destination = "";
	private String ads = "";

	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getAds() {
		return ads;
	}
	public void setAds(String ads) {
		this.ads = ads;
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
		HttpServletRequest request = ServletActionContext.getRequest();
		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/weixin?"
				+ "user=root&password=grids&useUnicode=true&characterEncoding=UTF8";
		Statement stmt = null;
		ResultSet rs = null;
		boolean result= false;
		boolean result1= false;
		int str01 = 0;
		String openid = "";
		try{
		  Class.forName("com.mysql.jdbc.Driver");// 动态加载mysql驱动
		  conn = (Connection) DriverManager.getConnection(url);
		  
		  // �f�[�^�x�[�X�ɑ΂��鏈��
		  stmt = (Statement) conn.createStatement();
		 /* HttpSession httpSession = ServletActionContext.getRequest().getSession(); 
		  String openid = httpSession.getAttribute("opid").toString();*/
		  
		/*  ActionContext ac = ActionContext.getContext();
		  Map session = ac.getSession();
		  UserInfo user = (UserInfo) session.get("openid");
		  String openid = user.getOpenid();*/
		  
		  
		  ServletContext application = ServletActionContext.getServletContext();
		  UserInfo user = (UserInfo)application.getAttribute("openid");
		  openid = user.getOpenid();
		  
		  str01 = maxOrderId() + 1;
		  int str02 = 1345;
		  int str03 = 2345;
		  int str04 = Integer.parseInt(cardtype);
          String str05 = String.valueOf(quantity);
          String str06 = "26";
          String str07 = "20000";
          String str08 = "5%";
          String str09 = "2015/02/16";
          String str010 = "预约";
          String str011 = "邮政银行";
          String str012 = "2777";
          String str013 = "有";
          String str014 = "2015/02/26";
          
          String str015 = "20%";
          
          String str016 = "1000";
          String str017 = "30%";
          String str018 = "2015/02/02";
          String str019 = "wang";
          String str020 = "2015/02/09";
          String str021 = "li000";
          String str022 = name;
          String str023 = telno;
          String str024 = ads;
          

		  
		  String sql1 = "insert into weixin.orderinfo values('" + str01 + "','" + openid + "','" + str03 + "','" + str04 + "','"
				  + str05 + "','"+ str06 + "','" + str07 + "','" + str08 + "','"+ str09 + "','" + str010 + "','"+ str011 + "','"
				  + str012 + "','"+ str013 + "','"+ str014 + "','"+ str015 + "','"+ str016  + "','"
				  + str017 + "','"+ str018 + "','"+ str019 + "','"+ str020 + "','"+ str021 + "')";
		  
		  
		  
		  String sql = "update weixin.userinfo set username = '" + str022 + "' , telno = '" + str023 + "' , address = '" + str024 + "'  where userid = '" + openid + "'";
				  
		  result=stmt.execute(sql);
		  result1=stmt.execute(sql1);
		  
		  
		  
	
		 conn.commit();
		 
		}catch (SQLException e){
			e.printStackTrace();
		}catch (Exception e) {
            e.printStackTrace();
        } finally {
        	conn.close();
        }
		
		
		request.setAttribute("orderno", String.valueOf(str01));
		/////////支付参数//////////////
		//1.openid
		request.setAttribute("openid", openid);
		//2.签名
		SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
		String sign = createSign("charaEnch",parameters);
		///////////////////////
		  
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
	
	public static String createSign(String characterEncoding, SortedMap<Object,Object> parameters){
		StringBuffer sb = new StringBuffer();
		Set es = parameters.entrySet();
		Iterator it = es.iterator();
		while(it.hasNext()){
			Map.Entry entry = (Map.Entry)it.next();
			String k = (String)entry.getKey();
			Object v = entry.getValue();
			if(null != v && !"".equals(v)
					&& !"sign".equals(k)&&!"key".equals(k)){
				sb.append(k + "=" + v + "&");
			}
		}
		sb.append("key=" + "ConfigUtil.API_KEY");
		String sign = MD5Util.MD5Encode(sb.toString(),characterEncoding).toUpperCase();
		return sign;
		
		}
	

}
