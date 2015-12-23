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

<div class="am-cf am-padding">
    <a href="<c:url value="/basic/xm.do?qm=formFlowActivity&flowId=${object.id}" /> " class="am-btn am-btn-default"><span class="am-icon-plus"></span> 新建节点</a>
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
                                <c:forEach items="${proList}" var="maps">

                                <c:forEach items="${maps}" var="map">
                                    <c:if test="${map.value=='true'}">
                                    <input name="user" type="checkbox" checked="checked" value="${map.key.id}"/>
                                        <a href="javascript:void (0)">${map.key.name}</a>
                                    </c:if>
                                    <c:if test="${map.value==''}">
                                        <input name="user" type="checkbox" value="${map.key.id}"/>
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
                                            <input name="user" type="checkbox" checked="checked" value="${map.key.id}"/>
                                            <a href="javascript:void (0)">${map.key.name}</a>
                                        </c:if>
                                        <c:if test="${map.value==''}">
                                            <input name="user" type="checkbox" value="${map.key.id}"/>
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
                                            <input name="user" type="checkbox" checked="checked" value="${map.key.id}"/>
                                            <a href="javascript:void (0)">${map.key.name}</a>
                                        </c:if>
                                        <c:if test="${map.value==''}">
                                            <input name="user" type="checkbox" value="${map.key.id}"/>
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
                                            <input name="user" type="checkbox" checked="checked" value="${map.key.id}"/>
                                            <a href="javascript:void (0)">${map.key.name}</a>
                                        </c:if>
                                        <c:if test="${map.value==''}">
                                            <input name="user" type="checkbox" value="${map.key.id}"/>
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
                                            <input name="user" type="checkbox" checked="checked" value="${map.key.id}"/>
                                            <a href="javascript:void (0)">${map.key.name}</a>
                                        </c:if>
                                        <c:if test="${map.value==''}">
                                            <input name="user" type="checkbox" value="${map.key.id}"/>
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
                                            <input name="user" type="checkbox" checked="checked" value="${map.key.id}"/>
                                            <a href="javascript:void (0)">${map.key.name}</a>
                                        </c:if>
                                        <c:if test="${map.value==''}">
                                            <input name="user" type="checkbox" value="${map.key.id}"/>
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
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
<!-- content end -->
<hr/>
<div class="am-g">
    <form action="<c:url value=''/>" method="post"  class="am-form am-form-horizontal">
        <%--<input type="hidden" name="id" value="${object.id}">--%>
        <%--<input type="hidden" name="status" value="1">--%>
        <%--<input type="hidden" name="qm" value="saveOrUpdateFlow">--%>
        <table>
            <c:forEach items="${object.activityList}" var="pop">
                <tr style="text-align: left" id="${pop.id}">
                    <c:if test="${pop.status != '0'}">
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                                    <%--<button onclick="window.location.href='<c:url value="/basic/xm.do?qm=removeFlowActivity&id=${pop.id}"/>'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-search"></span> 废弃</button>--%>
                                    <%--<button onclick="window.location.href='<c:url value="/basic/xm.do?qm=formFlowActivity&flowId=${object.id}&id=${pop.id}"/>'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-search"></span> 编辑</button>--%>
                                    <a href="<c:url value="/basic/xm.do?qm=removeFlowActivity&id=${pop.id}"/>" class="am-btn am-btn-default"><span class="am-icon-plus"></span>废弃</a>
                                    <a href="<c:url value="/basic/xm.do?qm=formFlowActivity&flowId=${object.id}&id=${pop.id}"/>" class="am-btn am-btn-default"><span class="am-icon-plus"></span>编辑</a>
                                </div>
                            </div>
                        </td>
                    </c:if>
                    <td width="35%">
                        <a href="<c:url value='/basic/xm.do?qm=viewFlowActivity&id=${pop.id}'/>">
                            <c:if test="${!empty pop.title && pop.status != '0'}">
                                ${pop.title}
                            </c:if>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </form>
</div>

<script>

</script>
</body>
</html>
