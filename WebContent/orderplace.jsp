<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="demo.javabean.PlaceOrder" %>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mysql.jdbc.Connection" %>
<%@ page import="com.mysql.jdbc.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.mysql.jdbc.Connection" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%! 
PlaceOrder pord = null;
%> 
<html>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<head>
    <meta charset="utf-8">
    <title>Order Contact Form</title>
    <link rel="stylesheet" media="screen" href="styles.css" rel="external nofollow"  >
    <style type="text/css">
    button.submit {
    background-color: #68b12f;
    color: white;
    font-weight: bold;
    padding: 6px 20px
    }
    
    body {font: 14px/21px "Lucida Sans", "Lucida Grande", "Lucida Sans Unicode", sans-serif;}
.order_form h2, .order_form label {font-family:Georgia, Times, "Times New Roman", serif;}
.form_hint, .required_notification {font-size: 16px;}

.order_form ul {
    width:100%;
    list-style-type:none;
    list-style-position:outside;
    margin:0px;
    padding:0px;
}
.order_form li{
    padding:18px;
    border-bottom:1px solid #eee;
    position:relative;
}
.order_form li:first-child, .contact_form li:last-child {
    border-bottom:1px solid #777;
}
.order_form h2 {
    margin:0;
    display: inline;
    font-size: 20px;
}
.required_notification {
    color:#d45252;
    margin:5px 0 0 0;
    display:inline;
    float:right;
}
.order_form label {
    width:50%;
    margin-top: 3px;
    display:inline-block;
    float:left;
}
.order_form input {
    height:20px;
    width:50%;
    padding:5px 8px;
}
.order_form button {margin-left:156px;}

</style>
<script>
function jump(){
	window.location.href="http://localhost:8080/GRCRM_2015/paid.jsp";
}
</script>
</head>
<body>
<%
List ddwhoneList = new ArrayList();
Connection conn = null;
String url = "jdbc:mysql://localhost:3306/weixin?"
		+ "user=root&password=grids&useUnicode=true&characterEncoding=UTF8";
Statement stmt = null;
ResultSet rs = null;
String sql = "";
String orderno = (String)request.getAttribute("orderno");
try{
  Class.forName("com.mysql.jdbc.Driver");// 动态加载mysql驱动
  conn = (Connection) DriverManager.getConnection(url);
  
  // �f�[�^�x�[�X�ɑ΂��鏈��
  stmt = (Statement) conn.createStatement();
  sql = "SELECT p.productname as productname,o.price as unitprice, o.amount as amount FROM weixin.productmaster p,weixin.orderinfo o where p.productcode = o.productid and o.orderid=" + orderno;
  rs = stmt.executeQuery(sql);
  while (rs.next()) {
	  PlaceOrder po = new PlaceOrder();
	  po.setName(rs.getString("productname"));
	  po.setUnitprice(rs.getString("unitprice"));
	  po.setAmount(rs.getString("amount"));
	  int total = (Integer.parseInt(rs.getString("amount")))*(Integer.parseInt(rs.getString("unitprice")));
	  po.setTotalprice(String.valueOf(total)); 
      ddwhoneList.add(po);
  }
}catch (SQLException e){
	e.printStackTrace();
}catch (Exception e) {
    e.printStackTrace();
} finally {
	conn.close();
}

pord = (PlaceOrder)ddwhoneList.get(0);
%>
<form class="order_form" action="" method="post" name="order_form" align="center">
<ul>
    <li>
         <h2>下单</h2>
    </li>
    <li>
        <label for="name">名称:</label>
       <label for="name1"><%=pord.getName()%></label>
    </li>
    <li>
    <label for="unitprice">单价:</label>
     <label for="unitprice1"><%=pord.getUnitprice()%></label>
    </li>
  <li>
    <label for="num">数量:</label>
   <label for="num1"><%=pord.getAmount()%></label>
</li>
  <li>
    <label for="toal">总价:</label>
   <label for="toal1"><%=pord.getTotalprice()%></label>
</li>

<li>
    <button class="submit" type="button" onclick="jump()">立即支付</button>
</li>
</ul>
</form>
</body>
</html>