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
	<div id="main-div">
		<div class="container ">

	
	
	
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
			  
			  // 
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
					
					
						out.print("<div class='row cardinfo-row'>");
						out.print("<a href=http://localhost:8080/GRCRM_2015/buycard.jsp?productcode="
								+ news.getProductcode() + ">");

						out.print("<div class='col-md-6 col-sm-6 col-xs-6 cardinfo-col-left'>");
						out.print("<img src=" + news.getImage() + ">");
						out.print("</div>");
						out.print("<div class='col-md-6 col-sm-6 col-xs-6 cardinfo-col-right2'>￥" + news.getPrice()
								+ "<br>使用期限： " + news.getDeadline());
						out.print("</div>");

						out.print("</a>");
						out.print("</div>");

					}
				}
			%>
        </div>
	</div>
</body>
</html>