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
    <link rel="stylesheet" type="text/css" href="<c:url value="/scripts/simditor/styles/font-awesome.css" />" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/scripts/simditor/styles/simditor.css" />" />
     <script type="text/javascript" src="<c:url value="/scripts/simditor/scripts/js/simditor-all.js" />"></script>
    <%--<script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>" ></script>--%>
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
                             <input type="checkbox" onclick="completeTask(this,'${object.id}')"/>
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
    <c:if test="${object.status=='1'}">
    <div class="" id="note">
        <c:forEach var="taskNote" items="${object.taskNoteList}">
            <div>
                <span><a href="javascript:void (0);">${taskNote.creator.name}</a></span>
                <span><small><fmt:formatDate value="${taskNote.createDatetime}" pattern="yyyy-MM-dd hh:mm" type="both"/></small></span><br/>
                <span>${taskNote.content}</span>
            </div>
        </c:forEach>
    </div>
    <hr/>
    <div class="pinglun">
        <label>发表评论:</label>
        <textarea id="content" name="content" style="width:70%;height:25%" placeholder="这里输入评价" autofocus></textarea>
        <%--<textarea class="ckeditor"  name="content" id="content"  rows="3" cols="4"></textarea>--%>
        <div class="am-margin" style="margin-left: 65%;">
            <a href="javascript:void (0);" onclick="toReview(this);" class="am-btn am-btn-primary am-btn-xs">发表评论</a>
        </div>
    </div>

    </c:if>



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

       var  editor = new Simditor({
           textarea:$("#content"),
           upload:{
               url:"<c:url value="/task/img.do" />",
               params:""
           },
           pasteImage:true

       });

        if('${object.status}'=='0'){
            $("select").attr("disabled",true);
            $("input[type='checkbox']").attr("disabled",true);
        }

$(".simditor-toolbar ul").css({"margin-top":"10px"});
//        CKEDITOR.replace('content', {height: '300px', width: '1000px'});

    });


    //发表评论
    function toReview(obj){
          var v = $("#content").val();
          var taskId = '${object.id}';
        $.ajax({
            type:"post",
            url:"<c:url value="/task/saveNote.do"/>",
            data:{content:v,taskId:taskId},
            success:function(data){
                data = $.parseJSON(data);
                var div = ' <div>'+
                          '  <span><a href="javascript:void (0);">'+data.creator.name+'</a></span>'+'<br/>'+
                          '  <span><small>刚刚</small></span>'+
                          '  <span>'+data.content+'</span>'+
                          '</div>';
                $("#note").append(div);
            }
        });
    }

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
