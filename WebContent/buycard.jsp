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
<%! 
CardInfo pord = null;
%> 
<html>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<head>
    <meta charset="utf-8">
    <title>SimCard产品列表</title>
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
    padding:13px;
    /* border-bottom:1px solid #eee; */
    position:relative;
}
.order_form li:first-child, .contact_form li:last-child {
    border-bottom:1px solid #777;
}
.order_form h2 {
    /* margin:0; */
    display: inline;
    font-size: 20px;
    text-align:center
}
.required_notification {
    color:#d45252;
    margin:5px 0 0 0;
    display:inline;
    float:right;
}
.order_form label {
    width:100%;
    margin-top: 3px;
    display:inline-block;
    float:left;
}
.order_form input {
    height:40px;
    width:100%;
    padding:5px 8px;
    font-size: 25px;
}
/* .order_form button {margin-left:156px;} */
.submitButton{

  /*    height:30px;
    background-color:red;  */
    background-color: #68b12f;
    font-weight: bold;
    padding: 6px 20px;

}
</style>
<script language="javascript">
function GetRequest() { 
	var url = location.search; //获取url中"?"符后的字串 
	var theRequest = new Object(); 
	if (url.indexOf("?") != -1) { 
	var str = url.substr(1); 
	strs = str.split("&"); 
	for(var i = 0; i < strs.length; i ++) { 
	theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]); 
	} 
	} 
	return theRequest; 
	} 
function jump(){
	var Request = new Object(); 
	Request = GetRequest(); 
	var productcode = Request['productcode']; 
	window.location.href="http://localhost:8080/GRCRM_2015/orderadd.jsp?productcode=" + productcode;
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
String productcode = (String)request.getParameter("productcode");
try{
  Class.forName("com.mysql.jdbc.Driver");// 动态加载mysql驱动
  conn = (Connection) DriverManager.getConnection(url);
  
  // �f�[�^�x�[�X�ɑ΂��鏈��
  stmt = (Statement) conn.createStatement();
  sql = "SELECT p.productname as productname,p.image2 as image2,p.image1 as image1,p.unitprice as price FROM weixin.productmaster p where p.productcode =" + productcode;
  rs = stmt.executeQuery(sql);
  while (rs.next()) {
	  CardInfo po = new CardInfo();
	  po.setImage(rs.getString("image1"));
	  po.setPrice(rs.getString("price"));
	  po.setImage2(rs.getString("image2"));
	  po.setProductname(rs.getString("productname"));
      ddwhoneList.add(po);
  }
}catch (SQLException e){
	e.printStackTrace();
}catch (Exception e) {
    e.printStackTrace();
} finally {
	conn.close();
}

pord = (CardInfo)ddwhoneList.get(0);
%>
<form class="order_form" action="" method="post" name="order_form" align="left">
<ul>
    <li>
         <h2>购买SimCard</h2>
    </li>
    <li>
        <label for="name"><%=pord.getProductname()%></label>     
        <%
       out.print("<td align='center'><img src=" + pord.getImage() + "></td>");
        %>
       
    </li>
    <li>
    <label for="unitprice">原价: <%=pord.getPrice()%></label>
    </li>
  <li>
    <label for="num">优惠价: <%=pord.getPrice()%></label>
</li>
  <li>
    <label for="toal">特点:</label>
</li>
<li>
      <label for="num1"><%=pord.getImage2()%></label>
</li>

<!-- <li>
    <button class="submit" type="button" onclick="jump()">立即购买</button>
</li> -->
<li>
	   <input class="submitButton" type="button" id="submitButton" value="立即购买" onclick="jump()"/>
	</li>
 <li>
    <label for="toal">使用说明:</label>
</li>
 <li>
      <label for="num1">服务可在NTT DOCOMO的“Xi (crossy) 4G LTE”和“FOMA 3G”服务区内使用，通过两者均可在全日本建立可靠的连接</label>
</li>
 <li>
    <label for="toal">温馨提示:</label>
</li>
 <li>
      <label for="num1">150Mbps是理论最高速度；实际速度有所不同，也没有保证,每天的高速数据配额用尽后，当日最大下载和上传速度将会降至200kbps。</label>
</li>
</ul>
</form>
</body>
</html>