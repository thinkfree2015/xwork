<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/7
  Time: 10:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑流程</strong> / <small>New/Edit Flow</small></div>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value="/flow/createFlow.do"/>" method="post"  class="am-form am-form-horizontal">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="1">
        <div class="am-form-group">
            <label name="title" for="title" class="am-u-sm-3 am-form-label">流程标题 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="title" id="title" placeholder="流程标题" value="${object.title}">
            </div>
        </div>


        <div class="am-form-group">
            <label name="roleId"  class="am-u-sm-3 am-form-label">指定流程开始节点<small>*</small></label>
            <div class="am-u-sm-9">
                <select name="begin" id="begin" class="selectValidate" >
                    <option>请选择</option>
                    <option value="1">产品组</option>
                    <option value="2">UI设计组</option>
                    <option value="3">前端开发组</option>
                    <option value="4">开发组</option>
                    <option value="5">测试组</option>
                    <option value="6">运营组</option>
                    <option value="7">运维组</option>
                    <option value="0">尚未定义</option>
                </select>

            </div>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
<!-- content end -->
<hr/>

<script>

</script>
</body>
</html>
