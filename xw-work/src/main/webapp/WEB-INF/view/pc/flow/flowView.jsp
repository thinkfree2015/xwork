<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
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
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">查看流程</strong> / <small>VIEW Flow</small></div>
</div>

<div class="am-cf am-padding">
    <a onclick="return false;" href="<c:url value="/basic/xm.do?qm=formFlowActivity&flowId=${object.id}"/> " class="am-btn am-btn-default"><span class="am-icon-plus"></span> 新建节点</a>
</div>
<hr/>
<div class="am-g">
    <form action="<c:url value="/flow/createFlow.do"/>" method="post"  class="am-form am-form-horizontal">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="1">
        <div class="am-form-group">
            <label name="title" for="title" class="am-u-sm-3 am-form-label">流程标题 <small>*</small></label>
            <div class="am-u-sm-9"><p>${object.title}</p>
                <%--<input type="text" name="title" id="title" disabled="disabled" placeholder="流程标题" value="">--%>
            </div>
        </div>
        <div class="am-form-group">
            <label name="context" class="am-u-sm-3 am-form-label">成员 </label>
            <div class="am-u-sm-9">
                <div class="am-tabs am-margin" data-am-tabs>
                    <%--<c:forEach items="${object.user}" var="user">--%>
                        <%--<c:choose>--%>
                            <%--<c:when test="${user.group == '1'}">--%>
                                <%--产品组[${user.name}]--%>
                            <%--</c:when>--%>
                            <%--<c:when test="${user.group == '2'}">--%>
                                <%--UI组[${user.name}]--%>
                            <%--</c:when>--%>
                            <%--<c:when test="${user.group == '3'}">--%>
                                <%--前端组[${user.name}]--%>
                            <%--</c:when>--%>
                            <%--<c:when test="${user.group == '4'}">--%>
                                <%--开发组[${user.name}]--%>
                            <%--</c:when>--%>
                            <%--<c:when test="${user.group == '5'}">--%>
                                <%--测试组[${user.name}]--%>
                            <%--</c:when>--%>
                            <%--<c:when test="${user.group == '6'}">--%>
                                <%--运营组[${user.name}]--%>
                            <%--</c:when>--%>
                            <%--<c:otherwise>--%>
                                <%--运维组--%>
                            <%--</c:otherwise>--%>
                        <%--</c:choose>--%>
                    <%--</c:forEach>--%>
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
                                <c:forEach items="${proList}" var="maps">

                                <c:forEach items="${maps}" var="map">
                                    <c:if test="${map.value=='true'}">
                                    <input name="user" type="checkbox" checked="checked" disabled="disabled" value="${map.key.id}"/>
                                        <a href="javascript:void (0)">${map.key.name}</a>
                                    </c:if>
                                    <c:if test="${map.value==''}">
                                        <input name="user" type="checkbox" disabled="disabled" value="${map.key.id}"/>
                                        <a href="javascript:void (0)">${map.key.name}</a>
                                    </c:if>
                                    </c:forEach>
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="am-tab-panel am-fade am-in am-active" id="tab2" style="height: 30%;">
                            <c:if test="${!empty uiList}">
                                <c:forEach items="${uiList}" var="maps">
                                    <c:forEach items="${maps}" var="map">
                                        <c:if test="${map.value=='true'}">
                                            <input name="user" type="checkbox" disabled="disabled" checked="checked" value="${map.key.id}"/>
                                            <a href="javascript:void (0)">${map.key.name}</a>
                                        </c:if>
                                        <c:if test="${map.value==''}">
                                            <input name="user" type="checkbox" disabled="disabled" value="${map.key.id}"/>
                                            <a href="javascript:void (0)">${map.key.name}</a>
                                        </c:if>
                                    </c:forEach>
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="am-tab-panel am-fade am-in am-active" id="tab3" style="height: 30%;">
                            <c:if test="${!empty webList}">
                                <c:forEach items="${webList}" var="maps">
                                    <c:forEach items="${maps}" var="map">
                                        <c:if test="${map.value=='true'}">
                                            <input name="user" type="checkbox" disabled="disabled" checked="checked" value="${map.key.id}"/>
                                            <a href="javascript:void (0)">${map.key.name}</a>
                                        </c:if>
                                        <c:if test="${map.value==''}">
                                            <input name="user" type="checkbox" disabled="disabled" value="${map.key.id}"/>
                                            <a href="javascript:void (0)">${map.key.name}</a>
                                        </c:if>
                                    </c:forEach>
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="am-tab-panel am-fade am-in am-active" id="tab4" style="height: 30%;">
                            <c:if test="${!empty devList}">
                                <c:forEach items="${devList}" var="maps">
                                    <c:forEach items="${maps}" var="map">
                                        <c:if test="${map.value=='true'}">
                                            <input name="user" type="checkbox" disabled="disabled" checked="checked" value="${map.key.id}"/>
                                            <a href="javascript:void (0)">${map.key.name}</a>
                                        </c:if>
                                        <c:if test="${map.value==''}">
                                            <input name="user" type="checkbox" disabled="disabled" value="${map.key.id}"/>
                                            <a href="javascript:void (0)">${map.key.name}</a>
                                        </c:if>
                                    </c:forEach>
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="am-tab-panel am-fade am-in am-active" id="tab5" style="height: 30%;">
                            <c:if test="${!empty testList}">
                                <c:forEach items="${testList}" var="maps">
                                    <c:forEach items="${maps}" var="map">
                                        <c:if test="${map.value=='true'}">
                                            <input name="user" type="checkbox" disabled="disabled" checked="checked" value="${map.key.id}"/>
                                            <a href="javascript:void (0)">${map.key.name}</a>
                                        </c:if>
                                        <c:if test="${map.value==''}">
                                            <input name="user" type="checkbox" disabled="disabled" value="${map.key.id}"/>
                                            <a href="javascript:void (0)">${map.key.name}</a>
                                        </c:if>
                                    </c:forEach>
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="am-tab-panel am-fade am-in am-active" id="tab6" style="height: 30%;">
                            <c:if test="${!empty operateList}">
                                <c:forEach items="${operateList}" var="maps">
                                    <c:forEach items="${maps}" var="map">
                                        <c:if test="${map.value=='true'}">
                                            <input name="user" type="checkbox" disabled="disabled" checked="checked" value="${map.key.id}"/>
                                            <a href="javascript:void (0)">${map.key.name}</a>
                                        </c:if>
                                        <c:if test="${map.value==''}">
                                            <input name="user" type="checkbox" disabled="disabled" value="${map.key.id}"/>
                                            <a href="javascript:void (0)">${map.key.name}</a>
                                        </c:if>
                                    </c:forEach>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<!-- content end -->
