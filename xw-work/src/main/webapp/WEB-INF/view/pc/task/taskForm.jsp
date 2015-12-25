<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title></title>
    <script src="<c:url value="/scripts/task.js" />"></script>
    <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>" ></script>
    <style type="text/css">
        .todo-content {
            display: inline-block;
            width: 465px;
            padding: 0 35px 0 0;
            margin: 0;
            font-size: 15px;
            line-height: 1.6;
            vertical-align: top;
            word-break: break-all;
        }
        .no-border {
            border: none;
            border-bottom: 1px dashed #cccccc;
            border-radius: 0;
        }

        textarea{
            outline: 0 none;
            font-family: monospace;
            overflow-y:visible;
            -webkit-appearance: textarea;
            background-color: white;
            -webkit-rtl-ordering: logical;
            -webkit-user-select: text;
            flex-direction: column;
            white-space: pre-wrap;
            text-rendering: auto;
            color: initial;
            letter-spacing: normal;
            word-spacing: normal;
            text-transform: none;
            text-indent: 0px;
            text-shadow: none;
            text-align: start;
            -webkit-writing-mode: horizontal-tb;
            box-shadow: none;
        }
        ul li{
            list-style-type:none;
        }
    </style>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">任务详情</strong> </div>
</div>


<div class="am-g">

    <div class="project">
        <div>
            <small>
              <span>项目:${object.taskGroup.project.title}</span>
              <span>清单:${object.taskGroup.title}</span>
              <span>流程:${object.flow.title}</span>
              <span>当前节点:${object.currentInstance.flowActivity.title}</span>
            </small>
        </div>
        <hr/>
        <div>
            <ul>
                <li class="todo">
                    <div class="todo-action" style="display: none;position: absolute;left: 13%;background-color: #FFFFFF">
                        <div  style="padding-left: 30px;">
                            <a href="javascript:void (0);"><img src="<c:url value="/scripts/image/taskEdit.png"/>" alt="编辑"/></a>
                            <a href="javascript:void (0);"><img src="<c:url value="/scripts/image/taskDel.png"/>" alt="删除"/></a>
                            <a href="javascript:void (0);"></a>
                        </div>
                    </div>
                    <div class="todo-wrap" style="position:relative ;left: 10px;">
                         <span>
                              <a href="<c:url value="/basic/xm.do?qm=formTask&id=${task.id}&projectId=${object.id}"/> ">${object.title}</a>
                         </span>

                         <span>
