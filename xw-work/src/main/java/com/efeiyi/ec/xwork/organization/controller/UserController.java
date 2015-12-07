package com.efeiyi.ec.xwork.organization.controller;

import com.efeiyi.ec.xw.organization.model.MyUser;
import com.efeiyi.ec.xw.organization.model.User;
import com.ming800.core.base.service.BaseManager;
import org.springframework.stereotype.Controller;
import com.ming800.core.base.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;

/**
  * Created by IntelliJ IDEA.
  * User: ming
  * Date: 12-10-15
  * Time: 下午4:56
  * To change this template use File | Settings | File Templates.
 */
 @Controller
 @RequestMapping("/user")
 public class UserController extends BaseController {
 
     @Autowired
     private BaseManager baseManager;


   /**
     *
      * 修改用户组别
      *
      * @param request UserId
      * @return flag
     */
     @ResponseBody
     @RequestMapping("/base/removeUser.do")
     public boolean setUpUserContact(HttpServletRequest request) {
         String UserId = request.getParameter("userId");
         boolean flag = false;
         if (UserId!=null && !"".equals(UserId)){
             User user = (User)baseManager.getObject(User.class.getName(),UserId);
             user.setGroupName(0);
             baseManager.saveOrUpdate(User.class.getName(),user);
             flag = true;
         }
         return flag;
     }
 
 }
