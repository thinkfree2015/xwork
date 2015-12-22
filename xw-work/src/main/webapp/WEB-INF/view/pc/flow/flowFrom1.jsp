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
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建流程</strong> /
        <small>New Flow</small>
    </div>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value="/flow/createFlow.do"/>" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="1">
        <input type="hidden" name="sorts" value=""/>
        <input type="hidden" name="activities" value=""/>
        <div class="am-form-group">
            <label name="title" for="title" class="am-u-sm-3 am-form-label">流程标题
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <input type="text" name="title" id="title" placeholder="流程标题" value="${object.title}">
            </div>
        </div>
        <hr>
        <div class="am-form-group">
            <label name="title" for="title" class="am-u-sm-3 am-form-label">
                <a href="javascript:void (0);" onclick="addFlowActivity()">添加节点</a>
            </label>

            <div class="am-u-sm-9">
                <div style="margin-top: 10px;" flag="activity" sort="1">
                    <ming800:status name="ac" dataType="FlowActivity.type" type="select" onchange=""/>
                     <span>
                       <a href="javascript:void (0);" onclick="removeAC(this)"><img src="<c:url value="/scripts/image/taskDel.png"/>" alt="删除"/> </a>
                    </span>
                </div>
                <div style="margin-top: 10px;" flag="activity" sort="2">
                    <ming800:status name="ac" dataType="FlowActivity.type" type="select" onchange=""/>
                     <span>
                       <a href="javascript:void (0);" onclick="removeAC(this)"><img src="<c:url value="/scripts/image/taskDel.png"/>" alt="删除"/> </a>
                    </span>
                </div>
                <div style="margin-top: 10px;" flag="activity" sort="3">
                    <ming800:status name="ac" dataType="FlowActivity.type" type="select" onchange=""/>
                    <span>
                       <a href="javascript:void (0);" onclick="removeAC(this)"><img src="<c:url value="/scripts/image/taskDel.png"/>" alt="删除"/></a>
                    </span>
                </div>
            </div>
        </div>

        <%--<div class="am-form-group" flag="activity" style="text-align: center;" sort="0" >--%>
        <%--<label name="" for="title" class="am-u-sm-3 am-form-label"></label>--%>
        <%--<div class="am-u-sm-9 am-u-sm-push-3">--%>

        <%----%>
        <%--</div>--%>

        <%--</div>--%>
        <%--<div class="am-form-group" flag="activity" style="text-align: center;" sort="1">--%>
        <%--<label name="" for="title" class="am-u-sm-3 am-form-label"></label>--%>
        <%--<div class="am-u-sm-9 am-u-sm-push-3">--%>
        <%--<select  onchange=""  style="margin-left:-378px;width: 15%">--%>
        <%--<option>请选择</option>--%>
        <%--<option value="1">产品组</option>--%>
        <%--<option value="2">UI设计组</option>--%>
        <%--<option value="3">前端开发组</option>--%>
        <%--<option value="4">开发组</option>--%>
        <%--<option value="5">测试组</option>--%>
        <%--<option value="6">运营组</option>--%>
        <%--<option value="7">运维组</option>--%>
        <%--<option value="0">尚未定义</option>--%>
        <%--</select>--%>
        <%--</div>--%>

        <%--</div>--%>
        <%--<div class="am-form-group" flag="activity" style="text-align: center;" sort="2">--%>
        <%--<label name="" for="title" class="am-u-sm-3 am-form-label"></label>--%>
        <%--<div class="am-u-sm-9 am-u-sm-push-3">--%>
        <%--<select name="activity" onchange=""  style="margin-left:-378px;width: 15%">--%>
        <%--<option>请选择</option>--%>
        <%--<option value="1">产品组</option>--%>
        <%--<option value="2">UI设计组</option>--%>
        <%--<option value="3">前端开发组</option>--%>
        <%--<option value="4">开发组</option>--%>
        <%--<option value="5">测试组</option>--%>
        <%--<option value="6">运营组</option>--%>
        <%--<option value="7">运维组</option>--%>
        <%--<option value="0">尚未定义</option>--%>
        <%--</select>--%>
        <%--</div>--%>

        <%--</div>--%>
        <%--<fieldset>--%>
        <%--<a href="javascript:void (0);" onclick="addFlowActivity()">添加成员</a>--%>
        <%--<div class="am-form-group">--%>
        <%--<label name="context"  class="am-u-sm-3 am-form-label"></label>--%>
        <%--<div class="am-u-sm-9">--%>
        <%--<div class="am-tabs am-margin" data-am-tabs>--%>
        <%--<ul class="am-tabs-nav am-nav am-nav-tabs">--%>
        <%--<li class="am-active"><a href="#tab1">产品</a></li>--%>
        <%--<li><a href="#tab2">UI</a></li>--%>
        <%--<li><a href="#tab3">前端</a></li>--%>
        <%--<li><a href="#tab4">开发</a></li>--%>
        <%--<li><a href="#tab5">测试</a></li>--%>
        <%--<li><a href="#tab6">运营</a></li>--%>
        <%--<li><a href="#tab7">运维</a></li>--%>
        <%--</ul>--%>

        <%--<div class="am-tabs-bd" style="height: 50%">--%>


        <%--<div class="am-tab-panel am-fade am-in am-active" id="tab1" style="height: 50%;">--%>


        <%--</div>--%>
        <%--<div class="am-tab-panel am-fade am-in am-active" id="tab2" style="height: 50%;">--%>

        <%--</div>--%>
        <%--<div class="am-tab-panel am-fade am-in am-active" id="tab3" style="height: 50%;">--%>


        <%--</div>--%>
        <%--<div class="am-tab-panel am-fade am-in am-active" id="tab4" style="height: 50%;">--%>


        <%--</div>--%>
        <%--<div class="am-tab-panel am-fade am-in am-active" id="tab5" style="height: 50%;">--%>

        <%--</div>--%>
        <%--<div class="am-tab-panel am-fade am-in am-active" id="tab6" style="height: 50%;">--%>

        <%--</div>--%>
        <%--<div class="am-tab-panel am-fade am-in am-active" id="tab7" style="height: 50%;">--%>

        <%--</div>--%>


        <%--</div>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--</fieldset>--%>
        <%--<div class="am-form-group">--%>
        <%--<span style="margin-left: 26%;">--%>
        <%--<a href="javascript:void (0);" onclick="addFlowActivity()">添加节点</a>--%>
        <%--</span>--%>
        <%--</div>--%>

        <%--<div class="am-form-group">--%>
        <%--<label name="roleId"  class="am-u-sm-3 am-form-label">指定流程开始节点<small>*</small></label>--%>
        <%--<div class="am-u-sm-9">--%>
        <%--<select name="begin" id="begin" class="selectValidate" >--%>
        <%--<option>请选择</option>--%>
        <%--<option value="1">产品组</option>--%>
        <%--<option value="2">UI设计组</option>--%>
        <%--<option value="3">前端开发组</option>--%>
        <%--<option value="4">开发组</option>--%>
        <%--<option value="5">测试组</option>--%>
        <%--<option value="6">运营组</option>--%>
        <%--<option value="7">运维组</option>--%>
        <%--<option value="0">尚未定义</option>--%>
        <%--</select>--%>

        <%--</div>--%>
        <%--</div>--%>
        <div class="am-form-group" style="margin-top: 10px;">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="button" onclick="saveAC()" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
<!-- content end -->
<hr/>

<script>

    //删除节点
    function removeAC(obj){
        $(obj).parents("div[flag='activity']").remove();
    }
    //添加节点
    function addFlowActivity() {
        var len = $("div[flag='activity']").length;
        var div = $("div[flag='activity']:last");
        var divClone = $(div).clone();
        $(divClone).attr("sort", parseInt($(divClone).attr("sort")) + 1);
        $(div).after(divClone);
        //alert("有" + len + "个节点---最后一个节点是" + $(div).attr("sort") + "新加的节点是" + $(divClone).attr("sort"));
    }
    //保存流程
    function saveAC(){
        var sorts = "";
        var acs = [];
        var activities = "";
        var flag = true;
        $("div[flag='activity']").each(function(){
            if(acs.indexOf($(this).find("select").val())!=-1){
                flag = false;
                return false;
            }else{
                sorts += $(this).attr("sort")+";";
                activities += $(this).find("select").val()+";";
                acs.push($(this).find("select").val());
            }
        });
        if(!flag){
            alert("节点不能重复!");
        }else{
           $("input[name='sorts']").val(sorts);
            $("input[name='activities']").val(activities);
            $("form").submit();
        }

    }
</script>
</body>
</html>
