<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/07
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<html>
<head>
    <title>流程实例列表</title>
    <%--<script src="<c:url value='/scripts/react0.14.3/react.js'/>"></script>--%>
    <%--<script src="<c:url value='/scripts/react0.14.3/react-dom.js'/>"></script>--%>
    <%--<script src="<c:url value='/scripts/react0.14.3/browser.min.js'/>"></script>--%>
    <script src="http://cdn.sockjs.org/sockjs-0.3.min.js"></script>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <label class="am-text-primary am-text-lg">我的问题 :</label>
        <select onchange="changeData(this);">
            <option value="0" aria-checked="true">所有项目</option>
            <c:forEach items="${list}" var="project">
                <option value="${project.id}">${project.title}</option>
            </c:forEach>
        </select>
    </div>
</div>
<div class="am-form-group" id="box">
    <c:forEach items="${requestScope.pageInfo.list}" var="taskActivityInstanceExecution">
        <c:if test="${taskActivityInstanceExecution.status == 0}">
            <article class="am-comment" id="${taskActivityInstanceExecution.task.id}">
                <a href="javascript:void (0);"
                   onclick="changeInput(this ,'${taskActivityInstanceExecution.task.id}','${taskActivityInstanceExecution.id}');">编辑</a>
                <a href="javascript:void (0);"
                   onclick="forwardUrl(this,'${myUser.name}','${myUser.username}','${taskActivityInstanceExecution.task.id}');">标记</a>
                <a href="<c:url value='/basic/xm.do?qm=formTask&id=${taskActivityInstanceExecution.task.id}'/>"
                   class="am-comment-author">${taskActivityInstanceExecution.task.title}</a>
                <p style="display: inline">${taskActivityInstanceExecution.createDatetime}</p>
            </article>
        </c:if>
    </c:forEach>
</div>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
<script type="text/javascript">
//    var ws = null;
//    var url = null;
    var transports = [];
//    function disconnect() {
//        if (ws != null) {
//            ws.close();
//            ws = null;
//        }
//    }
    function updateUrl(urlPath) {
        console.log("配置路径")
        if (urlPath.indexOf('sockjs') != -1) {
            url = urlPath;
        }
        else {
            if (window.location.protocol == 'http:') {
                url = 'ws://' + window.location.host + urlPath;
            } else {
                url = 'wss://' + window.location.host + urlPath;
            }
        }
    }
    function forwardUrl(o,name, username, taskId) {
//        updateUrl('/websocket');
//        connect();
        $.ajax({
            type: "get",//设置get请求方式
            url: "<c:url value='/task/changeTaskStatus?taskId='/>" + taskId,//设置请求的脚本地址
            data: "",//设置请求的数据
            async: true,
            dataType: "json",//设置请求返回的数据格式
            success: function (data) {
                if (data && data.length > 0) {
                    var text_str = "[";
                    if (data.length > 1) {
                        for (var i in data) {
//                            if(username == data[i].username){
//                                text_str += data[i].username;
//                            }
                            text_str += data[i].username + ",";
                        }
                        text_str = text_str.substr(0, text_str.length - 1);
                    } else {
                        text_str += "" + data[0].username;
                    }
                    text_str += "]";
                    console.log(text_str);
//                    var a_html = "{'type':'1','receiver':'" + text_str + "','content':'" + userName + "完成了任务" + ($(o).next().html()) + "','taskId':'" + taskId + "'}";
                    var a_html = '{"type":"1","receiver":"'+text_str+'","content":"'+name+'完成了任务'+$(o).next().html()+'","taskId":"'+taskId+'","path":"problem","qm":"plistTaskActivityInstanceExecution_default"}';
                    echo(a_html);

                }
            }
        })
    }
    function echo(message) {
        if (ws != null) {
            ws.send(message);
        } else {
            alert('connection not established, please connect.');
        }
    }
    function changeData(o) {
        var checkVal = $(o).val();
        $.ajax({
            type: "get",//设置get请求方式
            url: "<c:url value='/taskActivityInstanceExecution/'/>" + checkVal,//设置请求的脚本地址
            data: "",//设置请求的数据
            async: true,
            dataType: "json",//设置请求返回的数据格式
            success: function (data) {
                var box = $("#box");
                box.empty();
                var sub = "";
                if (data && data.length > 0) {
                    for (var i in data) {
                        sub += "<article class=\"am-comment\">" +
                                "        <a onclick=\"changeInput(this,'" + data[i].taskId + "')\">编辑</a>" +
                                "        <a onclick=\"\">标记</a>" +
                                "        <a href=\"<c:url value='/basic/xm.do?qm=formTask&id='/>" + data[i].taskId + "\" class=\"am-comment-author\">" + data[i].taskContent + " </a>" +
                                "</article>";
                    }
                    box.append(sub);
                }
            }
        })
    }
    function changeInput(o,taskId,childId){
        var next_html = $(o).next().next().html();
        var parent_html = $("#"+taskId);
        parent_html.empty();
        var sub_html = "<input type='text' style=\"width: 30%;display: inline;\" class=\"am-form-field am-round\" value='"+next_html+"'/>" +
                "<input type='button' onclick=\"changeTaskTitle(this,'"+taskId+"','"+next_html+"','"+childId+"');\" style='display: inline;' class='am-btn am-btn-default am-round' value='保存'/>" +
                "<input type='button' style='display: inline;' class='am-btn am-btn-default am-round' value='取消'/>";
        parent_html.html(sub_html);
    }
    function changeTaskTitle(o,taskId,title,childId){
        var prev = $(o).prev().val();
        console.log(prev);
        $.ajax({
            type: "get",//设置get请求方式
            url: "<c:url value='/task/editTaskTitle.do?'/>",//设置请求的脚本地址
            data: "taskId="+taskId+"&title="+prev+"&childId="+childId,//设置请求的数据
            async: true,
            dataType: "json",//设置请求返回的数据格式
            success: function (data) {
                var parent_html = $("#"+taskId);
                parent_html.empty();
                var child_html = "<article class=\"am-comment\" id=\""+data.id+"\">"+
                        "    <a href=\"javascript:void (0);\" onclick=\"changeInput(this ,'"+data.id+"','"+childId+"');\">编辑</a>"+
                        "    <a href=\"javascript:void (0);\"  onclick=\"forwardUrl(this,'"+data.name+"','"+data.username+"','"+data.id+"');\">标记</a>"+
                        "     <a href=\"<c:url value='/basic/xm.do?qm=formTask&id='/>"+data.id+"\" class=\"am-comment-author\">"+data.title+"</a>"+
                        "     <p style=\"display: inline\"></p>"+
                        "</article>";
                parent_html.html(child_html);
            }
        })
    }
</script>
</body>
</html>
