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
         <fieldset>
             <legend></legend>
                 ${taskGroup.title}
             <c:forEach items="${taskGroup.taskList}" var="task">
                 <div>
                     <input type="checkbox">
                     <div class="am-dropdown" data-am-dropdown>
                     <a  href="javascript:void (0);" class="am-dropdown-toggle" data-am-dropdown-toggle><img src="<c:url value="/scripts/image/taskDown2.png"/>" alt="编辑"/>
                         <ul class="am-dropdown-content">
                             <li><a href="#"><img src="<c:url value="/scripts/image/taskEdit.png"/>" alt="编辑"/> 编辑</a></li>
                             <li><a href="#"><img src="<c:url value="/scripts/image/taskDel.png"/>" alt="删除"/> 删除</a></li>
                         </ul>
                     </a>
                     </div>
                     <a href="<c:url value="/basic/xm.do?qm=formTask&id=${task.id}&projectId=${object.id}"/> ">${task.title}</a>

                     <select  onchange="sendUser(this,'${task.id}','<c:url value="/project/sendUser.do"/>')" style="font-size: 10%">
                         <option value="null" <c:if test="${empty task.currentUser}">selected="selected"</c:if>>未指派</option>
                         <c:forEach var="member" items="${object.memberList}">
                             <option value="${member.id}" <c:if test="${member.id==task.currentUser.id}">selected="selected"</c:if>>${member.username}</option>
                         </c:forEach>

                     </select>
                        <%--<span  id="span${task.id}">--%>
                             <%--<img src="<c:url value="/scripts/image/taskEdit.png"/>" alt="编辑"/>--%>
                             <%--<img src="<c:url value="/scripts/image/taskDel.png"/>" alt="删除"/>--%>

                         <%--</span>--%>
                 </div>

             </c:forEach>
             <div id="${taskGroup.id}">
                <small> <a href="javascript:void (0);" onclick="addTask('${taskGroup.id}')">添加新任务</a></small>
             </div>
         </fieldset>

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
<div class="am-modal am-modal-prompt" tabindex="-1" id="task-prompt">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">任务</div>
        <div class="am-modal-bd">
            <input type="text" name="taskTitle" class="am-modal-prompt-input">
        </div>
        <div class="am-modal-footer">
            <span class="am-modal-btn" data-am-modal-cancel>取消</span>
            <span class="am-modal-btn" data-am-modal-confirm>提交</span>
        </div>
    </div>
</div>
<script type="text/javascript">

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
    //添加任务
    function addTask(taskGroupId){
        $('#task-prompt').modal({
            relatedTarget: this,
            onConfirm: function(e) {
                var title = $("input[name='taskTitle']").val();

                $.ajax({
                    type: "post",
                    url: "<c:url value="/project/addTask.do"/>",
                    data:{taskGroupId:taskGroupId,title:title},
                    success: function (data) {

                        var div =    '<div>'+
                                ' <input type="checkbox">'+
                                '        <div class="am-dropdown" data-am-dropdown>'+
                                '         <a  href="javascript:void (0);" class="am-dropdown-toggle" data-am-dropdown-toggle><img src="<c:url value="/scripts/image/taskDown2.png"/>" alt="编辑"/>'+
                                '           <ul class="am-dropdown-content">'+
                                '             <li><a href="#"><img src="<c:url value="/scripts/image/taskEdit.png"/>" alt="编辑"/> 编辑</a></li>'+
                                '             <li><a href="#"><img src="<c:url value="/scripts/image/taskDel.png"/>" alt="删除"/> 删除</a></li>'+
                                '           </ul>'+
                                '         </a>'+
                                '        </div>'+
                                '        <a href="<c:url value="/basic/xm.do?qm=formTask&id="/>'+data+' " >'+title+'</a>';
                        div += addNewTaskHtml(data);
                        div +=    '</div>';
                        $("#"+taskGroupId).prepend(div);
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
