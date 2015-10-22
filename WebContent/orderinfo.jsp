<%@ page contentType="text/html;charset=UTF-8" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<%@ page import="java.util.List" %>
<%@ page import="demo.javabean.OrderInfo" %>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mysql.jdbc.Connection" %>
<%@ page import="com.mysql.jdbc.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.mysql.jdbc.Connection" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>  
<head>
<meta charset="utf-8">
<title>Prepaid SIM for JAPAN</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Bootstrap -->
<link rel="stylesheet" href="${path}/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="${path}/resources/css/style.css">
<link rel="stylesheet" href="${path}/resources/css/media.css">
</head>
<body>  
    <header class="head-top" role="navigation">
        <div class="container">
            <div class="row head-row">
                <div class="col-md-2 col-sm-2 col-xs-2 col-head">
                    <a class="head-back" href="javascript:history.back();"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span></a>
                </div>
                <div class="col-md-8 col-sm-8 col-xs-8 col-head">
                    <p class="head-row-text">SimCard产品列表</p>
                </div>
                <div class="col-md-2 col-sm-2 col-xs-2 col-head">
                    <a class="head-back" href="/GRCRM_2015"><span class="glyphicon glyphicon-home" aria-hidden="true"></span></a>
                </div>
            </div>
        </div>
    </header>
  
<!-- <table class="myTable" align="center" width=100% height="652"  id="orderTable"> -->
 
<%
List ddwhoneList = new ArrayList();
Connection conn = null;
String url = "jdbc:mysql://localhost:3306/weixin?"
		+ "user=root&password=grids&useUnicode=true&characterEncoding=UTF8";
Statement stmt = null;
ResultSet rs = null;
String sql = "";
String telno = (String)request.getAttribute("telno");
try{
  Class.forName("com.mysql.jdbc.Driver");// 动态加载mysql驱动
  conn = (Connection) DriverManager.getConnection(url);
  
  // �f�[�^�x�[�X�ɑ΂��鏈��
  stmt = (Statement) conn.createStatement();
  sql = "SELECT o.orderid as orderno,o.productid as commodity,o.status as status,u.telno as telno FROM weixin.orderinfo o,weixin.userinfo u where o.userid = u.userid and u.telno=" + telno;
	 
  rs = stmt.executeQuery(sql);
  while (rs.next()) {
	  OrderInfo orinfo = new OrderInfo();
      orinfo.setOrderno(rs.getString("orderno"));
      orinfo.setCommodity(rs.getString("commodity"));
      orinfo.setStatus(rs.getString("status"));
      orinfo.setTelno(rs.getString("telno"));
      ddwhoneList.add(orinfo);
  }
}catch (SQLException e){
	e.printStackTrace();
}catch (Exception e) {
    e.printStackTrace();
} finally {
	conn.close();
}
if(ddwhoneList.size()!=0)
{
	 out.print("<table class='table table-bordered' align='center' width=100%  id='orderTable'>");
	 out.print("<tr id='orderTr' bgcolor='#3DB7CC'>");
     out.print("<th align='center'>"+"订单号"+"</th>");
	 out.print("<th align='center'>"+"商品"+"</th>");
	 out.print("<th align='center'>"+"状态"+"</th>");
	 out.print("<th align='center'>"+"手机号码"+"</th>");
     out.print("</tr>");
     
	for(int i=0;i<ddwhoneList.size();i++)
	{
		OrderInfo news = (OrderInfo)ddwhoneList.get(i);
	
		out.print("<tr>");
		if(news.getStatus().equals("预约")){
			out.print("<td >"+"<a href=http://localhost:8080/GRCRM_2015/order.jsp?orderno=" + news.getOrderno() + ">" + news.getOrderno()+"</a>"+"</td>");
		}else{
			out.print("<td >"+ news.getOrderno()+"</td>");	
		}
		out.print("<td >"+news.getCommodity()+"</td>");
		out.print("<td >"+news.getStatus()+"</td>");
		out.print("<td >"+news.getTelno()+"</td>");
		out.print("</tr>");
	
	}
	out.print("</table>");
}else{
	out.print("<tr>");
	out.print("</tr>");
	out.print("<tr>");
	out.print("<span class='required_notification'>"+"* 没有查询到该手机号码的订单"+"</span>");
	out.print("</tr>");
}
%>
  
   
</body>
</html>