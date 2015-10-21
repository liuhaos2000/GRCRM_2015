<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %> 
<html>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<head>
    <meta charset="utf-8">
    <title>在线查询</title>
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
.form_hint, .required_notification {font-size: 32px;}

.order_form ul {
    width:100%;
    list-style-type:none;
    list-style-position:outside;
    margin:0px;
    padding:0px;
}
.order_form li{
    padding:12px;
   /*  border-bottom:1px solid #eee; */
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
<script  type="text/javascript">
function checkMobile(str) {
    if(str==""){
        alert("请您填写手机号！");
        return false; 
    }
    else{
        var re = /^1\d{10}$/
        if (!re.test(str)) {
            alert("您填写的手机号格式错误！");
            return false; 
        }
    }
    
    return true; 
}
</script>
</head>
<body>
<form class="order_form" action="orderSearch" method="post" align="left" id="telnoform">
<ul>
    <li>
         <h2>查询</h2>
         <span class="required_notification">* 表示必填项</span>
    </li>
    <li>
    <label for="email">*手机号码:</label>
    <input type="text" name="telno" id="btn_getNum"/>
    </li>
    
     <li>
    <label for="email">＊例：13420718888</label>
    </li>

	<li>
	    <input class="submitButton" type="submit" value="提交" onclick="return checkMobile(btn_getNum.value);"/>
	</li>
</ul>
</form>
</body>
</html>