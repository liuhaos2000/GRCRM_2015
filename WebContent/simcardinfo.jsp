<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
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
    <header class="head-top" role="navigation">
        <div class="container">
            <div class="row head-row">
                <div class="col-md-2 col-sm-2 col-xs-2 col-head">
                    <a class="head-back" href="javascript:history.back();"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span></a>
                </div>
                <div class="col-md-8 col-sm-8 col-xs-8 col-head">
                    <p class="head-row-text">请选择SIM卡</p>
                </div>
                <div class="col-md-2 col-sm-2 col-xs-2 col-head">
                    <a class="head-back" href="/GRCRM_2015"><span class="glyphicon glyphicon-home" aria-hidden="true"></span></a>
                </div>
            </div>
        </div>
    </header>
    
	   <div id="main-div">
	       <form class="order_form" action="" method="post" align="center">
	      <div class="container ">
            <div class="row cardinfo-row">
            <a href="http://localhost:8080/GRCRM_2015/cardlist.jsp?cardsize=1">
                <div class="col-md-6 col-sm-6 col-xs-6 cardinfo-col-left">
                    <img src="./images/pd_sim_img_01.jpg" alt="普通卡 (25mm×15mm)">
                </div>
                <div class="col-md-6 col-sm-6 col-xs-6 cardinfo-col-right">普通卡<br>(25mm×15mm)
                </div>
                </a>
            </div>
            <div class="row cardinfo-row">
                <a href="http://localhost:8080/GRCRM_2015/cardlist.jsp?cardsize=2">
                <div class="col-md-6 col-sm-6 col-xs-6 cardinfo-col-left">
                    <img src="./images/pd_sim_img_02.jpg" alt="Micro (15mm×12mm)">
                </div>
                <div class="col-md-6 col-sm-6 col-xs-6 cardinfo-col-right">
                    Micro<br> (15mm×12mm)
                </div>
                </a>
            </div>
            <div class="row cardinfo-row">
            <a href="http://localhost:8080/GRCRM_2015/cardlist.jsp?cardsize=3">
                <div class="col-md-6 col-sm-6 col-xs-6 cardinfo-col-left">
                    <img src="./images/pd_sim_img_03.jpg" alt="Nano (12.3mm×8.8mm)">
                </div>
                <div class="col-md-6 col-sm-6 col-xs-6 cardinfo-col-right">
                    Nano<br> (12.3mm×8.8mm)
                </div>
                </div>
            </a>
        </div>
       </form>
      </div>

	
	
<script src="<%=request.getContextPath()%>/resources/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $(function(){
        $("#main-div").height($(window).height()-$("header").height());
        $("#main-div").css({"overflow":"auto"});
    });
});
</script>
</body>
</html>