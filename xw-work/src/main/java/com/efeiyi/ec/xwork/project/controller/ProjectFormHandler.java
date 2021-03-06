package com.efeiyi.ec.xwork.project.controller;

import com.efeiyi.ec.xw.flow.model.Flow;
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
public class ProjectFormHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        XQuery xQuery = new XQuery("listUser_default",request);
        List<User> userList = baseManager.listObject(xQuery);
        modelMap.put("userList",userList);
        modelMap.put("myUser", AuthorizationUtil.getMyUser());
        //流程
        xQuery = new XQuery("listFlow_default",request);
        List<Flow> flowList = baseManager.listObject(xQuery);
        modelMap.put("flowList",flowList);
        return modelMap;
    }
}
