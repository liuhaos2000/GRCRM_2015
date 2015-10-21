<%@ page contentType="text/html;charset=UTF-8" %> 
<%@ page import="java.util.List" %>
<%@ page import="demo.javabean.CardInfo" %>
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
<meta name="viewport"  content="width=device-width, user-scalable=no"/>
  <head>
    <meta charset="utf-8">
    <title>SimCard产品列表</title>
    <link rel="stylesheet" media="screen" href="styles.css" rel="external nofollow">
    <style type="text/css">
    .myTable {border-collapse:collapse;}
    .myTable td {border:1px solid black;}
    .myTable th {border:1px solid black;}
    </style>
 </head>
<body>
  
<table class="myTable" align="center"  height="145" width="350" id="orderTable">
<%
List ddwhoneList = new ArrayList();
Connection conn = null;
String url = "jdbc:mysql://localhost:3306/weixin?"
		+ "user=root&password=grids&useUnicode=true&characterEncoding=UTF8";
Statement stmt = null;
ResultSet rs = null;
String sql = "";
String cardsize = request.getParameter("cardsize").toString();
try{
  Class.forName("com.mysql.jdbc.Driver");// 动态加载mysql驱动
  conn = (Connection) DriverManager.getConnection(url);
  
  // �f�[�^�x�[�X�ɑ΂��鏈��
  stmt = (Statement) conn.createStatement();
sql = "SELECT p.image1 as image1,p.unitprice as unitprice, p.middleclassification as middlefi, p.productcode as productcode FROM weixin.productmaster p where p.largeclassification=" + cardsize;  
rs = stmt.executeQuery(sql);
  while (rs.next()) {
	  CardInfo cardin = new CardInfo();
	  cardin.setImage(rs.getString("image1"));
	  cardin.setPrice(rs.getString("unitprice"));
	  cardin.setDeadline(rs.getString("middlefi"));
	  cardin.setProductcode(rs.getString("productcode"));
	  
      ddwhoneList.add(cardin);
  }

 
}catch (SQLException e){
	e.printStackTrace();
}catch (Exception e) {
    e.printStackTrace();
} finally {
	conn.close();
}

if(ddwhoneList!=null)
{
	for(int i=0;i<ddwhoneList.size();i++)
	{
		CardInfo news = (CardInfo)ddwhoneList.get(i);
	out.print("<tr>");	

	out.print("<td align='center'><a href=http://localhost:8080/GRCRM_2015/buycard.jsp?productcode=" + news.getProductcode() + ">" + "<img src=" + news.getImage() + "></a></td>");

	out.print("<td align='center'>￥"+news.getPrice()+"</td>");
	out.print("<td align='center'>"+"使用期限： "+news.getDeadline()+"</td>");
	out.print("</tr>");
	}
}
%>
  
   
 </table> 
</body>
</html>