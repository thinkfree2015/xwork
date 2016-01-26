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


    <script src="<c:url value="/scripts/sockjs-0.3.min.js"/>"></script>
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
<script>

</script>
<!-- react测试-->
<script type="text/babel">
<%--推送消息--%>
    var ws2 = null;
 <%--通知页面改变--%>
    var ws1 = null;
    var url = null;
    function connect() {
        if ('WebSocket' in window) {
            ws2 = new WebSocket("ws://192.168.1.80:8001/websck");
            ws1 = new WebSocket("ws://192.168.1.80:8001/websck");
        } else if ('MozWebSocket' in window) {
            ws2 = new MozWebSocket("ws://websck");
            ws1 = new MozWebSocket("ws://websck");
        } else {
            ws2 = new SockJS("http://192.168.1.80:8001/sockjs/websck");
            ws1 = new SockJS("http://192.168.1.80:8001/sockjs/websck");
        }
        ws2.onopen = function () {
        };
        ws1.onopen = function () {
        };

        ws2.onmessage = function (event) {
         if ((event.data).indexOf("Hint") == 0){
              alert(event.data);
            }else{
               var obj = $.parseJSON(event.data);
               if(obj.type=="1" && obj.id!="[0]"){
                  alert(obj.content);
               }
            }
        };
        ws2.onclose = function (event) {
            console.log("关闭连接")
        }
        ws1.onclose = function (event) {
            console.log("关闭连接")
        }
    }
    function disconnect() {
        if (ws2 != null) {
            ws2.close();
            ws2 = null;
        }
        if (ws1 != null) {
            ws1.close();
            ws1 = null;
        }
    }
    $(document).ready(function () {
        connect();
    });
    function forwardUrl(userId,username,type){
      var users = "";
      if(userId.length!=0){
       for(var i = 0 ; i<userId.length;i++)
       users += i==userId.length-1?userId[i]:userId[i]+",";
      }
        var message = '{"receiver":"'+username+'","content":"你有一条新消息","id":"['+users+']","path":"projectView","type":"'+type+'"}';
        echo(message,type);
    }
    function echo(message,type) {
    if(type=="1"){
        if (ws2 != null) {
            <%--alert('Sent: ' + message);--%>

                  ws2.send(message);

        } else {
            alert('connection not established, please connect.');
        }
      }
      if(type=="3"){
        if (ws1 != null) {
            <%--alert('Sent: ' + message);--%>
            ws1.send(message);
         } else {
            alert('connection not established, please connect.');
         }
      }
    }
<%--任务操作 --%>
   var Task_tool = React.createClass({
      handleEdit:function(){
          this.props.handleEdit();
      },
      handleRemove:function(){
          this.props.handleRemove();
      },
      handleCompleted:function(){
         this.props.handleCompleted();
      },
      render:function(){
        var style1 = {"marginRight":"2px"};
        var style2 = {"display":this.props.dataStyle,"position":"absolute","zIndex":"99","left":"-55px","top":"3px"};
        return (
          <span style={style2}>
              <a style={style1} onClick={this.handleEdit} href="javascript:void (0);"><img src="<c:url value="/scripts/image/taskEdit.png"/>" alt="编辑"/></a>
              <a style={style1} onClick={this.handleRemove} href="javascript:void (0);"><img src="<c:url value="/scripts/image/taskDel.png"/>" alt="删除"/></a>
              <a style={style1} onClick={this.handleCompleted} href="javascript:void (0);"><img src="<c:url value="/scripts/image/completed1.png"/>" alt="已完成"/></a>
          </span>
        )
      }
   });

