<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <div class="am-u-sm-9">
            <label class="am-text-primary am-text-lg">筛选动态 :</label>
            <select onchange="changeContent(this);">
                <option value="0" aria-checked="true">所有成员</option>
                <c:forEach items="${users}" var="user">
                    <option value="${user.id}">${user.name}</option>
                </c:forEach>
            </select>
        </div>
    </div>
</div>

<div class="am-form-group" id="box">
    <c:forEach items="${requestScope.pageInfo.list}" var="dynamic">
        <article class="am-comment">
            <a href="">
                <img class="am-comment-avatar" alt=""/>
            </a>
            <%--<div class="am-comment-main">--%>
                <%--<div class="am-comment-bd"><fmt:formatDate  value="${dynamic.createDatetime}" type="both" pattern="MM/dd HH:mm:ss" />&nbsp;&nbsp;&nbsp;--%>
                    <%--<a href="#link-to-user" class="am-comment-author">${dynamic.creator.name}</a>${dynamic.message}--%>
                <%--</div>--%>
            <%--</div>--%>
        </article>
    </c:forEach>
</div>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
<script>
    function changeContent(o){
        var userId = $(o).val();
        $.ajax({
            type: "get",//设置get请求方式
            url: "<c:url value='/taskDynamic/'/>"+userId,//设置请求的脚本地址
            data: "",//设置请求的数据
            async: true,
            dataType: "json",//设置请求返回的数据格式
            success: function (data) {
                var box = $("#box");
                box.empty();
                var sub = "";
                if(data && data.length > 0){
                    for(var i in data){
                        var ctime = clockon(data[i].createDatetime);
                        sub += "<article class=\"am-comment\">"+
                                "     <a href=\"\">"+
                                "         <img class=\"am-comment-avatar\" alt=\"\"/>"+
                                "     </a>"+
                                "     <div class=\"am-comment-main\">"+
                                "        <div class=\"am-comment-bd\">"+ctime+"&nbsp;&nbsp;&nbsp;"+
                                "            <a href=\"<c:url var='/basic/xm.do?qm=formTaskDynamic&id='/>"+data[i].id+"\" class=\"am-comment-author\">"+data[i].creator.name+"</a>"+data[i].message +
                                "        </div>"+
                                "     </div>"+
                                "</article>";
                    }
                    box.append(sub);
                }
            }
        })
    }
    function clockon(createDateTime) {
        var now = new Date(createDateTime);
//        var ctime = new Date(createDateTime);
//        var year = now.getFullYear(); //getFullYear getYear
        var month = now.getMonth();
        var date = now.getDate();
//        var datetime = ctime.getDate();
        var day = now.getDay();
        var hour = now.getHours();
        var minu = now.getMinutes();
        var sec = now.getSeconds();//获取参数时间的秒数
//        var week;
        month = month + 1;
        if (month < 10) month = "0" + month;
        if (date < 10) date = "0" + date;
        if (hour < 10) hour = "0" + hour;
        if (minu < 10) minu = "0" + minu;
        if (sec < 10) sec = "0" + sec;
//        var arr_week = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六");
//        week = arr_week[day];
        return month + "/" + date + " " + hour + ":" + minu + ":" + sec;
    }
</script>
</body>
</html>
