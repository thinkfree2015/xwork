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

<html>
<head>
  <title>流程实例列表</title>
</head>
<body>
<div style="text-align: left;margin-left: 10px;" >
  <div class="am-cf am-padding">
    <a href="<c:url value="/basic/xm.do?qm=formFlow" /> " class="am-btn am-btn-default"><span class="am-icon-plus"></span> 新建流程</a>
  </div>
</div>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<table class="am-table am-table-bordered am-table-radius am-table-striped" >
  <tr style="text-align: left">
    <td  width="35%">操作</td>
    <td  width="35%">流程名称</td>
    <td  width="30%">开始节点名称</td>
  </tr>

  <c:forEach items="${requestScope.pageInfo.list}" var="object">
    <tr style="text-align: left" id="${object.id}">
      <td>
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
            <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=removeFlow&id=${object.id}"/>'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-remove"></span>删除</button>
            <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=formFlow&id=${object.id}"/>'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-search"></span>编辑</button>
          </div>
        </div>
      </td>
      <td width="35%">
        <a href="<c:url value='/basic/xm.do?qm=viewFlow&id=${object.id}'/>">
          <c:if test="${!empty object.title}">
            ${object.title}
          </c:if>
        </a>
      </td>
      <td width="30%">
          <ming800:status name="type" dataType="FlowActivity.type" checkedValue="${object.type}" type="normal"/>
      </td>
    </tr>
  </c:forEach>
</table>
<div style="clear: both">
  <c:url value="/basic/xm.do" var="url"/>
  <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
    <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
    <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
  </ming800:pcPageList>
</div>
<%--<script>--%>
  <%--function removeUser(userId){--%>

    <%--$.ajax({--%>
      <%--type:"get",--%>
      <%--url:"<c:url value='/flow/removeFlow/'/>"+userId,//设置请求的脚本地址--%>
      <%--data:"",--%>
      <%--dataType:"json",--%>
      <%--success:function(data){--%>
        <%--if(data && data=="succ"){--%>
          <%--console.log("移除流程成功");--%>
          <%--$("#"+userId).remove();--%>
        <%--}--%>
        <%--return true;--%>
      <%--},--%>
      <%--error:function(e){--%>
        <%--alert("出错了，请联系管理员！！！");--%>
        <%--return false;--%>
      <%--},--%>
      <%--complete:function(){--%>

      <%--}--%>
    <%--});--%>
  <%--}--%>
<%--</script>--%>
</body>
</html>
