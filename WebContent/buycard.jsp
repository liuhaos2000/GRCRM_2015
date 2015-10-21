<%@ page contentType="text/html;charset=UTF-8" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
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
    <header class="head-top" role="navigation">
        <div class="container">
            <div class="row head-row">
                <div class="col-md-2 col-sm-2 col-xs-2 col-head">
                    <a class="head-back" href="javascript:history.back();"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span></a>
                </div>
                <div class="col-md-8 col-sm-8 col-xs-8 col-head">
                    <p class="head-row-text">购买SimCard</p>
                </div>
                <div class="col-md-2 col-sm-2 col-xs-2 col-head">
                    <a class="head-back" href="/GRCRM_2015"><span class="glyphicon glyphicon-home" aria-hidden="true"></span></a>
                </div>
            </div>
        </div>
    </header>
    
    
<form class="order_form" action="" method="post" name="order_form" align="left">
	    <div id="main-div">
	        <div class="container ">
            	<div class="row">
            		        <%
       							out.print("<img class='buycard-img' src=" + pord.getImage() + ">");
       						 %>
            	</div>
            	<div class="alert alert-info row-top-m" role="alert">
            	<div class="row ">
            		<div class="col-md-4 col-sm-4 col-xs-4 ">
            			<label for="name"><%=pord.getProductname()%></label>
            		</div>
            	</div>
            	<div class="row">
            		<div class="col-md-4 col-sm-4 col-xs-4 ">
            			<p class="label-text">原价:</p>
            		</div>
            		<div class="col-md-8 col-sm-8 col-xs-8 ">
            			<label class="label-text" for="unitprice"> <span class="red-text"><%=pord.getPrice()%></span></label>
            		</div>
            	</div>
            	<div class="row">
            		<div class="col-md-4 col-sm-4 col-xs-4 ">
            			<p class="label-text">优惠价: </p>
            		</div>
            		<div class="col-md-8 col-sm-8 col-xs-8 ">
            			<label class="label-text" for="unitprice"> <span class="red-text"><%=pord.getPrice()%></span></label>
            		</div>
            	</div>
            	<div class="row ">
            		<div class="col-md-4 col-sm-4 col-xs-4 ">
            			<p class="label-text">特点: </p>
            		</div>
            		<div class="col-md-8 col-sm-8 col-xs-8 long-text">
            			<label class="label-text" for="num1"><%=pord.getImage2()%></label>
            		</div>
            	</div>
            	</div>
            	    	<div class="alert alert-info row-top-m" role="alert">
            	         <label for="toal">使用说明:</label>
            	    	 <label for="num1">服务可在NTT DOCOMO的“Xi (crossy) 4G LTE”和“FOMA 3G”服务区内使用，通过两者均可在全日本建立可靠的连接</label>
            			 <label for="toal">温馨提示:</label>
            			 <label for="num1">150Mbps是理论最高速度；实际速度有所不同，也没有保证,每天的高速数据配额用尽后，当日最大下载和上传速度将会降至200kbps。</label>
            			</div>
            	
            </div>
	    </div>
	    
    <footer class="tool_foot">
        <div class="container footer itme_detail_top">
            <div class="row footer-row">
                <div class="col-md-12 col-sm-12 col-xs-12 footer-col">
                    <button id="submitButton" class="btn btn-success a-btn" type="button" onclick="jump()">购买</button>
                </div>
            </div>
        </div>
    </footer>
</form>

<script src="<%=request.getContextPath()%>/resources/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
<script language="javascript">
$(document).ready(function() {
    //
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
	var productcode = Request['productcode']; 
	window.location.href="http://localhost:8080/GRCRM_2015/orderadd.jsp?productcode=" + productcode;
}
</script>
</body>
</html>