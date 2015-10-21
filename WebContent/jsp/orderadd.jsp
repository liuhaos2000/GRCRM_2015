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
  sql = "SELECT p.smallclassification as cardtype,p.productname as productname,p.unitprice as price,p.productcode as productcode FROM weixin.productmaster p where p.productcode =" + productcode;
  rs = stmt.executeQuery(sql);
  while (rs.next()) {
	  CardInfo po = new CardInfo();
	  po.setProductname(rs.getString("productname"));
	  po.setPrice(rs.getString("price"));
	  po.setProductcode(rs.getString("productcode"));
	  po.setSimcardtype(rs.getString("cardtype"));
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
<html>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<head>
    <meta charset="utf-8">
    <title><%=pord.getProductname()%></title>
    <link rel="stylesheet" media="screen" href="styles.css" rel="external nofollow"  >
    <style type="text/css">
    button.submit {
    background-color: #68b12f;
    font-weight: bold;
    padding: 6px 20px
    }
    
    body {font: 16px/25px "Lucida Sans", "Lucida Grande", "Lucida Sans Unicode", sans-serif;}
.order_form h2, .order_form label {font-family:Georgia, Times, "Times New Roman", serif;}
.form_hint, .required_notification {font-size: 32px;}

.order_form ul {
    width:100%;
    list-style-type:none;
    list-style-position:outside;
    margin:0px;
    padding:0px;
}
.order_form li{
     padding:1px;
     /* border-bottom:2px solid #eee; */ 
     position:relative;  
}
.order_form li:first-child, .contact_form li:last-child {
    display:inline
    border-bottom:1px solid #777;
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
    padding:3px;
}
.input_txt2 {
    height:40px;
    width:100%;
    padding:5px 8px;
    font-size: 25px;
}
.input_txt {
    height:40px;
    width:30%;
    padding:5px 8px;
    font-size: 25px;
}
.input_button {
    font-weight: bold;
    /*height:35px;
    width:3%;
     text-align:center;
    padding:5px 8px;
    font-size: 25px;
    padding: 6px 20px */
}
.order_form button {
    margin-left:156px;   
}

.submitButton{

    /* height:30px;
    background-color:red; */
    background-color: #68b12f;
    font-weight: bold;
    height:40px;
    width:100%;
    padding:5px 8px;
    font-size: 25px;
    padding: 6px 20px

}
.vertical{
vertical-align:middle;
}
</style>
<script type="text/javascript" src="http://www.daixiaorui.com/Public/js/jquery.min.js"></script>
<script type="text/javascript">
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
	var orderno = Request['orderno']; 
	
window.location.href="http://localhost:8080/GRCRM_2015/orderplace.jsp";
}

function checkInfo(str1,str2,str3) {
	 var re = /^1\d{10}$/
    if(str1==""){
        alert("请您填写数量！");
        return false; 
    }else if(str2==""){
        alert("请您填写姓名！");
        return false; 
    }else if(str3==""){
        alert("请您填写手机号码！");
        return false; 
    }else if (!re.test(str3)) {
        alert("您填写的手机号格式错误！");
        return false; 
    }
    else{
        return true; 
    }
}
//////////////////////
$(function(){
	$("#quantity").keyup(function(){
		if(isNaN($(this).val()) || parseInt($(this).val())<1){
			$(this).val("1");
			$("#totalPrice").html($("#price").val());
			return;
		}
		var total = parseFloat($("#price").val())*parseInt($(this).val());
		$("#totalPrice").html(total.toFixed(2));
	})
	
})

/*商品数量+1*/
function numAdd(){
	var num_add = parseInt($("#quantity").val())+1;
	if($("#quantity").val()==""){
		num_add = 1;
	}
	$("#quantity").val(num_add);
	var total = parseFloat($("#price").val())*parseInt($("#quantity").val());
	$("#totalPrice").html(total.toFixed(2));
}

/*商品数量-1*/
function numDec(){
	var num_dec = parseInt($("#quantity").val())-1;
	if($("#quantity").val()==""){
		alert("数量为空值，不能减少啦");
		return false;
	}
	if(num_dec<1){
		//购买数量必须大于或等于1
		alert("数量不能小于1");
	}else{
		$("#quantity").val(num_dec);
		var total = parseFloat($("#price").val())*parseInt($("#quantity").val());
		$("#totalPrice").html(total.toFixed(2));
	}
}  
//////////////////////////////////////
</script>
</head>
<body>
<form class="order_form" action="orderAdd" method="post" align="left">
<ul>
    <li>
         <span class="required_notification">* 表示必填项</span>
    </li>
    <li>
        <label for="name"><%=pord.getProductname()%></label>
    </li>
    <li>
        <label for="name">价格:￥<%=pord.getPrice()%></label>
    </li>
    <li>
        <label for="name">请填写正确的信息，输入错误将延误购卡</label>
    </li>
   	  
	 <li>
    <label for="website">卡的种类: <%=pord.getSimcardtype()%></label>    
     <input type="text" name="cardtype" value=<%=pord.getProductcode()%> style="display:none;"/>
	</li>
	<li>
		<p class="vertical">*购买数量: <input type="image" id="add" src="./images/minus.jpg" height="20" width="20" onclick="numDec(); return false;"/><!-- <input type="button" class="input_button" id="add" value=" - " onclick="numDec()" />  -->
        <input class="input_txt" name="quantity" type="text" id="quantity" /> 
        <input type="image" id="add" src="./images/plus.jpg" height="20" width="20" onclick="numAdd();return false;"/><!-- <input type="button"  class="input_button" id="minus" value=" + " onclick="numAdd()" /> --></p>
		<input type="hidden" value="28.1" id="price" />
	</li>
	 <li>
        <label for="name">*姓名: </label>
        <input type="text" name="name" class="input_txt2" id ="name">        
    </li>
    <li>
    <label for="email">*手机号码: </label>  
    <input type="text" name="telno" class="input_txt2" id ="telno"> 
    </li>
	<li>
	 <label for="address">*收货地址: </label>  
    <input type="text" name="ads" class="input_txt2" id ="ads"> 
	</li>	
	<li>
	 <label align="center" for="website">使用微信公众号支付:</label>
    </li>		
	<li>
	   <input class="submitButton" type="submit" id="submitButton" value="下单结算" onclick="return checkInfo(quantity.value, name.value, telno.value);"/>
	</li>
</ul>
</form>
</body>
</html>