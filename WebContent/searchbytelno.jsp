<%@ page contentType="text/html;charset=UTF-8" %> 
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

</head>
<body>
    <header class="head-top" role="navigation">
        <div class="container">
            <div class="row head-row">
                <div class="col-md-2 col-sm-2 col-xs-2 col-head">
                    <a class="head-back" href="javascript:history.back();"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span></a>
                </div>
                <div class="col-md-8 col-sm-8 col-xs-8 col-head">
                    <p class="head-row-text">在线查询</p>
                </div>
                <div class="col-md-2 col-sm-2 col-xs-2 col-head">
                    <a class="head-back" href="/GRCRM_2015"><span class="glyphicon glyphicon-home" aria-hidden="true"></span></a>
                </div>
            </div>
        </div>
    </header>

<form class="order_form" action="orderSearch" method="post" align="left" id="telnoform">

	 <div id="main-div">
	        <div class="container ">
	        	<div class="alert alert-info row-top-m" role="alert">
	        	<div class="row ">
            		<div class="col-md-5 col-sm-5 col-xs-5 buycardname2">
            			<label for="name">*手机号码:</label>
            		</div>
            		<div class="col-md-7 col-sm-7 col-xs-7 buycardname2">
            			<input type="text" name="telno" id="btn_getNum" size="15"/>
            		</div>
            	</div>
            	<div class="row">
            		<div class="col-md-12 col-sm-12 col-xs-12 ">
            			<p class="lie-text">＊例：13420718888</p>
            		</div>
            	</div>
            	</div>
            </div>
     </div>	



    <footer class="tool_foot">
        <div class="container footer itme_detail_top">
            <div class="row footer-row">
            	<div class="col-md-12 col-sm-12 col-xs-12 footer-col ">
            	    <input class="submitButton btn-success a-btn" type="submit" value="提交" onclick="return checkMobile(btn_getNum.value);"/>
            	</div>
            </div>
        </div>
    </footer>
</form>

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
</body>
</html>