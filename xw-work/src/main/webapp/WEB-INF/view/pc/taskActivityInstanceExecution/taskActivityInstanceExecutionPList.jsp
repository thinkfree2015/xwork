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
        <a onclick="changeInput(this , '${taskActivityInstanceExecution.task.id}');">编辑</a>
        <a href="javascript:void (0);">标记</a>
        <a href="<c:url value='/basic/xm.do?qm=formTask&id=${taskActivityInstanceExecution.task.id}'/>" class="am-comment-author">${taskActivityInstanceExecution.task.content}</a>
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
  function changeInput(o,taskId){

  }
  function changeData(o){
    var checkVal = $(o).val();
    $.ajax({
      type: "get",//设置get请求方式
      url: "<c:url value='/taskActivityInstanceExecution/'/>"+checkVal,//设置请求的脚本地址
      data: "",//设置请求的数据
      async: true,
      dataType: "json",//设置请求返回的数据格式
      success: function (data) {
        console.log(data);
        var box = $("#box");
        box.empty();
        var sub = "";
        if(data && data.length > 0){
          for(var i in data){
            sub += "<article class=\"am-comment\">"+
            "        <a onclick=\"changeInput(this,'"+data[i].taskId+"')\">编辑</a>"+
            "        <a onclick=\"\">标记</a>"+
            "        <a href=\"<c:url value='/basic/xm.do?qm=formTask&id='/>"+data[i].taskId+"\" class=\"am-comment-author\">"+data[i].taskContent+" </a>"+
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
