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
        <article class="am-comment">
            <a href="javascript:void (0);"
               onclick="changeInput(this , '${taskActivityInstanceExecution.task.id}');">编辑</a>
            <a href="javascript:void (0);"
               onclick="forwardUrl(this,'${myUser.name}','${taskActivityInstanceExecution.task.id}');">标记</a>
            <a href="<c:url value='/basic/xm.do?qm=formTask&id=${taskActivityInstanceExecution.task.id}'/>"
               class="am-comment-author">${taskActivityInstanceExecution.task.title}</a>
        </article>
        <div id="webSocket" style="display: none;">
            <div id="connect-container">
                <div>
                    <textarea id="message" style="width: 350px">{'type':'1','content':'Here is a message!','creator':'15538398530','receiver':'15538398530'}</textarea>
                </div>
                <div>
                    <button id="echo" onclick="echo();" disabled="disabled">Echo message</button>
                </div>
            </div>
            <div id="console-container">
                <div id="console"></div>
            </div>
        </div>
    </c:forEach>
</div>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
<%--<script type="text/babel">--%>

<%--var PageInfoList = React.createClass({--%>
<%--getInitialState:function(){--%>
<%--return {--%>
<%--pageList:[]--%>
<%--}--%>
<%--},--%>
<%--dataOnLoad:function(){--%>
<%--$.ajax({--%>
<%--type:"post",--%>
<%--dataType:"json",--%>
<%--url:"<c:url value='/taskActivityInstanceExecution/0'/>",--%>
<%--success:function(result){--%>
<%--this.setState({pageList:result})--%>
<%--}.bind(this)--%>
<%--})--%>
<%--},--%>
<%--componentWillMount:function(){--%>
<%--this.dataOnLoad();--%>
<%--},--%>
<%--render:function(){--%>
<%--return (--%>

<%--<div>--%>
<%--{--%>
<%--this.state.pageList.map(function(data){--%>
<%--return <div key="{data.id}"><a>编辑</a>  <a>标记</a>  <a href="javascript:void(0);">{data.taskContent}</a></div>--%>
<%--&lt;%&ndash;return <div className="am-comment" key={data.id}><a>{data.taskContent}</a></div>&ndash;%&gt;--%>
<%--})--%>
<%--}--%>
<%--</div>--%>
<%--)--%>
<%--}--%>
<%--})--%>
<%--ReactDOM.render(--%>
<%--<PageInfoList/>,--%>
<%--document.getElementById('box')--%>
<%--)--%>
<%--</script>--%>
<script type="text/javascript">
    var ws = null;
    var url = null;
    var transports = [];
    function setConnected(connected) {
        document.getElementById('echo').disabled = !connected;
    }
    function connect() {
        if ('WebSocket' in window) {
            ws = new WebSocket("ws://192.168.1.68:8080/websck");
        } else if ('MozWebSocket' in window) {
            alert("MozWebSocket");
            ws = new MozWebSocket("ws://websck");
        } else {
            ws = new SockJS("http://192.168.1.68:8080/sockjs/websck");
        }
        ws.onopen = function () {
            alert('Open 连接');
        };
        ws.onmessage = function (event) {
            console.log("发送消息")
            alert('Received:' + event.data);
        };
        ws.onclose = function (event) {
            console.log("关闭连接")
        };
    }
    function disconnect() {
        if (ws != null) {
            ws.close();
            ws = null;
        }
//    setConnected(false);
    }
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
    $(document).ready(function () {
        connect();
    });
    function forwardUrl(o, userName, taskId) {
        updateUrl('/websocket');
        connect();
        $.ajax({
            type: "get",//设置get请求方式
            url: "<c:url value='/task/changeTaskStatus?taskId='/>" + taskId,//设置请求的脚本地址
            data: "",//设置请求的数据
            async: true,
            dataType: "json",//设置请求返回的数据格式
            success: function (data) {
                if (data && data.length > 0) {
                    var text_str = "[";
                    for (var i in data) {
                        text_str += data[i].username + ",";
                    }
                    text_str = text_str.substr(0, text_str.length - 1);
                    text_str += "]";
//                    var value = JSON.stringify(data[i]);
                    console.log(text_str);
                    var a_html = "{'receiver':'" + text_str + "','content':'" + userName + "完成了任务" + ($(o).next().html()) + "'}";
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
</script>
</body>
</html>
