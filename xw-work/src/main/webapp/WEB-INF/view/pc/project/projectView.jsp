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

    <script src="<c:url value="/scripts/react0.14.3/react.js"/> "></script>
    <script src="<c:url value="/scripts/react0.14.3/react-dom.js"/> "></script>
    <script src="<c:url value="/scripts/react0.14.3/react-dom-server.js"/> "></script>
    <script src="<c:url value="/scripts/react0.14.3/browser.min.js"/>"></script>
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
<div id="all">
</div>
<%--<div class="am-cf am-padding" id="xmmc">--%>
    <%--<div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">${object.title}</strong></div>--%>
<%--</div>--%>
<%--<hr/>--%>
<%--<div class="am-u-md-12" style="margin-top: 4%;">--%>
    <%--<div class="am-btn-toolbar" style="float: right;" id="qingdan">--%>
    <%--</div>--%>
<%--</div>--%>
<%--<div class="am-g" id="zzc">--%>
    <%--<c:forEach items="${object.taskGroupList}" var="taskGroup">--%>
        <%--<hr/>--%>
        <%--<ul name="${taskGroup.id}">--%>
            <%--<span>${taskGroup.title}</span>--%>
            <%--<c:forEach items="${taskGroup.taskList}" var="task">--%>
                <%--<li class="todo" name="${task.id}">--%>
                    <%--<div class="todo-action" style="display: none;position: absolute;left: 13%;background-color: #FFFFFF">--%>
                        <%--<div  style="padding-left: 30px;">--%>
                            <%--<a href="javascript:void (0);"><img src="<c:url value="/scripts/image/taskEdit.png"/>" alt="编辑"/></a>--%>
                            <%--<a href="javascript:void (0);"><img src="<c:url value="/scripts/image/taskDel.png"/>" alt="删除"/></a>--%>
                            <%--<a href="javascript:void (0);"></a>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%--<div class="todo-wrap" style="position:relative ;left: 10px;">--%>
                         <%--<span>--%>
                             <%--<input type="checkbox" onclick="completeTask(this,'${task.id}')" />--%>
                              <%--<a href="<c:url value="/basic/xm.do?qm=formTask&id=${task.id}&projectId=${object.id}"/> ">${task.title}</a>--%>
                         <%--</span>--%>
                         <%--<span>--%>
                              <%--<select  onchange="changeActivity(this)" style="font-size: 10%" disabled="disabled">--%>
                                  <%--<option value="null">请选择流程</option>--%>
                                  <%--<c:forEach var="flow" items="${flowList}">--%>
                                      <%--<option value="${flow.id}" <c:if test="${flow.id==task.flow.id}">selected="selected" </c:if>>${flow.title}</option>--%>
                                  <%--</c:forEach>--%>
                              <%--</select>--%>
                         <%--</span>--%>
                         <%--<span>--%>
                              <%--<c:if test="${not empty task.currentInstance}">--%>
                                  <%--　　　　　　　　　　　　　　　　<select  onchange="sendUser(this,'${task.id}','<c:url value="/project/sendUser.do"/>')" style="font-size: 10%;margin-left: -259px">--%>
                                  <%--　　　　　　　　　　　　　　　　  <option value="null">请选择成员</option>--%>
                                  <%--　　　　　　　　　　　　　　　　 <c:forEach var="user" items="${task.currentInstance.flowActivity.user}">--%>
                                  <%--　　　　　　　　　　　　　　  <option value="${user.id}" <c:if test="${user.id==task.currentUser.id}">selected="selected"</c:if>>${user.name}</option>--%>
                                  <%--　　　　　　　　　　　　　　　　</c:forEach>--%>
                                  <%--　　　　　　　　　　　　　　　　</select>--%>
                              <%--</c:if>--%>
                         <%--</span>--%>

                    <%--</div>--%>
                <%--</li>--%>
            <%--</c:forEach>--%>
            <%--<div id="${taskGroup.id}">--%>
                <%--<small> <a href="javascript:void (0);" onclick="addTask('${taskGroup.id}')">添加新任务</a></small>--%>
            <%--</div>--%>

        <%--</ul>--%>

    <%--</c:forEach>--%>
<%--</div>--%>

<%--<!-- content end -->--%>
<%--<hr/>--%>


<!--模拟窗口 添加清单-->