<%--父组件 项目视图 --%>
 var ProjectView = React.createClass({
       getInitialState:function(){
         return {
            title:"",
            status:"0",
            memberLength:0,
            isAddTaskGroup:"none"
         };
       },
       toAddTaskGroup:function(){
           if(this.state.isAddTaskGroup=="none"){
              this.setState({isAddTaskGroup:"block"});
           }
       },
       saveTaskGroup:function(){
              this.setState({isAddTaskGroup:"none"});
       },
       loadCommentsFromServer:function(){
          $.ajax({
                type:"post",
                url:"<c:url value="/project/getProject.do"/>",
                data:{id:${id}},
                dataType:"json",
                success:function(data) {
                   this.setState({title:data.title,memberLength:data.memberList.length,id:data.id});
                 }.bind(this)
                });
       },
       componentWillMount:function(){
                this.loadCommentsFromServer();
                this.setState({status:"1"});

       },
       render:function(){
         return (
               <div>
                 <ProjectView_title title={this.state.title} />
                 <ProjectView_tool toAddTaskGroup={this.toAddTaskGroup} memberLength={this.state.memberLength} />
                 <ProjectView_taskGroup dataStyle={this.state.isAddTaskGroup} saveOrCancelTaskGroup={this.saveTaskGroup} />
               </div>
           )
       }
    });
<%-- 标题组件 --%>
    var ProjectView_title = React.createClass({

       render:function(){
         return (
            <div className="am-cf am-padding" >
               <div className="am-fl am-cf"><strong className="am-text-primary am-text-lg">{this.props.title}</strong></div>
            </div>
          )
       }
    });

<%-- 工具组件 --%>
    var ProjectView_tool = React.createClass({
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
                     <a href="javascript:void (0);" onClick={this.props.toAddTaskGroup}   className="am-btn am-btn-default">添加清单</a>
                     <a href="javascript:void (0);" className="am-btn am-btn-default">成员({this.props.memberLength})</a>
                   </div>
                 </div>
              </div>
           </div>
           )
         }
    });

<%-- 清单组件 --%>
    var ProjectView_taskGroup = React.createClass({
        getInitialState:function(){
           return {
              ul:[],
           }
        },
        loadCommentsFromServer:function(){
          $.ajax({
                type:"post",
                url:"<c:url value="/project/getTaskGroup.do"/>",
                data:{projectId:${id}},
                dataType:"json",
                success:function(data) {
                   this.setState({ul:data});
                 }.bind(this)
                });
       },
       saveTaskGroup:function(data){
               this.setState({ul:data});
               this.props.saveOrCancelTaskGroup(data);
       },
       componentWillMount:function(){
                this.loadCommentsFromServer();
                  ws1.onmessage=function(event){
                      <%--alert(event.data);--%>
                      var that = this;
                   setTimeout(function(){
                      that.setState({ul:[]});
                      that.loadCommentsFromServer();
                      },5000);
                   }.bind(this)
       },
        render:function(){
          var listStyle= {
            "paddingLeft":"5em",
          };
           var createUL = this.state.ul.map(function(taskGroup){
               return <ul key={taskGroup.id} style={listStyle}>
                          {taskGroup.title}
                          <Display_li taskGroupId={taskGroup.id} />
                      </ul>
            });
            var style1 = {"fontSize":"10%"};
             return    (
              <div>
                         {createUL}
                        <Add_ul dataStyle={this.props.dataStyle} cancelTaskGroup={this.props.saveOrCancelTaskGroup} saveTaskGroup={this.saveTaskGroup}/>
                 </div>
                )
        }
    });

<%-- 添加清单组件 --%>
     var Add_ul = React.createClass({

      getInitialState:function(){
         return {
            style:"",
            value:""
            }
      },
      handleChange:function(s){

        this.setState({value:s.target.value});
      },
      saveTaskGroup:function(){
           $.ajax({
                type: "post",
                url: "<c:url value="/project/addTaskGroup.do"/>",
                data:{projectId:${id},title:this.state.value},
                dataType:"json",
                success: function (data) {
                   this.setState({value:""});
                   this.props.saveTaskGroup(data);
                }.bind(this)
            });
      },
      cancelClick:function(){
        this.setState({value:""});
        this.props.cancelTaskGroup();
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
                             <input className="todo-content no-border " placeholder="输入清单名称" value={this.state.value} onChange={this.handleChange}
                                    style={style1}/>
                         </span>
                          <div className="am-margin">
                             <a style={style2}  onClick={this.saveTaskGroup} className="am-btn am-btn-primary am-btn-xs">保存，开始添加任务</a>
                             <a style={style2}  onClick={this.cancelClick} className="am-btn am-btn-primary am-btn-xs">取消</a>
                          </div>
               </ul>


          )
       }
    });
