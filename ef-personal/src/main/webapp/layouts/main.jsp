<!DocType html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../scripts/assets/css/amazeui.min.css">
    <link rel="stylesheet" type="text/css" href="../scripts/assets/css/app.css">
    <link rel="stylesheet" type="text/css" href="../scripts/assets/css/style.css">
    <link href="../scripts/assets/css/jquery.jslides.css" rel="stylesheet" type="text/css" />
    <script src="../scripts/assets/js/jquery.min.js"></script>
    <script src="../scripts/assets/js/jquery.jslides.js"></script>
    <script src="../scripts/assets/js/amazeui.min.js"></script>
    <script src="../scripts/assets/js/demo.js"></script>
    <script src="../scripts/assets/js/jquery.js"></script>
    <sitemesh:write property='head'/>
</head>
<body>
<div id="header">
    <h1><img src="<c:url value="/scripts/assets/images/logo1.gif"/>" alt="vlogo" class="logov"></h1>
    <div class="printing">${tenant.title}<span>  [<a href="#">木板水印</a>]</span></div>
    <ul class="register">
        <li class="register-page"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz1.gif"/>"></a></li>
       <%-- <li class="register-left"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz2.gif"/>"></a></li>
        <li class="register-right"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz3.gif"/>"></a></li>--%>
    </ul>
</div>
<div id="nav">
    <h1><a href="#"><img src="http://tenant.efeiyi.com/photo/2015-07-20%2014%3A41%3A29.jpg@!tenant-manage-banner"></a></h1>
    <ul class="nav-centent">
        <li><a href="${pageContext.request.contextPath}/tenant/${tenant.id}">首页</a></li>
        <li><a href="${pageContext.request.contextPath}/introduction/${tenant.id}">简介</a></li>
        <li><a href="${pageContext.request.contextPath}/work/listTenantWork.do?conditions=tenant.id:${tenant.id}">作品</a></li>
        <li><a href="${pageContext.request.contextPath}/info/listTenantInfo.do?conditions=tenant.id:${tenant.id}">资讯</a></li>
        <li><a href="${pageContext.request.contextPath}/workShop/${tenant.id}">工作坊</a></li>
    </ul>
</div>
<sitemesh:write property='body'/>
<br />
<br />
<div id="footer">
    <ul class="guild">
        <li><a href="#"><img src="<c:url value="/scripts/assets/images/i/fybk.jpg"/> "></a></li>
        <li><a href="#"><img src="<c:url value="/scripts/assets/images/i/efeiyi.jpg"/> "></a></li>
        <li><a href="#"><img src="<c:url value="/scripts/assets/images/i/cpb.jpg"/> "></a></li>
        <li><a href="#"><img src="<c:url value="/scripts/assets/images/i/gl.jpg"/> "></a></li>
    </ul>
    <div class="efeiyi-url">©2015 efeiyi.com</div>

</div>
<!--分析-->
<div class="floating_ck">
    <dl>
        <dt></dt>
        <dd class="return">
            <span onClick="gotoTop();return false;"></span>
        </dd>
        <dd class="qrcord">
            <span ></span>
            <div class="floating_left floating_ewm floating_left-1">
                <i><img src="<c:url value="/scripts/assets/images/images/img6_03.jpg" />"></i>
            </div>
        </dd>
        <dd class="quote">
            <span>分享</span>
            <div class="floating_left">
                <a href="#" class="float-a"><img src="<c:url value="/scripts/assets/images/i/wx.gif" />"></a>
                <a href="#" class="float-a"><img src="<c:url value="/scripts/assets/images/i/wqq.gif" />"></a>
                <a href="#" class="float-a"><img src="<c:url value="/scripts/assets/images/i/kj.gif" />"></a>
                <a href="#" class="float-a"><img src="<c:url value="/scripts/assets/images/i/xl.gif" />"></a>
                <a href="#" class="float-a"><img src="<c:url value="/scripts/assets/images/i/qq.gif" />"></a>
            </div>
        </dd>
    </dl>
</div>
</body>
</html>