<div style="display: none;" id="display_taskGroup">
    <hr/>
    <ul class="" style="" name="">
                         <span>
                             <input class="todo-content no-border " placeholder="输入清单名称"
                                    style="overflow: hidden; word-wrap: break-word; resize: none; height:30px;"/>
                             <%--<a href="<c:url value="/basic/xm.do?qm=formTask&id=${task.id}&projectId=${object.id}"/> ">${task.title}</a>--%>
                         </span>


    </ul>
    <div class="am-margin">
        <button style="margin-left: 13px;" type="button" onclick="saveTaskGroup(this)" class="am-btn am-btn-primary am-btn-xs">保存，开始添加任务</button>
        <button type="button" onclick="cancelTaskGroup(this)" class="am-btn am-btn-primary am-btn-xs">取消</button>
    </div>
</div>



<!--模拟窗口 添加任务-->
<div style="display: none;" id="display_task">
    <li class="todo" name="">
        <div class="todo-action" style="display: none;position: absolute;left: 13%;background-color: #FFFFFF">
            <div style="padding-left: 10px;">
                <a href="javascript:void (0);"><img src="<c:url value="/scripts/image/taskEdit.png"/>" alt="编辑"/></a>
                <a href="javascript:void (0);"><img src="<c:url value="/scripts/image/taskDel.png"/>" alt="删除"/></a>
                <a href="javascript:void (0);"></a>
            </div>
        </div>
        <div class="todo-wrap" style="position:relative ;left: 10px;">
                         <span>
                             <input type="checkbox" onclick="" disabled="disabled"/>
                             <textarea class="todo-content no-border "
                                       style="overflow: hidden; word-wrap: break-word; resize: none; height:30px;"></textarea>
                             <%--<a href="<c:url value="/basic/xm.do?qm=formTask&id=${task.id}&projectId=${object.id}"/> ">${task.title}</a>--%>
                         </span>
                         <span>
                              <select name="flow" onchange="changeActivity(this)"
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
<script>