<c:if test="${not empty object.currentInstance}">
 　　　　　　　　　　　　　　　　<select  onchange="sendUser(this,'${task.id}','<c:url value="/project/sendUser.do"/>')" style="font-size: 10%;margin-left: -259px">
                             　　　　<option value="null">请选择成员</option>
                             　　　　　<c:forEach var="user" items="${object.currentInstance.flowActivity.user}">
                             　　　　　　　<option value="${user.id}" <c:if test="${object.currentUser.id==user.id}">selected="selected"</c:if>>${user.name}</option>
                             　　　　　</c:forEach>
                             　　</select>
    </c:if>
                         </span>
                    </div>
                </li>
            </ul>
            <small>
                <a href="javascript:void (0);">添加/编辑任务描述</a>
            </small>
        </div>
        <div>
            任务描述
        </div>
    </div>
    <hr/>
    <div class="">
        <c:forEach var="dynamic" items="${object.taskDynamicList}">
            <div>
              <span><fmt:formatDate value="${dynamic.createDatetime}" pattern="yyyy-MM-dd hh:mm" type="both"/></span>
              <span><a href="javascript:void (0);">${dynamic.creator.name}</a></span>
              <span>${dynamic.message}</span>
            </div>
        </c:forEach>
    </div>
    <hr/>
    <div class="">
        <c:forEach var="taskNote" items="${object.taskNoteList}">

        </c:forEach>
    </div>
    <hr/>
    <div class="pinglun">
        <label>发表评论:</label>
        <textarea id="container" name="content" type="text/plain" style="width:70%;height:25%"></textarea>
        <%--<textarea class="ckeditor"  name="content" id="content" style="width: 65%;" rows="3" cols="4"></textarea>--%>
        <div class="am-margin" style="margin-left: 65%;">
            <a href="javascript:void (0);" onclick="toSubmitZH('2');" class="am-btn am-btn-primary am-btn-xs">发表评论</a>
        </div>
    </div>



    <%--<fieldset>--%>
        <%--<legend>--%>

            <%--<div>--%>
                <%--<input type="checkbox">--%>
                <%--<div class="am-dropdown" data-am-dropdown>--%>
                    <%--<a  href="javascript:void (0);" class="am-dropdown-toggle" data-am-dropdown-toggle><img src="<c:url value="/scripts/image/taskDown2.png"/>" alt="编辑"/>--%>
                        <%--<ul class="am-dropdown-content">--%>
                            <%--<li><a href="#"><img src="<c:url value="/scripts/image/taskEdit.png"/>" alt="编辑"/> 编辑</a></li>--%>
                            <%--<li><a href="#"><img src="<c:url value="/scripts/image/taskDel.png"/>" alt="删除"/> 删除</a></li>--%>
                        <%--</ul>--%>
                    <%--</a>--%>
                <%--</div>--%>
                <%--${object.title}--%>

                <%--<select  onchange="sendUser(this,'${object.id}','<c:url value="/project/sendUser.do"/>')" style="font-size: 10%">--%>
                    <%--<option value="null" <c:if test="${empty object.currentUser}">selected="selected"</c:if>>未指派</option>--%>
                    <%--<c:forEach var="member" items="${userList}">--%>
                        <%--<option value="${member.user.id}" <c:if test="${member.user.id==object.currentUser.id}">selected="selected"</c:if>>${member.user.username}</option>--%>
                    <%--</c:forEach>--%>

                <%--</select>--%>

            <%--</div>--%>

            <%--<p style="text-indent:2em">--%>
                <%--<span id="OldContent">${object.content}</span>--%>
                <%--<small style="margin-left: 85%">--%>
                    <%--<a href="javascript:void (0);" onclick="editTask('${object.id}')" class="a"> 编辑</a>--%>
                <%--</small>--%>
            <%--</p>--%>
            <%--<div style="width: 100%;display: none" id="EditContent">--%>
            <%--<p style="text-indent:2em">--%>
                <%--<textarea rows="3" cols="4" style="width: 78%" id="TextContent">${object.content}</textarea>--%>
                <%--<div class="am-margin" style="margin-left: 40px;">--%>
                <%--<a href="javascript:void (0);" onclick="saveContent('2');" class="am-btn am-btn-primary am-btn-xs">保存</a>--%>
                <%--<a href="javascript:void (0);" onclick="cancelContent('2');" class="am-btn am-btn-primary am-btn-xs">取消</a>--%>
                <%--</div>--%>
            <%--</p>--%>
            <%--</div>--%>


        <%--</legend>--%>
        <%--<c:forEach var="taskActivity" items="${object.taskActivityList}">--%>
              <%--<div>--%>
                  <%--<fmt:formatDate value="${taskActivity.createDatetime}" pattern="yyyy-MM-dd hh:mm" type="both"/>--%>
                  <%--&nbsp;&nbsp;${taskActivity.excutor.username}&nbsp;&nbsp;<ming800:status name="status" dataType="FlowActivity.statusType" checkedValue="${taskActivity.status}" type="normal"/>这条任务--%>
              <%--</div>--%>

        <%--</c:forEach>--%>
        <%--<hr>--%>
        <%--<form action="<c:url value="/project/saveProject.do"/>"  class="am-form am-form-horizontal" method="post" enctype="multipart/form-data">--%>

             <%--<textarea  name="content" class="ckeditor" id="content"--%>
                        <%--placeholder="任务描述">--%>

             <%--</textarea>--%>


            <%--<div class="am-margin">--%>
                <%--<a href="javascript:void (0);" onclick="toSubmitZH('2');" class="am-btn am-btn-primary am-btn-xs">发表评论</a>--%>
            <%--</div>--%>
        <%--</form>--%>
    <%--</fieldset>--%>

</div>
<!-- content end -->
<hr/>

<script type="text/javascript">
    //初始化操作
    $(function(){
        $(".todo").hover(function(){
            $(this).find(".todo-action").css({"display":"block"});
        },function(){
            $(this).find(".todo-action").css({"display":"none"});
        });
        var ue = UM.getEditor('container');
        ue.execCommand( 'insertimage', {
            src:'<c:url value="/scripts/image/taskDel.png"/>',
            width:'100',
            height:'100'
        } );
//        CKEDITOR.replace('content', {height: '300px', width: '1000px'});

    });


    function editTask(){
          $("#EditContent").css({"display":"block"});
          $("#OldContent").css({"display":"none"});
        $("#TextContent").val()
    }
    function saveContent(){
        $("#EditContent").css({"display":"none"});
        $("#OldContent").text($("#TextContent").val());
        $("#OldContent").css({"display":"block"});
    }
function cancelContent(){
    $("#EditContent").css({"display":"none"});
    $("#OldContent").css({"display":"block"});
}
</script>
</body>
</html>
