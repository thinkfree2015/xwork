<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/07
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
  <title>流程实例列表</title>
</head>
<body>
<div style="text-align: left;margin-left: 10px;" >
  <div class="am-cf am-padding">
    <%--<a href="<c:url value="/flow/newFlowActivity.do" /> " class="am-btn am-btn-default"><span class="am-icon-plus"></span> 新建流程实例节点</a>--%>
  </div>

</div>
<%--<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>--%>
<table class="am-table am-table-bordered am-table-radius am-table-striped" >
  <tr style="text-align: left">
    <td  width="35%">操作</td>
    <td  width="35%">流程节点</td>
    <td  width="30%">节点所属小组</td>
  </tr>

  <c:forEach items="${requestScope.pageInfo.list}" var="object">
    <tr style="text-align: left" id="${object.id}">
      <td>
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
            <button onclick="removeFlow('${object.id}')" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-search"></span> 废弃</button>
            <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=formFlowActivity&param=formFlowActivity&id=${object.id}"/>'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-search"></span> 编辑</button>
          </div>
        </div>
      </td>
      <td width="35%">
        <c:if test="${!empty object.title}">
          ${object.title}
        </c:if>
      </td>
      <td width="30%">
        <c:if test="${!empty object.group}">
          <c:choose>
            <c:when test="${object.group  eq 1}">产品组</c:when>
            <c:when test="${object.group  eq 2}">UI设计组</c:when>
            <c:when test="${object.group  eq 3}">前端开发组</c:when>
            <c:when test="${object.group  eq 4}">开发组</c:when>
            <c:when test="${object.group  eq 5}">测试组</c:when>
            <c:when test="${object.group  eq 6}">运营组</c:when>
            <c:when test="${object.group  eq 7}">运维组</c:when>
            <c:otherwise>尚未定义</c:otherwise>
          </c:choose>
        </c:if>
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
<script>

  function removeFlow(flowActivityId){

    $.ajax({
      type:"get",
      url:"<c:url value='/flow/removeFlowActivity/'/>"+flowActivityId,//设置请求的脚本地址
      data:"",
      dataType:"json",
      success:function(data){
        if(data && data=="succ"){
          console.log("废除流程成功");
          $("#"+flowActivityId).remove();
        }
        return true;
      },
      error:function(e){
        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){

      }
    });
  }
</script>
</body>
</html>
