<%@ page import="com.efeiyi.ec.xw.organization.model.MyUser" %>
<%@ page import="com.efeiyi.ec.xwork.organization.util.AuthorizationUtil" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/24
  Time: 17:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>--%>
<%String path = request.getContextPath();%>
<html class="no-js">
<head>
    <title>首页</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Amaze UI Admin index Examples</title>
    <meta name="description" content="这是一个 index 页面">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <link rel="icon" type="image/png" href="<c:url value='/resources/assets/i/favicon.png'/>"/>
    <link rel="apple-touch-icon-precomposed" href="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>"/>
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="<c:url value='/resources/assets/css/amazeui.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='/resources/assets/css/admin.css'/>"/>
    <script src="<c:url value='/resources/jquery/jquery-1.11.1.min.js'/>"></script>
    <script src="<c:url value='/resources/assets/js/amazeui.min.js'/>"></script>
    <script src="<c:url value='/resources/js/alert.js'/>"></script>
    <script src="<c:url value="/scripts/react0.14.3/react.js"/> "></script>
    <script src="<c:url value="/scripts/react0.14.3/react-dom.js"/> "></script>
    <script src="<c:url value="/scripts/react0.14.3/react-dom-server.js"/> "></script>
    <script src="<c:url value="/scripts/react0.14.3/browser.min.js"/>"></script>
    <script src="<c:url value="/scripts/sockjs-0.3.min.js"/>"></script>
    <sitemesh:write property='head'/>
    <style>

        .efy-active {
            background-color: #9a9a9a;
        }
    </style>
</head>
<body>
<script type="text/javascript" src="<c:url value="/scripts/websocket.js" />"></script>
<script>

    function reload_my_problem(task) {
        var path_url = window.location.href;
        if (path_url.indexOf("plistTaskActivityInstanceExecution_default") > -1) {
            var box = $("#box");
            box.empty();
            $.ajax({
                type: "get",//设置get请求方式
                url: "<c:url value='/findTaskActivityInstanceExecution.do'/>",//设置请求的脚本地址
                data: "",//设置请求的数据
                async: true,
                dataType: "json",//设置请求返回的数据格式
                success: function (data) {
                    if (data && data.length > 0) {
                        var sub = "";
                        for (var i in data) {
                            if (data[i].status == 0) {
                                var time = format(data[i].createDatetime, 'yyyy-MM-dd HH:mm:ss');
                                sub += "<article class=\"am-comment\">" +
                                        "   <a href=\"javascript:void (0);\" onclick=\"changeInput(this , \'\');\">编辑</a>" +
                                        "   <a href=\"javascript:void (0);\" onclick=\"forwardUrl(this,'" + data[i].taskContent + "','" + data[i].taskId + "');\">标记</a>" +
                                        "   <a href=\"<c:url value='/basic/xm.do?qm=formTask&id='/>" + data[i].taskId + "\" class=\"am-comment-author\">" + data[i].taskTitle + "</a>" +
                                        "   <p style=\"display: inline\">" + time + "</p>" +
                                        "</article>";
                            }
                        }
                        box.append(sub);
                        $("#manager-number").html(data.length);
                    }
                }
            })
        } else {
            alert(task);
        }
    }

</script>
<jsp:include flush="true"
             page="/getMenu.do?jmenuId=commonMenu&resultPage=/jmenu/manageTemplateHeader&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>

<div class="am-cf admin-main">

    <jsp:include flush="true"
                 page="/getMenu.do?jmenuId=commonMenu&resultPage=/jmenu/manageTemplateLeft&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>
    <div class="admin-content" style="height: auto;">
        <sitemesh:write property='body'/>
    </div>

</div>

</body>

</html>
