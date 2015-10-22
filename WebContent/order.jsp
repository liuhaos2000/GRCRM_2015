<%@ page contentType="text/html;charset=UTF-8" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<%@ page import="java.util.List" %>
<%@ page import="demo.javabean.MakeAppointment" %>
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
MakeAppointment mapp = null;
%>
<!DOCTYPE html>
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
<%
List ddwhoneList = new ArrayList();
Connection conn = null;
String url = "jdbc:mysql://localhost:3306/weixin?"
		+ "user=root&password=grids&useUnicode=true&characterEncoding=UTF8";
Statement stmt = null;
ResultSet rs = null;
String sql = "";
String orderid = (String)request.getParameter("orderno");
try{
  Class.forName("com.mysql.jdbc.Driver");// 动态加载mysql驱动
  conn = (Connection) DriverManager.getConnection(url);
  
  // �f�[�^�x�[�X�ɑ΂��鏈��
  stmt = (Statement) conn.createStatement();
  sql = "SELECT u.address as address,p.smallclassification as cardtype,p.productname as productname,p.productcode as productcode,p.unitprice as unitprice,o.orderid as orderid,u.username as username,u.telno as telno, o.quantity as amount FROM weixin.productmaster p,weixin.userinfo u,weixin.orderinfo o where p.productcode = o.productid and o.userid = u.userid and o.orderid=" + orderid;
  rs = stmt.executeQuery(sql);
  while (rs.next()) {
	  MakeAppointment makeapp = new MakeAppointment();
	  makeapp.setUsername(rs.getString("username"));
	  makeapp.setTelno(rs.getString("telno"));
	  makeapp.setAmount(rs.getString("amount"));
	  makeapp.setOrderid(rs.getString("orderid"));
	  makeapp.setProductname(rs.getString("productname"));
	  makeapp.setUnitprice(rs.getString("unitprice"));
	  makeapp.setProductcode(rs.getString("productcode"));
	  makeapp.setCardtype(rs.getString("cardtype"));
	  makeapp.setAddress(rs.getString("address"));
      ddwhoneList.add(makeapp);
  }
}catch (SQLException e){
	e.printStackTrace();
}catch (Exception e) {
    e.printStackTrace();
} finally {
	conn.close();
}

mapp = (MakeAppointment)ddwhoneList.get(0);
%>

    <header class="head-top" role="navigation">
        <div class="container">
            <div class="row head-row">
                <div class="col-md-2 col-sm-2 col-xs-2 col-head">
                    <a class="head-back" href="javascript:history.back();"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span></a>
                </div>
                <div class="col-md-8 col-sm-8 col-xs-8 col-head">
                    <p class="head-row-text">我的订单</p>
                </div>
                <div class="col-md-2 col-sm-2 col-xs-2 col-head">
                    <a class="head-back" href="/GRCRM_2015"><span class="glyphicon glyphicon-home" aria-hidden="true"></span></a>
                </div>
            </div>
        </div>
    </header>




