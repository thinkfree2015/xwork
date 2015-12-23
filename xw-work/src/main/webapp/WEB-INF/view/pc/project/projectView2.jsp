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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
    </style>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">${object.title}</strong></div>
</div>
<hr/>
<div class="am-u-md-12" style="margin-top: 4%;">
    <div class="am-btn-toolbar" style="float: right;">
        <div class="am-btn-group am-btn-group-xs" >
            <a href="javascript:void (0);" onclick="addTaskGroup('${object.id}')" class="am-btn am-btn-default"><span class="am-icon-plus"></span> 新建清单</a>
            <a href="javascript:void (0);"class="am-btn am-btn-default"><span class="am-icon-plus"></span> 成员(${fn:length(object.memberList)})</a>
        </div>
    </div>
</div>
<div class="am-g">
    <c:forEach items="${object.taskGroupList}" var="taskGroup">
        <hr/>
      <ul name="${taskGroup.id}">
               ${taskGroup.title}
             <c:forEach items="${taskGroup.taskList}" var="task">
                 <li class="todo" name="${task.id}">
                     <div class="todo-action" style="display: none;position: absolute;left: 13%;background-color: #FFFFFF">
                         <div  style="padding-left: 10px;">
                             <a href="javascript:void (0);"><img src="<c:url value="/scripts/image/taskEdit.png"/>" alt="编辑"/></a>
                             <a href="javascript:void (0);"><img src="<c:url value="/scripts/image/taskDel.png"/>" alt="删除"/></a>
                             <a href="javascript:void (0);"></a>
                         </div>
                     </div>
                     <div class="todo-wrap" style="position:relative ;left: 10px;">
                         <span>
                              <a href="<c:url value="/basic/xm.do?qm=formTask&id=${task.id}&projectId=${object.id}"/> ">${task.title}</a>
                         </span>
                         <span>
                              <select  onchange="changeActivity(this)" style="font-size: 10%" disabled="disabled">
                                  <option value="null">请选择流程</option>
                                  <c:forEach var="flow" items="${flowList}">
                                      <option value="${flow.id}" <c:if test="${flow.id==task.flow.id}">selected="selected" </c:if>>${flow.title}</option>
                                  </c:forEach>
                              </select>
                         </span>

                         <span>
                              <c:if test="${not empty task.currentInstance}">
 　　　　　　　　　　　　　　　　<select  onchange="sendUser(this,'${task.id}','<c:url value="/project/sendUser.do"/>')" style="font-size: 10%;margin-left: -259px">
   　　　　　　　　　　　　　　　　  <option value="null">请选择成员</option>
    　　　　　　　　　　　　　　　　 <c:forEach var="user" items="${task.currentInstance.flowActivity.user}">
       　　　　　　　　　　　　　　  <option value="${user.id}" <c:if test="${user.id==task.currentUser.id}">selected="selected"</c:if>>${user.title}</option>
     　　　　　　　　　　　　　　　　</c:forEach>
 　　　　　　　　　　　　　　　　</select>
                              </c:if>
                         </span>

                     </div>
                 </li>
               <%----%>
                     <%--<select  onchange="sendUser(this,'${task.id}','<c:url value="/project/sendUser.do"/>')" style="font-size: 10%">--%>
                         <%--<option value="null" <c:if test="${empty task.currentUser}">selected="selected"</c:if>>未指派</option>--%>
                         <%--<c:forEach var="member" items="${object.memberList}">--%>
                             <%--<option value="${member.id}" <c:if test="${member.id==task.currentUser.id}">selected="selected"</c:if>>${member.username}</option>--%>
                         <%--</c:forEach>--%>

                     <%--</select>--%>
                      <%----%>

             </c:forEach>
             <div id="${taskGroup.id}">
                <small> <a href="javascript:void (0);" onclick="addTask('${taskGroup.id}')">添加新任务</a></small>
             </div>

      </ul>

    </c:forEach>
</div>

<!-- content end -->
<hr/>


<!--模拟窗口 添加清单-->

<div class="am-modal am-modal-prompt" tabindex="-1" id="taskGroup-prompt">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">清单名称</div>
        <div class="am-modal-bd">
            <input type="text" name="title" class="am-modal-prompt-input">
        </div>
        <div class="am-modal-footer">
            <span class="am-modal-btn" data-am-modal-cancel>取消</span>
            <span class="am-modal-btn" data-am-modal-confirm>提交</span>
        </div>
    </div>
</div>
<!--模拟窗口 添加任务-->
<div style="display: none;" id="display_task">
    <li class="todo" id="">
        <div class="todo-action" style="display: none;position: absolute;left: 13%;background-color: #FFFFFF">
            <div style="padding-left: 10px;">
                <a href="javascript:void (0);"><img src="<c:url value="/scripts/image/taskEdit.png"/>" alt="编辑"/></a>
                <a href="javascript:void (0);"><img src="<c:url value="/scripts/image/taskDel.png"/>" alt="删除"/></a>
                <a href="javascript:void (0);"></a>
            </div>
        </div>
        <div class="todo-wrap" style="position:relative ;left: 10px;">
                         <span>
                             <textarea class="todo-content no-border "
                                       style="overflow: hidden; word-wrap: break-word; resize: none; height:30px;"></textarea>
                             <%--<a href="<c:url value="/basic/xm.do?qm=formTask&id=${task.id}&projectId=${object.id}"/> ">${task.title}</a>--%>
                         </span>
                         <span>
                              <select onchange="changeActivity(this)"
                                      style="font-size: 10%">
                                  <option value="null">请选择流程</option>
                                  <c:forEach var="flow" items="${flowList}">
                                      <option value="${flow.id}">${flow.title}</option>
                                  </c:forEach>
                              </select>
                         </span>

        </div>
        <div class="am-margin">
            <button type="button" onclick="saveTask(this)" class="am-btn am-btn-primary am-btn-xs">添加任务</button>
            <button type="button" onclick="cancelTask(this)" class="am-btn am-btn-primary am-btn-xs">取消</button>
        </div>
    </li>

