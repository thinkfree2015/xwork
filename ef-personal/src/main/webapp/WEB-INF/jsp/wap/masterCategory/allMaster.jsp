<%@ page import="com.efeiyi.ec.personal.AuthorizationUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>12010703大师分类-地区</title>
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">
  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
  <link rel="icon" type="image/png" href="assets/i/favicon.png">
  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <link rel="icon" sizes="192x192" href="assets/i/app-icon72x72@2x.png">
  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <script src="<c:url value='/resources/jquery/jquery-1.11.1.min.js'/>"></script>
</head>
<body>
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="javascript:history.go(-1);" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title"></h1>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu">
      <i class="line"></i>
    </a>
  </div>
  <!-- //End--chevron-left-->
  <div class="menu-list">
    <div class="menu-page">
      <ul class="bd">
        <li><a href="<c:url value='/masterMessage/index.do'/>" title="首页">首页</a></li>
        <li><a href="" title="分类">消&nbsp;息</a></li>
        <li><a href="<c:url value='/personal/getPersonal.do'/>" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
      </ul>
    </div>
  </div>
</header>
<!--//End--header-->
<!--地区-->
<div class="master-class" id="pubu">
  <c:forEach items="${list}" var="obj">
      <div class="inheritor">
        <div class="inheritor-text">
          <p class="itor-text-1">${obj.fullName}</p>
          <p class="itor-text-2">${obj.projectName}</p>
          <p class="itor-text-3"><ming800:status name='level' dataType='Tenant.level' checkedValue='${obj.level}' type='normal'/>非遗传承人</p>
          <p class="itor-text-4">${obj.brief}</p>
          <a class="gz-fd-icon" onclick="changeFollowedStatus(this,'${obj.id}');">${obj.followStatus}</a>
          <div class="gz-fd-img"><a href="<c:url value='/masterMessage/forwardMasterDetails.do?masterId=${obj.id}'/>"><img src="http://tenant.oss-cn-beijing.aliyuncs.com/${obj.favicon}"></a></div>
        </div>
      </div>
  </c:forEach>
</div>
<!--地区-->
<div class="login-reg">
  <%if(AuthorizationUtil.getMyUser()!=null && AuthorizationUtil.getMyUser().getId() != null){ %>
  <div class="bd logined"><%=AuthorizationUtil.getMyUser().getUsername()%><a class="btn-exit" href="<c:url value='/j_spring_cas_security_logout'/>">退出</a></div>
  <% } %>
  <%if(AuthorizationUtil.getMyUser()==null || AuthorizationUtil.getMyUser().getId() == null){ %>
  <a href="<c:url value='/sso.do'/>" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
  <a href="http://passport.efeiyi.com/register?service=http://master.efeiyi.com/ef-person//sso.do" class="btn-reg">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
  <% } %>

</div>
<!--//End--login-reg-->
<footer class="bd footer">
  <div class="bd info">
    <a class="icon"></a>
    <div class="txt">中&nbsp;&nbsp;国&nbsp;&nbsp;非&nbsp;&nbsp;遗&nbsp;&nbsp;电&nbsp;&nbsp;商&nbsp;&nbsp;平&nbsp;&nbsp;台</div>
    <div class="wechat"></div>
    <div class="txt">关注微信公众号</div>
    <div class="txt">领取超值代金券</div>
  </div>
  <div class="bd copyright">京ICP备15032511号-1</div>
</footer>
<!--//End--footer-->
<script >
  var startNum = 1;
  var ajaxKey = true;
  $(document).ready(function(){
    allMaster("<c:url value='/masterCategory/allMaster/plistMaster_default/6/'/>");
  });
  $(window).load(function(){
    var winH = $(window).height(); //页面可视区域高度
    $(window).scroll(function(){
      var pageH = $(document).height();
      var scrollT = $(window).scrollTop(); //滚动条top
      var aa = (pageH - winH - scrollT) / winH;
      if(aa < 0.02) {
        if (ajaxKey) {
          allMaster("<c:url value='/masterCategory/allMaster/plistMaster_default/6/'/>");
        }
      }
    })
  });
  function allMaster(url){
    var flag = false;
    $.ajax({
      type: "POST",
      url: url + startNum,
      async: false,
      dataType:"json",
      error: function () { alert('出错了,请联系系统管理员!'); },
      success: function (data) {
        var box = $("#pubu");
        var sub = "";
        if(data && data.length > 0){
          for(var i in data){
            var levelName = "";
            switch (parseInt(data[i].level))
            {
              case 1:
                levelName="国家级非遗传承人";
                break;
              case 2:
                levelName="省级非遗传承人";
                break;
              case 3:
                levelName="市级非遗传承人";
                break;
              case 4:
                levelName="县级非遗传承人";
                break;

            }
            sub +=  "    <div class=\"inheritor\">"+
                    "        <div class=\"inheritor-text\">"+
                    "            <p class=\"itor-text-1\">"+data[i].fullName+"</p>"+
                    "            <p class=\"itor-text-3\">"+levelName+"</p>"+
                    "            <p class=\"itor-text-4\">"+data[i].brief+"</p>"+
                    "            <a class=\"gz-fd-icon\" onclick=\"changeFollowedStatus(this,'"+data[i].id+"')\">"+data[i].followStatus+"</a>"+
                    "            <div class=\"gz-fd-img\"><a href=\"<c:url value='/masterMessage/forwardMasterDetails.do?masterId='/>"+data[i].id+"\"><img src=\"http://tenant.oss-cn-beijing.aliyuncs.com/"+data[i].favicon+"\"></a></div>"+
                    "        </div>"+
                    "    </div>";
          }
          box.append(sub);
        }else{
          flag = true;
        }
      },complete:function(){
        startNum = startNum + 1;
        if(flag == true){
          ajaxkey = false;
        }
      }
    })
  }
  function changeFollowedStatus(o,masterId){
    var status = "";
    var str = $(o).html();
    if(str == "已关注"){
      status = "2";
    }else if(str == "关注"){
      status = "1";
    }
    $.ajax({
      type: "POST",
      url: "<c:url value='/masterFollow/followed.do'/>",
      data:"masterId="+masterId+"&status="+status,
      async:false,
      dataType:"json",
      error:function(){alert("操作失败.请联系系统管理员!")},
      success:function(msg){
        if(msg == "noRole"){
          alert("您还未登录,请登录后操作");
        }
        if(msg == "del"){
          $(o).html("关注");
        }else if(msg == "add"){
          $(o).html("已关注");
        }
      }
    })
  }
</script>

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value='/scripts/assets/js/jquery.min.js'/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/scripts/assets/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script src="<c:url value='/scripts/assets/js/amazeui.min.js'/>"></script>
<!--自定义js--Start-->
<script src="<c:url value='/scripts/assets/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/js/cyclopedia.js?v=20150831'/>"></script>
<!--自定义js--End-->
</body>
</html>