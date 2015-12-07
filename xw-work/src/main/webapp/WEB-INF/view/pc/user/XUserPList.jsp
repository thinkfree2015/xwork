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
  <title>uesr group</title>
</head>
<body>
<div style="text-align: left;margin-left: 10px;" >
  <div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑用户组</strong> / <small>New/Edit GroupUser</small></div>
  </div>
</div>
<table class="am-table am-table-bordered am-table-radius am-table-striped" >
  <tr style="text-align: left">
    <td  width="25%">操作</td>
    <td  width="25%">组别名称</td>
    <td  width="15%">用户名称</td>
  </tr>


  <c:forEach items="${requestScope.pageInfo.list}" var="project">
    <%int i = 0;%>
    <tr style="text-align: left">
      <td>
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >

             <button onclick="removeUser(${})" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-search"></span> 移除</button>

          </div>
        </div>
      </td>
      <td width="20%">
        <c:if test="${project.level == 1}">
          <a href="<c:url value="/basic/xm.do?qm=viewProjectwiki&param=project&conditions=project.id:${project.id}&id=${project.id}"/>" >
              ${project.name}
          </a>
        </c:if>
      </td>


    </tr>
    <% i++;%>
  </c:forEach>
</table>
<div style="clear: both">
  <c:url value="/basic/xm.do" var="url"/>
  <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
    <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
    <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
  </ming800:pcPageList>
</div>

</body>
</html>