</div>
<%--<div class="am-modal am-modal-prompt" tabindex="-1" id="task-prompt">--%>
    <%--<div class="am-modal-dialog">--%>
        <%--<div class="am-modal-hd">任务</div>--%>
        <%--<div class="am-modal-bd">--%>
            <%--<input type="text" name="taskTitle" class="am-modal-prompt-input">--%>
        <%--</div>--%>
        <%--<div class="am-modal-footer">--%>
            <%--<span class="am-modal-btn" data-am-modal-cancel>取消</span>--%>
            <%--<span class="am-modal-btn" data-am-modal-confirm>提交</span>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>
<script type="text/javascript">

    //初始化操作
    $(function(){
        $(".todo").hover(function(){
            $(this).find(".todo-action").css({"display":"block"});
        },function(){
            $(this).find(".todo-action").css({"display":"none"});
        });
    });
    //取消任务
    function cancelTask(obj){
        $(obj).parent().parent().remove();
        $(obj).parent().remove();
    }

    //to添加任务
    function addTask(taskGroupId) {
        $("#"+taskGroupId).before($("#display_task").html());
    }

    //save添加任务
    function saveTask(obj){
        var li = $(obj).parent().parent();
        var title = $(li).find("textarea").val();
        var flow = $("select",$(li)).val();
        var  taskGroupId = $(li).parent().attr("name");
        if(title==""){
            alert("请填写任务标题!");
        }else if(flow=="null"){
            alert("请选择流程!");
        }else{
            var f = confirm("流程选定后,将不允许修改!确定添加此任务吗?");
            if(f){
                alert("开始添加任务...");
                $.ajax({
                    type:"post",
                    url:"<c:url value="/project/addTask.do"/>",
                    data:{title:title,flowId:flow,taskGroupId:taskGroupId},
                    success:function(data){
                        var url = "<c:url value="/" />"+"/basic/xm.do?qm=formTask&id="+data+"&projectId="+'${object.id}';
                        var a = '<a href="'+url+'">'+title+'</a>';
                        $(li).find("textarea").parent().html(a);
                        $(li).find(".am-margin").remove();
                        $(li).attr("name",data);
                    }
                });
            }else{
                alert("再想想!");
            }

        }

    }

    //选择流程事件--->首节点成员
    function changeActivity(obj){
      var  flowId = $(obj).val();
        if(flowId=="null"){
            alert("请选择流程!");
        }else{
            $.ajax({
                type:"post",
                url:"<c:url value="/project/changeActivity.do"/>",
                data:{flowId:flowId},
                success:function(data) {
                    $.each(data,function(k,v){
                       if(k=="users"){
                          var select = '<select  onchange="changeMember()" style="font-size: 10%;margin-left: -259px">'+
                                       '<option value="null">'+'请选择成员'+'</option>';
                          for(var i=0;i< v.length;i++){

                               select += ' <option value="'+v[i].id+'">'+v[i].username+'</option>';
                           }

                           select += '</select>';

                           $(obj).parent().next().html(select);

                       }
                    });
                }
            });
        }
    }

    //分配人员
    function changeMember(obj){
        var  memberId = $(obj).val();
        var taskId = $(obj).parents("li").attr("name");
        if(memberId=="null"){
            alert("请选择成员!");
        }else{
            $.ajax({
                type:"post",
                url:"<c:url value="/project/changeMember.do"/>",
                data:{taskId:taskI,memberId:memberId},
                success:function(data) {
                    $.each(data,function(k,v){
                        if(k=="users"){
                            var select = '<select  onchange="" style="font-size: 10%;margin-left: -259px">'+
                                    '<option value="null">'+'请选择成员'+'</option>';
                            for(var i=0;i< v.length;i++){

                                select += ' <option value="'+v[i].id+'">'+v[i].username+'</option>';
                            }

                            select += '</select>';

                            $(obj).parent().next().html(select);

                        }
                    });
                }
            });
        }
    }
    //新加任务 的指派成员
    function addNewTaskHtml(taskId){
        var select =  ' <select style="font-size: 10%" onchange="sendUser(this,'+taskId+')">'+
                '   <option value="null">'+'未指派'+'</option>';
        <c:forEach items="${object.memberList}" var="member">
        select += '   <option value="${member.id}" >${member.username}</option>';
        </c:forEach>
        select += '</select>';
        return select;
    }



    //添加 清单
    function addTaskGroup(projectId){

        $('#taskGroup-prompt').modal({
            relatedTarget: this,
            onConfirm: function(e) {
                var title = $("input[name='title']").val();

                $.ajax({
                    type: "post",
                    url: "<c:url value="/project/addTaskGroup.do"/>",
                    data:{projectId:projectId,title:title},
                    success: function (data) {

                        var div = '<fieldset>'+
                                '<legend></legend>'+e.data+
                                '   <div id="'+data+'">'+
                                '    <small> <a href="javascript:void (0);" onclick="addTask(\''+data+'\')">'+
                                '     添加新任务'+
                                '     </a></small>'+
                                '   </div>'+
                                '</fieldset>';
                        $(".am-g").append(div);
                    }
                });
            },
            onCancel: function(e) {
                alert('不想说!');
            }
        });
    }

</script>
</body>
</html>
