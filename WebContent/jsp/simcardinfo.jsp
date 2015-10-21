<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %> 
<html>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<head>
    <meta charset="utf-8">
    <title>Prepaid SIM for JAPAN</title>
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
    padding:12px;
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
    width:100%;
    margin-top: 3px;
    display:inline-block;
    float:left;
    padding:3px;
}
.order_form input {
    height:20px;
    width:50%;
    padding:5px 8px;
}
.order_form button {margin-left:156px;}

</style>
<script  language="javascript"></script>
  <link rel="stylesheet" href="Touch/resources/css/sencha-touch.css" 
    type="text/css"> 
    <link rel="stylesheet" href="css/index.css" type="text/css"> 
    <script type="text/javascript" src="Touch/sencha-touch-debug.js"></script> 
    <script type="text/javascript" src="js/index.js"></script> 
</head>
<body>
<form class="order_form" action="" method="post" align="center">
<ul>
    <li>
         <h2>请选择SIM卡大小</h2>
    </li>
    <li>
		<img src="./images/pd_sim_img_01.jpg" alt="普通卡 (25mm×15mm)"><br>
		<p class="caption"><a href="http://localhost:8080/GRCRM_2015/cardlist.jsp?cardsize=1">普通卡</a><br>(25mm×15mm)</p>
	</li>
	<li>
		<img src="./images/pd_sim_img_02.jpg" alt="Micro (15mm×12mm)"><br>
		<p class="caption"><a href="http://localhost:8080/GRCRM_2015/cardlist.jsp?cardsize=2">Micro</a><br>(15mm×12mm)</p>
	</li>
	<li>
		<img src="./images/pd_sim_img_03.jpg" alt="Nano (12.3mm×8.8mm)"><br>
		<p class="caption"><a href="http://localhost:8080/GRCRM_2015/cardlist.jsp?cardsize=3">Nano</a><br>(12.3mm×8.8mm)</p>
	</li>
</ul>
</form>
</body>
</html>