package com.efeiyi.ec.xwork.task.controller;

import com.efeiyi.ec.xw.organization.model.User;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/12/24.
 */
public class TaskDynamicHandler implements DoHandler{
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listUser_default",request);
        List<User> list = baseManager.listObject(xQuery);
        modelMap.addAttribute("users",list);
        return modelMap;
    }
}
