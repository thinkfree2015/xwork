package com.efeiyi.ec.xwork.task.controller;

import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xwork.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/16.
 */
public class TaskFormHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listProjectUser_default",request);
        xQuery.put("project_id",request.getParameter("projectId"));
        List<User> userList = baseManager.listObject(xQuery);
        modelMap.put("userList",userList);
        modelMap.put("myUser", AuthorizationUtil.getMyUser());
        return modelMap;
    }
}