<%--任务li --%>
    var Li = React.createClass({
      getInitialState:function(){
         return {
           style:"none",
           value:"",
           editStyle:"none",
           removeStyle:"block",
           users:[],
           userId:"null"
         }
      },
       handleEdit:function(){
           this.setState({editStyle:"initial","style":"none"});
       },
       onMouseOver:function(){
         if(this.state.editStyle!="initial"){
            this.setState({style:"initial"});
         }
       },
       onMouseOut:function(){
       if(this.state.editStyle!="initial"){
        this.setState({style:"none"});
        }
       },
       handleCompleted:function(){
          var taskId = this.props.task.id;
           var con= confirm("完成后任务将会分配给下一个节点,确认完成任务吗？");
           if(con){
               $.ajax({
                type:"post",
                url:"<c:url value="/task/changeTaskStatus.do"/>",
                data:{taskId:taskId,status:"4"},
                dataType:"json",
                success:function(data) {
                var userId = [];
                userId.push(data[0].id);
                    forwardUrl(userId,"","1")
                    forwardUrl(userId,"","3")
                   this.setState({style:"none",editStyle:"none",users:data,userId:data[0].id=="0"?"null":data[0].id});
                 }.bind(this)
                });
              }
       },
       handleClick:function(){
             var value = this.state.value;
             var taskId = this.props.task.id;
               $.ajax({
                type:"post",
                url:"<c:url value="/task/editTask.do"/>",
                data:{taskId:taskId,title:value},
                dataType:"json",
                success:function(data) {
                   this.setState({style:"none",editStyle:"none"});
                 }.bind(this)
                });
       },
       handleChange:function(s){
          this.setState({value:s.target.value});
       },
       handleCancel:function(){
          this.setState({style:"none",editStyle:"none",value:this.props.task.title});
       },
       handleRemove:function(){
           var taskId = this.props.task.id;
           var con= confirm("确认删除？");
           if(con){
            $.ajax({
                type:"post",
                url:"<c:url value="/task/removeTask.do"/>",
                data:{taskId:taskId},
                dataType:"json",
                success:function(data) {
                    this.setState({removeStyle:"none",style:"none",editStyle:"initial"});
                 }.bind(this)
                });
            }

       },
          getCurrentUser:function(data){
            this.setState({userId:data});

          },
          updateView:function(data){

         },
          defaultCurrentUser:function(e){

          $.ajax({
                type:"post",
                url:"<c:url value="/project/getCurrentUser.do"/>",
                data:{id:this.props.task.id},
                dataType:"json",
                success:function(data) {
                      this.setState({userId:data});
                 }.bind(this)
                });
       },
        loadCommentsFromServer:function(){
          $.ajax({
                type:"post",
                url:"<c:url value="/project/getCurrentInstanceUsers.do"/>",
                data:{id:this.props.task.id},
                dataType:"json",
                success:function(data) {
                   this.setState({users:data});
                 }.bind(this)
                });
       },
       componentWillMount:function(){

                this.setState({value:this.props.task.title});
                this.loadCommentsFromServer();
                this.defaultCurrentUser();


       },

      render:function(){
          var  style3 = {"marginTop":"2px","marginRight":"2px"};
          var  editStyle = {"display":this.state.editStyle};
          var  editStyle2 = {"display":this.state.editStyle=="none"?"initial":"none"};
          var  removeStyle = {"display":this.state.removeStyle,"position":"relative"};
        return (
                      <li onMouseOver={this.onMouseOver}  onMouseOut={this.onMouseOut} style={removeStyle}>
                         <Task_tool dataStyle={this.state.style} handleEdit={this.handleEdit} handleRemove={this.handleRemove} handleCompleted={this.handleCompleted}/>
                         <span style={editStyle2}>
                            <a href={this.props.a} >{this.state.value}</a>
                         </span>
                         <span style={editStyle}>
                            <textarea className="todo-content no-border " onChange={this.handleChange}  value={this.state.value}></textarea>
                            <a href="javascript:void (0);" onClick={this.handleClick} className="am-btn am-btn-primary am-btn-xs" style={style3}>保存</a>
                            <a href="javascript:void (0);" onClick={this.handleCancel} className="am-btn am-btn-primary am-btn-xs" style={style3}>取消</a>
                         </span>
                         <Display_li_select_user userId={this.state.userId} getCurrentUser={this.getCurrentUser}  users={this.state.users} taskId={this.props.task.id} />
                         <Display_li_select_flow  taskId={this.props.task.id} />
                      </li>

        )
      }
    });
