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
    <title>SimCard支付</title>
    <link rel="stylesheet" media="screen" href="styles.css" rel="external nofollow"  >
    <style type="text/css">
    button.submit {
    background-color: #68b12f;
    color: white;
    font-weight: bold;
    padding: 6px 20px
    }
    
    body {font: 17px/22px "Lucida Sans", "Lucida Grande", "Lucida Sans Unicode", sans-serif;}
.order_form h2, .order_form label {font-family:Georgia, Times, "Times New Roman", serif;}
.form_hint, .required_notification {font-size: 17px;}

.order_form ul {
    width:100%;
    list-style-type:none;
    list-style-position:outside;
    margin:0px;
    padding:0px;
}
.order_form li{
    padding:16px;
  /*   border-bottom:1px solid #eee; */
    position:relative;
}
.order_form li:first-child, .contact_form li:last-child {
    border-bottom:1px solid #777;
}
.order_form h2 {
   /*  margin:0; */
    display: inline;
    font-size: 20px;
    align: center;
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
    height:40px;
    width:100%;
    padding:5px 8px;
    font-size: 25px;
}
.submitButton{
    background-color: #68b12f;
    font-weight: bold;
    padding: 6px 20px;

}
</style>
<script>
function getUrlParam(name) {
    //构造一个含有目标参数的正则表达式对象 
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    //匹配目标参数 
    var r = window.location.search.substr(1).match(reg);
    //返回参数值 
    if (r != null)
      return unescape(r[2]);
    return null;
  }
//调用微信JS api 支付
function onBridgeReady(){
	var appId = getUrlParam('appId');
    var timeStamp = getUrlParam('timeStamp');
    var nonceStr = getUrlParam('nonceStr');
    var Package = getUrlParam('package');
    var signType = getUrlParam('signType');
    var paySign = getUrlParam('paySign');
   WeixinJSBridge.invoke(
       'getBrandWCPayRequest', {
           "appId" : "wx55391f180ce42fba",
           "timeStamp" : "1395712654",         //时间戳，自1970年以来的秒数     
           "nonceStr" : "e61463f8efa94090b1f366cccfbbb444", //随机串     
           "package" : "prepay_id=u802345jgfjsdfgsdg888",     
           "signType" : "MD5",         //微信签名方式：     
           "paySign" : "70EA570631E4BB79628FBCA90534C63FF7FADD89"
       },
       function(res){     
    	   if (res.err_msg == "get_brand_wcpay_request:ok") {
    	        alert("支付成功");
    	      }
    	      if (res.err_msg == "get_brand_wcpay_request:cancel") {
    	        alert("交易取消");
    	      }
    	      if (res.err_msg == "get_brand_wcpay_request:fail") {
    	        alert("支付失败");
    	      }     
       }); 
}
function callPay() {
    if (typeof WeixinJSBridge == "undefined") {
      if (document.addEventListener) {
        document.addEventListener('WeixinJSBridgeReady', onBridgeReady,
            false);
      } else if (document.attachEvent) {
        document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
        document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
      }
    } else {
      onBridgeReady();
    }
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
  sql = "SELECT u.address as address,u.username as username,u.telno as telno,p.productname as productname, p.unitprice as unitprice, o.quantity as amount FROM weixin.userinfo u,weixin.productmaster p,weixin.orderinfo o where u.userid = o.userid and p.productcode = o.productid and o.orderid=" + orderno;
  rs = stmt.executeQuery(sql);
  while (rs.next()) {
	  PlaceOrder po = new PlaceOrder();
	  po.setProductname(rs.getString("productname"));
	  po.setUnitprice(rs.getString("unitprice"));
	  po.setAmount(rs.getString("amount"));
	  po.setName(rs.getString("username"));
	  po.setTelno(rs.getString("telno"));
	  po.setAddress(rs.getString("address"));
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
<form class="order_form" action="" method="post" name="order_form" align="left">
<ul>
    <li>
         <h2 align="center">订单</h2>
    </li>
    <li>
        <label for="name">名称: <%=pord.getProductname()%></label>
    </li>
    <li>
    <label for="unitprice">单价: <%=pord.getUnitprice()%></label>
    </li>
    <li>
    <label for="num">数量: <%=pord.getAmount()%></label>
    </li>
    <li>
    <label for="toal">总价: <%=pord.getTotalprice()%></label>
    </li>   
     <li>
	<br/>
	</li>
	<li>
    <label>收货信息:</label>
    </li>	
    <li>
    <label for="num">姓名: <%=pord.getName()%></label>
    </li>
    <li>
    <label for="toal">手机号: <%=pord.getTelno()%></label>
    </li>
    <li>
    <label for="toal">收货地址: <%=pord.getAddress()%></label>
    </li>
     <li>
	<br/>
	</li>


<li>
   <!--  <button class="submit" type="button" >提交订单</button> -->
     <input class="submitButton" type="button"  value="提交订单" onclick="callPay();"/>
</li>
</ul>
</form>
</body>
</html>