</script>
<!-- react测试-->
<script type="text/babel">

   var Add_user_select = React.createClass({
       handleChange:function(s){
          this.props.onSelect(s);

       },
       render:function(){
       var users =this.props.users;
         var style2 = {"display":this.props.dataStyle,"fontSize":"10%"};
         var user = users.map(function(v){
            return <option key={v.id} value={v.id}>{v.name}</option>
         });
         return (
           <select style={style2} defaultValue={this.props.currentUser} onChange={this.handleChange}>
            <option value="null">请选择成员</option>
            {user}
           </select>
         )
       }
   });

    var Add_select = React.createClass({

         getInitialState:function(){
           return {
             flowId:"null",
             users:[],
             style:"none",
             currentUser:"null",
             usersAmount:0
             }
         },
         handleChange:function(s){
              var v = s.target.value;
              this.setState({flowId:s.target.value});
              this.props.onSelect(s);
         },

         render:function(){
         var style1 = {"fontSize":"10%"};
                return (
                             <select name="flow" onChange={this.handleChange}
                                      style={style1} defaultValue={this.state.flowId}>
                                     <option value="null">请选择流程</option>
                                  <c:forEach var="flow" items="${flowList}">
                                     <option value="${flow.id}">${flow.title}</option>
                                  </c:forEach>
                              </select>

                         )
         }

    });

    var Add_li = React.createClass({

       getInitialState:function(){
        return {
                  title:"",
                  userId:"null",
                  flowId:"",
                  taskGroupId:"",
                  style:"none",
                  users:[],
                  styleA:"none",
                  styleTextarea:"inherit"
               }

       },
       onSelectUser:function(s){
            this.setState({userId:s.target.value});
       },
       handleClick:function(){
          $.ajax({
                    type:"post",
                    url:"<c:url value="/project/addTask.do"/>",
                    data:{"title":this.state.title,"userId":this.state.userId,"flowId":this.state.flowId,"taskGroupId":this.props.taskGroupId},
                    success:function(){

                     }.bind(this)
                    });
       },
       handleChange:function(event){
        this.setState({title:event.target.value});
       },
       onSelect:function(s){
          if(s.target.value=="null"){
           this.setState({flowId:s.target.value,style:"none"});
          }else{

           var userTemp;
           $.ajax({
                type:"post",
                url:"<c:url value="/project/changeActivity.do"/>",
                data:{flowId:s.target.value},
                success:function(data) {
                var obj = $.parseJSON(data);
                   this.setState({flowId:s.target.value,style:"inherit",users:obj,styleA:"inherit",styleTextarea:"none"});

                 }.bind(this)
                });


          }

       },
       cancelClick:function(){
         this.props.dataStyle = 'none';
       },
       componentDidMount:function(){

       },
       render:function(){
       var style1 = {"position":"relative" ,"left": "10px"};
       var style2 = {"overflow": "hidden", "wordWrap": "break-word", "resize": "none", "height":"30px"};
       var style3 = {"display":this.props.dataStyle};
       var styleA = {"display":this.state.styleA};
       var styleTextarea = {"display":this.state.styleTextarea};
          return (
           <li className="todo" name="" style={style3}>
              <div className="todo-wrap" style={style1}>
                         <span>
                             <input type="checkbox" onclick="" disabled="disabled"/>
                             <a href="javascript:void(0)" style={styleA}>{this.state.title}</a>
                             <span style={styleTextarea}>
                             <textarea className="todo-content no-border " onChange={this.handleChange}
                                       style={style2} defaultValue={this.state.title}></textarea>
                              </span>
                         </span>
                         <span>
                            <Add_select onSelect={this.onSelect} />
                         </span>
                         <span>
                            <Add_user_select dataStyle={this.state.style} currentUser="null" taskId="null" onSelect={this.onSelectUser} users={this.state.users}/>
                         </span>


              </div>
              <div className="am-margin" style={styleTextarea}>
                   <a  onClick={this.handleClick} className="am-btn am-btn-primary am-btn-xs">确认添加</a>
              </div>
           </li>
          )
         }
    });


    var Add_ul = React.createClass({

      getInitialState:function(){
         return {
            style:''
            }
      },

      cancelClick:function(){
          this.setState({
            style:this.state.style=='none'?'block':'none'
          });
      },
       componentDidMount:function(){

       },
       render:function(){
          var style1= {
            "overflow":"hidden",
            "wordWrap":"break-word",
            "resize":"none",
            "height":"30px"
          };
          var style2 = {
            "marginLeft":"13px"
          };
          var style3 = {"display":this.props.dataStyle};
          return (

              <ul className="" style={style3} name="">
                         <span>
                             <input className="todo-content no-border " placeholder="输入清单名称"
                                    style={style1}/>
                         </span>
                          <div className="am-margin">
                             <a style={style2}   className="am-btn am-btn-primary am-btn-xs">保存，开始添加任务</a>
                          </div>
               </ul>


          )
       }
    });

    var A_addTask = React.createClass({

         getInitialState:function(){

           return {

             style:'none',
             text:'添加任务'

           };
         },

         handleClick:function(){
            this.setState({style:this.state.style=='none'?'block':'none',text:this.state.text=='添加任务'?'取消':'添加任务'});
         },
         render:function(){
           return (
              <div>
               <Add_li taskGroupId={this.props.taskGroupId} dataStyle={this.state.style} />
              <a onClick={this.handleClick} href={this.props.href} className={this.props.className}>
                {this.state.text}
              </a>
              </div>
              )
         }
    });

    var TaskGroup = React.createClass({
        getInitialState:function(){
          return {
              projectId:'${object.id}',
              le:'${fn:length(object.memberList)}',
              style:'none',
              text:'添加清单'
          };
        },
        handleClick:function(){
            this.setState({style:this.state.style=='none'?'block':'none',text:this.state.text=='添加清单'?'取消':'添加清单'});
        },
        render:function(){
             var style1 = {
              "marginTop":"4%"
           };
          var style2 = {
             "float":"right"
           };
           return (
           <div>
             <div className="am-u-md-12" style={style1}>
                 <div className="am-btn-toolbar" style={style2}>
                   <div className="am-btn-group am-btn-group-xs">
                     <a href="javascript:void (0);" onClick={this.handleClick} disabled={this.state.disabled} projectId="{this.state.projectId}" className="am-btn am-btn-default">{this.state.text}</a>
                     <a href="javascript:void (0);" className="am-btn am-btn-default">成员({this.state.le})</a>
                   </div>
                 </div>
              </div>
              <Div3 dataStyle={this.state.style}/>
           </div>
           );
        }
    });



    var P_li = React.createClass({
       render:function(){
       return <li className="todo" name={this.props.key}>

              </li>
       }
    });
    var Div1 = React.createClass({

       render:function(){
         return (
           <div className="am-cf am-padding" >
               <div className="am-fl am-cf"><strong className="am-text-primary am-text-lg">{this.props.title}</strong></div>
            </div>
         )
       }
    });
    var Div2 = React.createClass({

       render:function(){
          var style1 = {
              "marginTop":"4%"
           };
          var style2 = {
             "float":"right"
           };
         return (
            <div>
             <div className="am-u-md-12" style={style1}>
                 <div className="am-btn-toolbar" style={style2}>
                   <TaskGroup />
                 </div>
             </div>
             <Div3 />
            </div>
         )
       }
    });


    var Div3 = React.createClass({

       getInitialState:function(){

          return {flag:'0'}
       },
       render:function(){
           var style1 = {"fontSize":"10%"};
             return    (
              <div>
                 <c:forEach items="${object.taskGroupList}" var="taskGroup">
                   <ul name="${taskGroup.id}">
                         ${taskGroup.title}
                         <c:forEach var="task" items="${taskGroup.taskList}">
                            <li className="todo" name="${task.id}">
                                  <a href="javascript:void(0)">${task.title}</a>
                              <c:if test="${not empty task.flow}">
                                  <select defaultValue="${task.flow.id}" disabled="disabled">
                                         <option value="${task.flow.id}">${task.flow.title}</option>
                                  </select>
                                    <select style={style1} defaultValue="${task.currentUser.id}">
                                       <option value="null">请选择成员</option>
                                     <c:forEach items="${task.currentInstance.flowActivity.user}" var="user">
                                        <option value="${user.id}">${user.name}</option>
                                     </c:forEach>
                                    </select>
                              </c:if>
                            </li>
                         </c:forEach>
                         <div id="${taskGroup.id}">
                            <small>
                               <A_addTask href="javascript:void(0)" taskGroupId="${taskGroup.id}" className="" text="添加任务" />
                            </small>
                        </div>
                      </ul>
                 </c:forEach>
                      <Add_ul dataStyle={this.props.dataStyle} />
                 </div>
                 )
         }
    });


    ReactDOM.render(
            (
              <div>
               <Div1 title="${object.title}" />
               <hr/>
               <TaskGroup />

             </div>
            )
            ,
           document.getElementById("all")
  
    );





