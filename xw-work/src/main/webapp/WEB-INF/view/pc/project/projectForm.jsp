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
    <script src="<c:url value="/scripts/PCDSelect.js" />"></script>
    <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>" ></script>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">创建项目</strong> / <small>Create Project</small></div>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value="/basic/xm.do"/>"  class="am-form am-form-horizontal" method="post" enctype="multipart/form-data">
        <input type="hidden" name="qm" value="saveOrUpdateProject">
        <input type="hidden" name="id" value="${object.id}">

        <div class="am-form-group">
            <label name="name" for="user-name" class="am-u-sm-3 am-form-label">项目名称 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="title" id="user-name" placeholder="项目名称" value="${object.title}" >
            </div>
        </div>
        <%--<div class="am-form-group">--%>
            <%--<label name="serial" for="serial" class="am-u-sm-3 am-form-label">项目编号 <small>*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<input type="text" name="serial" id="serial" placeholder="项目编号" value="${object.serial}" >--%>
            <%--</div>--%>
        <%--</div>--%>

        <div class="am-form-group">
            <label name="context"  class="am-u-sm-3 am-form-label">项目简介 </label>
            <div class="am-u-sm-9" style="margin-top: 10px">
               <textarea rows="4" cols="3" placeholder="项目简介(选填)">${object.context}</textarea>
            </div>
        </div>
        <div class="am-form-group">
            <label name="context"  class="am-u-sm-3 am-form-label">成员 </label>
            <div class="am-u-sm-9">
                <div class="am-tabs am-margin" data-am-tabs>
                    <ul class="am-tabs-nav am-nav am-nav-tabs">
                        <li class="am-active"><a href="#tab1">产品</a></li>
                        <li><a href="#tab2">UI</a></li>
                        <li><a href="#tab3">前端</a></li>
                        <li><a href="#tab4">开发</a></li>
                        <li><a href="#tab5">测试</a></li>
                        <li><a href="#tab6">运营</a></li>
                    </ul>

                    <div class="am-tabs-bd">

                        <div class="am-tab-panel am-fade am-in am-active" id="tab1">


                        </div>
                        <div class="am-tab-panel am-fade am-in am-active" id="tab2">

                        </div>
                        <div class="am-tab-panel am-fade am-in am-active" id="tab3">


                        </div>
                        <div class="am-tab-panel am-fade am-in am-active" id="tab4">


                        </div>
                        <div class="am-tab-panel am-fade am-in am-active" id="tab5">

                        </div>
                        <div class="am-tab-panel am-fade am-in am-active" id="tab6">

                        </div>



                </div>


            </div>
        <%--<div class="am-form-group">--%>
            <%--<label for="picture_url" class="am-u-sm-3 am-form-label">项目图片(PC)</label>--%>

            <%--<div class="am-u-sm-9">--%>
                <%--<span style="padding: 10px;">--%>
                       <%--<c:if test="${!empty object.picture_url}">--%>
                           <%--<img width="7%" src="http://pro.efeiyi.com/${object.picture_url}@!product-model">--%>
                       <%--</c:if>--%>
                <%--</span>--%>
                <%--<input type="file" id="picture_url" name="picture_url" placeholder="picture_url"--%>
                       <%--value="${object.picture_url}" >--%>
            <%--</div>--%>
        <%--</div>--%>
            <%--<div class="am-form-group">--%>
                <%--<label for="picture_pc_url" class="am-u-sm-3 am-form-label">项目图片内容(PC_URL)</label>--%>

                <%--<div class="am-u-sm-9">--%>
                <%--<span style="padding: 10px;">--%>
                       <%--<c:if test="${!empty object.picture_pc_url}">--%>
                           <%--<img width="7%" src="http://pro.efeiyi.com/${object.picture_pc_url}@!product-model">--%>
                       <%--</c:if>--%>
                <%--</span>--%>
                    <%--<input type="file" id="picture_pc_url" name="picture_pc_url" placeholder="picture_pc_url"--%>
                           <%--value="${object.picture_pc_url}" >--%>
                <%--</div>--%>

            <%--</div>--%>
            <%--<div class="am-form-group">--%>
                <%--<label for="picture_wap_url" class="am-u-sm-3 am-form-label">项目图片(WAP)</label>--%>

                <%--<div class="am-u-sm-9">--%>
                <%--<span style="padding: 10px;">--%>
                       <%--<c:if test="${!empty object.picture_wap_url}">--%>
                           <%--<img width="7%" src="http://pro.efeiyi.com/${object.picture_wap_url}@!product-model">--%>
                       <%--</c:if>--%>
                <%--</span>--%>
                    <%--<input type="file" id="picture_wap_url" name="picture_wap_url" placeholder="picture_wap_url"--%>
                           <%--value="${object.picture_wap_url}" >--%>
                <%--</div>--%>

        <%--</div>--%>

        <%--<div class="am-form-group">--%>
            <%--<label name="type" for="description" class="am-u-sm-3 am-form-label">项目描述 <small>*</small></label>--%>
            <%--<div class="am-u-sm-9" style="margin-top: 10px">--%>
                <%--&lt;%&ndash;<textarea id="content" name="content"  style="overflow-y: scroll"><c:if test="${!empty projectContent.content}">${projectContent.content}</c:if></textarea>&ndash;%&gt;--%>
                  <%--<textarea id="description" name="description" class="ckeditor" placeholder="项目内容"  >--%>
                      <%--${object.description}--%>
                <%--</textarea>--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
<!-- content end -->
<hr/>

<script type="text/javascript">

   <c:forEach var="user" items="${userList}">
      var html = '<span style="margin-left: 10px;">'+
           ' <input type="checkbox" name="user" value="${user.id}">'+
           ' <a href="javascript:void (0)">${user.username}</a>'+
           '</span>';
      <c:if test="${user.group==1}">
         $("#tab1").append(html);
      </c:if>
      <c:if test="${user.group==2}">
         $("#tab2").append(html);
      </c:if>
      <c:if test="${user.group==3}">
         $("#tab3").append(html);
      </c:if>
      <c:if test="${user.group==4}">
         $("#tab4").append(html);
       </c:if>
      <c:if test="${user.group==5}">
         $("#tab5").append(html);
      </c:if>
      <c:if test="${user.group==6}">
         $("#tab6").append(html);
      </c:if>
   </c:forEach>
</script>
</body>
</html>
