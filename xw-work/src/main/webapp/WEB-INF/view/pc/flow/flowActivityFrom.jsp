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
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑流程节点</strong> / <small>New/Edit FlowActivity</small></div>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value="/basic/xm.do"/>" method="post"  class="am-form am-form-horizontal">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="flow.id" value="${flowId}">
        <input type="hidden" name="qm" value="saveOrUpdateFlowActivity">
        <input type="hidden" name="status" value="1">
        <div class="am-form-group">
            <label name="title" for="title" class="am-u-sm-3 am-form-label">流程节点标题 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="title" id="title" placeholder="流程节点标题" value="${object.title}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="group"  class="am-u-sm-3 am-form-label">流程节点所属小组 <small>*</small></label>
            <div class="am-u-sm-9">
                <ming800:status name="group" dataType="FlowActivity.group" checkedValue="${object.group}" type="select"/>
            </div>
        </div>
        <div class="am-form-group">
            <label name="roleId"  class="am-u-sm-3 am-form-label">指定流程节点类型<small>*</small></label>
            <div class="am-u-sm-9">
                <ming800:status name="type" dataType="FlowActivity.type" checkedValue="${object.type}" type="select"/>
            </div>
        </div>
        <div class="am-form-group">
            <label name="context"  class="am-u-sm-3 am-form-label">成员 </label>
            <div class="am-u-sm-9">
                <div class="am-tabs am-margin" data-am-tabs>
                    <ul class="am-tabs-nav am-nav am-nav-tabs">
                        <li class="am-active"><a href="#tab1">产品</a></li>
                        <li><a href="#tab2">UI</a></li>
                        <li><a href="#tab3">前端</a></li>
                        <li><a href="#tab4">开发</a></li>
                        <li><a href="#tab5">测试</a></li>
                        <li><a href="#tab6">运营</a></li>
                    </ul>
                    <div class="am-tabs-bd" style="height: 30%">
                        <div class="am-tab-panel am-fade am-in am-active" id="tab1" style="height: 30%;">
                            <c:if test="${!empty proList}">
                                <c:forEach items="${proList}" var="myUser">
                                    <input name="user" onclick="return false;"  type="checkbox" checked="checked" value="${myUser.id}"/>
                                    <a href="javascript:void (0)">${myUser.username}</a>
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="am-tab-panel am-fade am-in am-active" id="tab2" style="height: 30%;">
                            <c:if test="${!empty uiList}">
                                <c:forEach items="${uiList}" var="myUser">
                                    <input name="user" onclick="return false;"  type="checkbox" checked="checked" value="${myUser.id}"/>
                                    <a href="javascript:void (0)">${myUser.username}</a>
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="am-tab-panel am-fade am-in am-active" id="tab3" style="height: 30%;">
                            <c:if test="${!empty webList}">
                                <c:forEach items="${webList}" var="myUser">
                                    <input name="user" onclick="return false;"  type="checkbox" checked="checked" value="${myUser.id}"/>
                                    <a href="javascript:void (0)">${myUser.username}</a>
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="am-tab-panel am-fade am-in am-active" id="tab4" style="height: 30%;">
                            <c:if test="${!empty devList}">
                                <c:forEach items="${devList}" var="myUser">
                                    <input name="user" onclick="return false;"  type="checkbox" checked="checked" value="${myUser.id}"/>
                                    <a href="javascript:void (0)">${myUser.username}</a>
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="am-tab-panel am-fade am-in am-active" id="tab5" style="height: 30%;">
                            <c:if test="${!empty testList}">
                                <c:forEach items="${testList}" var="myUser">
                                    <input name="user" onclick="return false;"  type="checkbox" checked="checked" value="${myUser.id}"/>
                                    <a href="javascript:void (0)">${myUser.username}</a>
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="am-tab-panel am-fade am-in am-active" id="tab6" style="height: 30%;">
                            <c:if test="${!empty operateList}">
                                <c:forEach items="${operateList}" var="myUser">
                                    <input name="user" onclick="return false;"  type="checkbox" checked="checked" value="${myUser.id}"/>
                                    <a href="javascript:void (0)">${myUser.username}</a>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                </div>
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