<hr/>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">流程节点列表</strong> / <small>VIEW FlowActivity</small></div>
</div>
<div class="am-g">
    <form action="<c:url value=''/>" method="post"  class="am-form am-form-horizontal">
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">节点标题</td>
                <td class="am-primary am-u-md-3">所属小组</td>
                <td class="am-primary am-u-md-3">节点成员</td>
                <td class="am-primary am-u-md-3">节点类型</td>
            </tr>
            <c:forEach items="${object.activityList}" var="pop">
                <tr style="text-align: left" id="${pop.id}">
                    <td>
                        <c:if test="${!empty pop.title}">
                            ${pop.title}
                        </c:if>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${pop.group == '1'}">
                                产品组
                            </c:when>
                            <c:when test="${pop.group == '2'}">
                                UI组
                            </c:when>
                            <c:when test="${pop.group == '3'}">
                                前端组
                            </c:when>
                            <c:when test="${pop.group == '4'}">
                                开发组
                            </c:when>
                            <c:when test="${pop.group == '5'}">
                                测试组
                            </c:when>
                            <c:when test="${pop.group == '6'}">
                                运营组
                            </c:when>
                            <c:otherwise>
                                运维组
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:forEach items="${pop.user}" var="user">
                            [${user.name}]
                        </c:forEach>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${pop.type == '1'}">
                                one
                            </c:when>
                            <c:when test="${pop.type == '2'}">
                                xor
                            </c:when>
                            <c:otherwise>
                                and
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>
</div>

<script>

</script>
</body>
</html>
