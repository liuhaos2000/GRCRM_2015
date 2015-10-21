<%@ page contentType="text/html;charset=UTF-8" %> 
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
<html>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<head>
    <meta charset="utf-8">
    <title>支付宝支付</title>
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
<script language="javascript">
</script>
</head>
<body>

<form class="order_form" action="" method="post" name="order_form" align="center">
<ul>
    <li>
         <h2>标准支付功能页面</h2>
         <span class="required_notification">* 表示必填项</span>
    </li>
    <li>
        <label for="name">*卡号:</label>
        <input type="text" name="name">
    </li>
    <li>
    <label for="email">*密码:</label>
    <input type="text" name="telno">
    </li>
	<li>
	    <button class="submit" type="button" >支付</button>
	</li>
</ul>
</form>
</body>
</html>