<form class="order_form" action="orderUpdate" method="post" name="order_form" align="left">

	    <div id="main-div">
	        <div class="container ">
	        	<div class="alert alert-info row-top-m" role="alert">
	        	<div class="row ">
            		<div class="col-md-4 col-sm-4 col-xs-4 buycardname2">
            			<label for="name"><%=mapp.getProductname()%></label>
            		</div>
            	</div>
            	<div class="row ">
            		<div class="col-md-4 col-sm-4 col-xs-4 ">
            			<p class="label-text">价格:</p>
            		</div>
            		<div class="col-md-8 col-sm-8 col-xs-8 ">
            			<label class="label-text" for="unitprice"> <span class="red-text">￥<%=mapp.getUnitprice()%></span></label>
            		</div>
            	</div>
            	<div class="row ">
            		<div class="col-md-4 col-sm-4 col-xs-4 ">
            			<p class="label-text">卡的种类:</p>
            		</div>
            		<div class="col-md-8 col-sm-8 col-xs-8 ">
            			<label class="label-text" for="unitprice"><%=mapp.getCardtype()%></label>
            		</div>
            	</div>
            	</div>
	        	<div class="row ">
            		<div class="col-md-12 col-sm-12 col-xs-12 ">
            			<div class="alert alert-success" role="alert">请填写正确的信息，输入错误将延误购卡</div>
            		</div>
            	</div>
            	<div class="alert alert-info" role="alert">
            	<div class="row ">
            		<div class="col-md-4 col-sm-4 col-xs-4 label-text">
            			<p class="vertical">订单号:</p>
            		</div>
            		<div class="col-md-8 col-sm-8 col-xs-8 ">
            			<label  class="label-text"><%=mapp.getOrderid()%> </label>
            			<input type="text" name="orderid" value=<%=mapp.getOrderid()%> style="display:none;"/>
            		</div>
            	</div>
	        	<div class="row ">
            		<div class="col-md-4 col-sm-4 col-xs-4 label-text">
            			<p class="vertical"><span class="red-text">*</span>购买数量:</p>
            		</div>
            		<div class="col-md-8 col-sm-8 col-xs-8 ">
            			 <input type="image" id="add" src="./images/minus.jpg" height="20" width="20" onclick="numDec();return false;" /> 
     					 <input class="input_txt" id="quantity" name="quantity"  size="3" type="text" value=<%=mapp.getAmount()%> /> 
     					 <input type="image"  id="minus" src="./images/plus.jpg" height="20" width="20" onclick="numAdd();return false;" /></p>
						 <input type="hidden" value="28.1" id="price" />
            		</div>
            	</div>
            	<div class="row ">
            		<div class="col-md-4 col-sm-4 col-xs-4 label-text">
            			<p class="vertical"><span class="red-text">*</span>姓&nbsp;&nbsp;名:</p>
            		</div>
            		<div class="col-md-8 col-sm-8 col-xs-8 ">
            			 <input type="text" name="name1" class="input_txt2" value=<%=mapp.getUsername()%>>
            		</div>
            	</div>
            	<div class="row ">
            		<div class="col-md-4 col-sm-4 col-xs-4 label-text">
            			<p class="vertical"><span class="red-text">*</span>手机号码:</p>
            		</div>
            		<div class="col-md-8 col-sm-8 col-xs-8 ">
            			<input type="text" name="telno" class="input_txt2" value=<%=mapp.getTelno()%>>
            		</div>
            	</div>
            	<div class="row ">
            		<div class="col-md-4 col-sm-4 col-xs-4 label-text">
            			<p class="vertical"><span class="red-text">*</span>收货地址:</p>
            		</div>
            		<div class="col-md-8 col-sm-8 col-xs-8 ">
            			<input type="text" name="ads" class="input_txt2" value=<%=mapp.getAddress()%>>
            		</div>
            	</div>
            	</div>
            	
            	
	        </div>
	    </div>


    <footer class="tool_foot">
        <div class="container footer itme_detail_top">
            <div class="row footer-row">
            	<div class="col-md-6 col-sm-6 col-xs-6 footer-col ">
            	<label align="center" for="website" class="foot-text">微信公众号支付:</label>
            	</div>
                <div class="col-md-6 col-sm-16 col-xs-6 footer-col">
                	<input class="submitButton  btn btn-success a-btn" type="submit" id="submitButton" value="下单结算" onclick="return checkInfo(quantity.value, name1.value, telno.value);"/>
                </div>
            </div>
        </div>
    </footer>
</form>




<script type="text/javascript" src="http://www.daixiaorui.com/Public/js/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $(function(){
        $("#main-div").height($(window).height()-$("header").height()-52);
        $("#main-div").css({"overflow":"auto"});
    });
});

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
	
window.location.href="http://localhost:8080/GRCRM_2015/orderplace.jsp?orderno=" + orderno;
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
</body>
</html>