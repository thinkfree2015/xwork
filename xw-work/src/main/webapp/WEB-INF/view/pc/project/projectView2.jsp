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
    <script src="<c:url value="/scripts/PCDSelect.js" />"></script>
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
                     <a href="<c:url value="/basic/xm.do?qm=formTask&id${task.id}"/> ">${task.content}</a>
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


<!--模拟窗口-->
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

<script type="text/javascript">
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
    function addTask(taskGroupId){
           alert("还不能添加任务!");
    }
</script>
</body>
</html>
