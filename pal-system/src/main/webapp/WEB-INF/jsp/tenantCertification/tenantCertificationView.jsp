<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/24
  Time: 13:16
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
    <script type="text/javascript">
        function showDiv() {
            var psf = document.getElementById("uploadCertificationImg");
            psf.setAttribute("style", "display");
        }
    </script>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">认证详情</strong>
    </div>
</div>

<div am-panel am-panel-default admin-sidebar-panel>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>商户名称：</td>
            <td>${object.tenant.name}</td>
        </tr>
        <tr>
            <td>商户地址：</td>
            <td>${object.tenant.province}&nbsp;${object.tenant.city}&nbsp;${object.tenant.address}</td>
        </tr>
        <tr>
            <td>认证证书</td>
            <td>${object.name}</td>
        </tr>
        <tr>
            <td>认证机构</td>
            <td>${object.org}</td>
        </tr>
        <tr>
            <td>认证时间</td>
            <td><fmt:formatDate value="${object.theDate}" pattern="yyyy年MM月"/></td>
        </tr>
        <tr>
            <td>认证结果</td>
            <td>
                <ming800:status name="level" dataType="PCTenantCertification.level"
                                checkedValue="${object.level}" type="normal"/>
            </td>
        </tr>
    </table>
</div>

<%-- 认证图片 上传 --%>
<div style="text-align: left;margin-left: 10px;">
    <input onclick="showDiv()"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;"
           value="上传认证图片"/>
</div>

<div class="am-g" id="uploadCertificationImg" style="display:none">
    <form action="<c:url value='/certificationImg/saveCertificationImg.do'/>" method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
        <input type="hidden" name="certificationId" value="${object.id}">
        <div class="am-form-group">
            <label for="Img" class="am-u-sm-3 am-form-label">认证图片 <small style="color: red">*</small></label>
            <div class="am-u-sm-9">
                <input type="file" id="Img" name="Img" required>
            </div>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>

<%-- 认证图片 展示 --%>
<c:if test="${!empty object.imgList}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">认证图片</strong>/<small>小图展示</small>
        </div>
    </div>
    <div am-panel am-panel-default admin-sidebar-panel>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tbody>
            <tr>
                <c:forEach items="${object.imgList}" var="Img">
                    <td>
                        <img src="http://pal.efeiyi.com/${Img.imgUrl}@!pal-img-list"/>
                    </td>
                </c:forEach>
            </tr>
            <tr>
                <c:forEach items="${object.imgList}" var="Img2">
                    <td>
                        <button onclick="window.location.href='<c:url value="/certificationImg/removeCertificationImg.do?certificationId=${object.id}&ImgId=${Img2.id}"/>'"
                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                    </td>
                </c:forEach>
            </tr>
            </tbody>
        </table>
    </div>
</c:if>

</body>
</html>