<%--展示任务组件 --%>
  var Display_li = React.createClass({

       getInitialState:function(){

          return {li:[],status:"0"}
       },
       loadCommentsFromServer:function(){
          $.ajax({
                type:"post",
                url:"<c:url value="/project/getTask.do"/>",
                data:{id:this.props.taskGroupId},
                dataType:"json",
                success:function(data) {
                   this.setState({li:data});
                 }.bind(this)
                });
       },
       addLi:function(data){
              forwardUrl("",data[data.length-1].username,"1");
              forwardUrl("",data[data.length-1].username,"3");
            this.setState({status:"0",li:data});


       },
        componentWillMount:function(){
            if(this.state.status=="0"){
                this.loadCommentsFromServer();
                this.setState({status:"1"});
             }
       },

       componentDidMount:function(){

       },
       render:function(){

            var createLI = this.state.li.map(function(task){
               var a = "<c:url value="/basic/xm.do?qm=formTask&id=" />"+task.id+"&projectId=${id}";
               return <Li key={task.id} task={task} a={a}/>
            });
            var style1 = {"fontSize":"10%"};
             return    (
                 <div>
                         {createLI}
                         <div id="">
                            <small>
                               <A_addTask href="javascript:void(0)" taskGroupId={this.props.taskGroupId}  className="" text="添加任务" li={this.addLi} />
                            </small>
                        </div>
                 </div>
                 )
         }
    });
    <%--展示任务流程组件 --%>
   var Display_li_select_flow = React.createClass({
       getInitialState:function(){
         return {
           status:"0",
           title:""
         }
       },

      loadCommentsFromServer:function(){
          $.ajax({
                type:"post",
                url:"<c:url value="/project/getFlow.do"/>",
                data:{id:this.props.taskId},
                dataType:"json",
                success:function(data) {
                   this.setState({title:data.title});
                 }.bind(this)
                });
       },
       componentWillMount:function(){
            if(this.state.status=="0"){
                this.loadCommentsFromServer();
                this.setState({status:"1"});
             }
       },
       render:function(){
         return (
            <span>
               <small>{this.state.title}</small>
            </span>
         )
       }

   });
     <%--展示任务流程人员组件 --%>
   var Display_li_select_user = React.createClass({
       getInitialState:function(){
       return {
          status:"0",
          value:"null",
          users:[]
         }
       },

       onmessage:function(value){
        this.props.getCurrentUser(value);
       },
       handleChange:function(s){
           var value = s.target.value;
           $.ajax({
                type:"post",
                url:"<c:url value="/project/sendUser.do"/>",
                data:{taskId:this.props.taskId,userId:value},
                dataType:"json",
                success:function(data) {
                   this.props.getCurrentUser(value);
                   var userId = [];
                   userId.push(value);
                   forwardUrl(userId,"","1");
                   forwardUrl(userId,"","3");
                   <%--alert(ReactDOM.findDOMNode(this.refs.SelectUser).setAttribute("value",value));--%>
                 }.bind(this)
                });
       },

       render:function(){

         var selectUser = this.props.users.map(function(user){
              return <option key={user.id} value={user.id}>{user.name}</option>
         });
         var style = {fontSize:"10px"};
         var userStyle={"display":this.props.userId=="null"?"none":"initial"}
         return (

            <span ref="SelectUser" style={userStyle}>
                 <select value={this.props.userId} onChange={this.handleChange} style={style}>
                     {selectUser}
                 </select>
            </span>

         )

       }
   });
     <%--添加任务组件--%>
   var A_addTask = React.createClass({

         getInitialState:function(){

           return {

             style:'none',
             text:'添加任务',
           };
         },
         li:function(data){
           this.setState({style:"none",text:"添加任务"});
           this.props.li(data);
          },
         handleClick:function(){
            this.setState({style:this.state.style=='none'?'block':'none',text:this.state.text=='添加任务'?'取消':'添加任务'});
         },


         render:function(){
           return (
              <div>
               <Add_li  dataStyle={this.state.style} taskGroupId={this.props.taskGroupId} li={this.li} />
               <a onClick={this.handleClick} href="javascript:void(0)">
                {this.state.text}
              </a>
              </div>
              )
         }
    });