</script>

<script type="text/javascript">

    //初始化操作
    $(function(){
        $(".todo").hover(function(){
            $(this).find(".todo-action").css({"display":"block"});
        },function(){
            $(this).find(".todo-action").css({"display":"none"});
        });
    });

    //--------------------------------任务---------------------------------------------------//
    //取消任务
    function cancelTask(obj){

        $(obj).parents("ul").find("div:last").show();
        $(obj).parent().parent().remove();
        $(obj).parent().remove();

    }

    //to添加任务
    function addTask(taskGroupId) {
        $("#"+taskGroupId).before($("#display_task").html());
        $("#"+taskGroupId).hide();
    }

    //save添加任务
    function saveTask(obj){
        var li = $(obj).parent().parent();
        var title = $(li).find("textarea").val();
        var flow = $("select[name='flow']",$(li)).val();
        var userId = $("select[name='user']",$(li)).val();
        var  taskGroupId = $(li).parent().attr("name");
        if(title==""){
            alert("请填写任务标题!");
        }else if(flow=="null"){
            alert("请选择流程!");
        }else{
            var f = confirm("流程选定后,将不允许修改!确定添加此任务吗?");
            if(f){
                $.ajax({
                    type:"post",
                    url:"<c:url value="/project/addTask.do"/>",
                    data:{title:title,flowId:flow,taskGroupId:taskGroupId,userId:userId},
                    success:function(data){
                        data = data.substring(1,data.length-1);
                        var url = "<c:url value="/" />"+"basic/xm.do?qm=formTask&id="+data+"&projectId="+'${object.id}';
                        var a = '<a href='+url+'>'+title+'</a>';
                        $(li).find("textarea").parent().html(a);
                        $(li).find("select[name='flow']").attr("disabled","disabled");
                        $(li).find("select[name='user']").attr("onchange","sendUser(this,"+data+",'<c:url value="/project/sendUser.do"/>')");
                        $(li).find("input[name='checkbox']").attr("onclick","completeTask(this,'"+data+"')");
                        $(li).find("input[name='checkbox']").removeAttr("disabled");
                        $(li).find(".am-margin").remove();
                        $(li).attr("name",data);
                        $("#"+taskGroupId).show();
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
            $(obj).parent().next().remove();
        }else{
            $.ajax({
                type:"post",
                url:"<c:url value="/project/changeActivity.do"/>",
                data:{flowId:flowId},
                success:function(data) {
                    $.each($.parseJSON(data),function(key,value) {
                        if (key == "users") {
                            var select = '<span>'+
                                    '<select name="user" onchange="" style="font-size: 10%;">' +
                                    '<option value="null">' + '请选择成员' + '</option>';

                            $.each(value, function (k, v) {
                                select += ' <option value="' + v.id + '">' + v.name + '</option>';
                            });
                            select += '</select>'+
                                    '</span>';
                            $(obj).parent().after(select);

                        }

                    });
                }
            });
        }
    }



    //测试 完成任务
    function completeTask(obj,taskId){
        $.ajax({
            type:"post",
            url:"<c:url value="/task/changeTaskStatus.do"/>",
            data:{taskId:taskId},
            success:function(data) {
                $.each($.parseJSON(data), function (key, value) {
                    if (key == "users") {
                        var select = '<span>' +
                                '<select name="user" onchange="" style="font-size: 10%;">' +
                                '<option value="null">' + '请选择成员' + '</option>';

                        $.each(value, function (k, v) {
                            select += ' <option value="' + v.id + '">' + v.name + '</option>';
                        });
                        select += '</select>' +
                                '</span>';
                        $(obj).parent().next().next().html(select);

                    }

                });
            }
        });
    }
    <%--//分配人员--%>
    <%--function changeMember(obj){--%>
    <%--var  memberId = $(obj).val();--%>
    <%--var taskId = $(obj).parents("li").attr("name");--%>
    <%--if(memberId=="null"){--%>
    <%--alert("请选择成员!");--%>
    <%--}else{--%>
    <%--$.ajax({--%>
    <%--type:"post",--%>
    <%--url:"<c:url value="/project/changeMember.do"/>",--%>
    <%--data:{taskId:taskI,memberId:memberId},--%>
    <%--success:function(data) {--%>
    <%--$.each(data,function(k,v){--%>
    <%--if(k=="users"){--%>
    <%--var select = '<select  onchange="" style="font-size: 10%;margin-left: -259px">'+--%>
    <%--'<option value="null">'+'请选择成员'+'</option>';--%>
    <%--for(var i=0;i< v.length;i++){--%>

    <%--select += ' <option value="'+v[i].id+'">'+v[i].username+'</option>';--%>
    <%--}--%>

    <%--select += '</select>';--%>

    <%--$(obj).parent().next().html(select);--%>

    <%--}--%>
    <%--});--%>
    <%--}--%>
    <%--});--%>
    <%--}--%>
    <%--}--%>
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


    ///------------------------------------清单---------------------------------------------------------------////
    //to添加 清单
    function addTaskGroup(projectId){
        var f = true;
        $(".am-g ul").each(function(){

            if($(this).attr("name")==""){
                $(this).find("input").focus();
                f = false;
                return false;
            }
        });
        if(f){
            $(".am-g").append($("#display_taskGroup").html());
        }


    }
    //取消清单
    function cancelTaskGroup(obj){
        $(obj).parent().prev().prev().remove();
        $(obj).parent().prev().remove();
        $(obj).parent().remove();

    }
    //保存清单
    function saveTaskGroup(obj){
        var projectId = '${object.id}';
        var title = $(obj).parent().prev().find("input").val();
        if(title==""){
            alert("请填写清单名单!");
        }else{
            $.ajax({
                type: "post",
                url: "<c:url value="/project/addTaskGroup.do"/>",
                data:{projectId:projectId,title:title},
                success: function (data) {
                    data = data.substring(1,data.length-1);
                    var ul = $(obj).parent().prev("ul");
                    $(ul).attr("name",data);
                    $(ul).find("span").text(title);
                    $(obj).parent().remove();
                    var div = '   <div id="'+data+'">'+
                            '    <small> <a href="javascript:void (0);" onclick="addTask(\''+data+'\')">'+
                            '     添加新任务'+
                            '     </a></small>'+
                            '   </div>';
                    $(ul).append(div);
                }
            });

        }

    }
</script>
</body>
</html>
