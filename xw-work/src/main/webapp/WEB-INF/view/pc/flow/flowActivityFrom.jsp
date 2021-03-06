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
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑流程节点</strong> /
        <small>New/Edit FlowActivity</small>
    </div>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value="/flow/saveOrUpdateFlowActivity.do"/>" method="post" class="am-form am-form-horizontal">
        <input type="hidden" id="id" name="id" value="${object.id}">
        <input type="hidden" name="flow.id" value="${flowId}">
        <input type="hidden" id="userList">
        <input type="hidden" name="qm" value="saveOrUpdateFlowActivity">
        <input type="hidden" name="status" value="1">

        <div class="am-form-group">
            <label name="title" for="title" class="am-u-sm-3 am-form-label">流程节点标题
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <input type="text" name="title" id="title" placeholder="流程节点标题" value="${object.title}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="group" class="am-u-sm-3 am-form-label">流程节点所属小组
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <ming800:status name="group" dataType="FlowActivity.group" checkedValue="${object.group}"
                                onchange="setCheckbox();" type="select"/>
            </div>
        </div>
        <div class="am-form-group">
            <label name="roleId" class="am-u-sm-3 am-form-label">指定流程节点类型
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <ming800:status name="type" dataType="FlowActivity.type" checkedValue="${object.type}" type="select"/>
            </div>
        </div>
        <div class="am-form-group">
            <label name="roleId" class="am-u-sm-3 am-form-label">用户类型
                <small>*</small>
            </label>
            <div class="am-radio-inline">
                <input type="radio" name="createType" checked="checked" onclick="changeMethod('0');" value="0">发起人
            </div>
            <div class="am-radio-inline">
                <input type="radio" name="createType" onclick="changeMethod('1');" value="1">成员
            </div>
        </div>
        <div class="am-form-group" id="box_parent">
            <label name="context" class="am-u-sm-3 am-form-label">成员 </label>

            <div class="am-u-sm-9">
                <div class="am-tabs am-margin" data-am-tabs>
                    <ul class="am-tabs-nav am-nav am-nav-tabs">
                        <li class="am-active"><a href="#tab1" name="tab1" about="pro">产品</a></li>
                    </ul>
                    <div class="am-tabs-bd" style="height: 30%" id="box">

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
    $(document).ready(function () {
        setCheckbox();
        changeMethod('0');
    })
    function changeMethod(data){
        if(data == '0'){
            findCreator();
        }else{
            $("select[name='group']").val('1');
            setCheckbox();
        }
    }
    function findCreator(){
        $.ajax({
            type: "post",//设置get请求方式
            url: "<c:url value='/flow/findCreator'/>",//设置请求的脚本地址
            data: "",
            async: false,
            dataType: "json",//设置请求返回的数据格式
            success: function (data) {
                console.log(data);
                var box = $("#box");
                box.empty();
                var sub = "<div class=\"am-tab-panel am-fade am-in am-active\" id=\"tab1\" style=\"height: 30%;\">";
                if(data && data.id != null){
                    $("select[name='group']").val(data.groupName);
                    sub += "<input name=\"user\" readonly='readonly' checked='checked' type=\"checkbox\" value=\"" + data.id + "\"/>";
                    sub += "<a href=\"javascript:void (0)\">" + data.name + "</a>";
                }
                sub += "</div>";
                box.append(sub);
            }
        })
    }
    function setCheckbox() {
        var value = $("select[name='group']").val();
        var id = $("#id").val();
        var flowId = '${flowId}';
        console.log(flowId);
        if (value == 6) {
            $("a[name='tab1']").html("运营");
        } else if (value == 1) {
            $("a[name='tab1']").html("产品");
        } else if (value == 2) {
            $("a[name='tab1']").html("UI");
        } else if (value == 3) {
            $("a[name='tab1']").html("前端");
        } else if (value == 4) {
            $("a[name='tab1']").html("开发");
        } else if (value == 5) {
            $("a[name='tab1']").html("测试");
        }
        getUsers(id, flowId, value);
    }
    function getUsers(id, flowId, groupName) {
        $.ajax({
            type: "post",//设置get请求方式
            url: "<c:url value='/flow/getUsers/'/>" + groupName,//设置请求的脚本地址
            data: "id=" + id + "&flowId=" + flowId,//设置请求的数据
            async: false,
            dataType: "json",//设置请求返回的数据格式
            success: function (data) {
                console.log(data);
                var box = $("#box");
                box.empty();
                var sub = "<div class=\"am-tab-panel am-fade am-in am-active\" id=\"tab1\" style=\"height: 30%;\">";
                for (var i in data) {
                    var keyVal = i.substring(16, i.length);
                    if (keyVal == "true") {
                        sub += "<input name=\"user\" checked='checked' type=\"checkbox\" value=\"" + data[i].id + "\"/>";
                    } else if (keyVal == "false") {
                        sub += "<input name=\"user\" type=\"checkbox\" value=\"" + data[i].id + "\"/>";
                    }
                    sub += "<a href=\"javascript:void (0)\">" + data[i].name + "</a>";
                }
                sub += "</div>";
                box.append(sub);
            }
        })
    }
</script>
</body>
</html>