<%--添加任务子组件 --%>
   var Add_li = React.createClass({

       getInitialState:function(){
        return {
                  title:"",
                  userId:"null",
                  flowId:"null",
                  taskGroupId:"",
                  style:"none",
                  users:[],
                  isAdd:"true"
               }

       },

       handleClick:function(){
       if(this.state.title==""){
            alert("请填写任务标题!");
        }else if(this.state.flowId=="null"){
            alert("请选择流程!");
        }else{
            var f = confirm("流程选定后,流程将不允许修改!确定添加此任务吗?");
            if(f){
              $.ajax({
                    type:"post",
                    url:"<c:url value="/project/addTask.do"/>",
                    data:{"title":this.state.title,"userId":this.state.userId,"flowId":this.state.flowId,"taskGroupId":this.props.taskGroupId},
                    dataType:"json",
                    success:function(data){
                       this.setState({title:"",userId:"null",flowId:"null"});
                       this.props.li(data);
                     }.bind(this)
                });
               }
           }
       },
       handleChange:function(event){
        this.setState({title:event.target.value});
       },
       handleUserChange:function(event){
        this.setState({userId:event.target.value});
       },

       handleFlowChange:function(s){
          if(s.target.value=="null"){
           this.setState({flowId:s.target.value,style:"none",userId:"null"});
          }else{
            this.setState({flowId:s.target.value});
           var userTemp;
           $.ajax({
                type:"post",
                url:"<c:url value="/project/changeActivity.do"/>",
                data:{flowId:s.target.value},
                success:function(data) {
                var obj = $.parseJSON(data);
                   this.setState({style:"inherit",users:obj,"userId":obj[0].id});

                 }.bind(this)
                });


          }

       },
       componentWillMount:function(){
            if(this.props.dataStyle=="none"){
                this.setState({title:""});
             }
       },

       render:function(){
       var style1 = {"position":"relative" ,"left": "10px"};
       var style2 = {"overflow": "hidden", "wordWrap": "break-word", "resize": "none", "height":"30px"};
       var style3 = {"display":this.props.dataStyle};
       var style4 = {"fontSize":"10%"};
       var style5 = {"display":this.state.style};
        var user = this.state.users.map(function(v){
            return <option key={v.id} value={v.id}>{v.name}</option>
         });
          return (
           <li className="todo" name="" style={style3}>
              <div className="todo-wrap" style={style1}>
                         <span>
                             <input type="checkbox" onclick="" disabled="disabled"/>
                             <span >
                             <textarea className="todo-content no-border " onChange={this.handleChange}
                                       style={style2} value={this.state.title}></textarea>
                              </span>
                         </span>
                         <span>
                             <select name="flow" onChange={this.handleFlowChange}
                                      style={style4} value={this.state.flowId}>
                                     <option value="null">请选择流程</option>
                                         <c:forEach var="flow" items="${flowList}">
                                          <option value="${flow.id}">${flow.title}</option>
                                         </c:forEach>
                              </select>
                         </span>
                         <span>
                            <select style={style5} value={this.state.userId} onChange={this.handleUserChange}>
                               {user}
                            </select>
                         </span>


              </div>
              <div className="am-margin" >
                   <a  onClick={this.handleClick} className="am-btn am-btn-primary am-btn-xs">确认添加</a>
              </div>
           </li>
          )
         }
    });

    ReactDOM.render(
            (
              <div>
               <ProjectView  />
             </div>
            )
            ,
           document.getElementById("all")
  
    );




</script>
<script type="text/javascript">

</script>

</body>
</html>
