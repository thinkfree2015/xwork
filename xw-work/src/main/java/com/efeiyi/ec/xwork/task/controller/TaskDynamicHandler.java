package com.efeiyi.ec.xwork.task.controller;

import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xw.task.model.TaskDynamic;
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
public class TaskDynamicHandler implements DoHandler {
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listUser_default", request);
        List<User> list = baseManager.listObject(xQuery);
        modelMap.addAttribute("users", list);
        String qm = request.getParameter("qm");
        if (qm.startsWith("form")) {
            XQuery query = new XQuery("listTaskDynamic_byUser", request);
            User user = (User) baseManager.getObject(User.class.getName(), request.getParameter("id"));
            query.put("creator_id", user.getId());
            List<TaskDynamic> taskDynamics = baseManager.listObject(query);
            modelMap.addAttribute("onlyUser", user);
            modelMap.addAttribute("messages", taskDynamics);
        }
        return modelMap;
    }
}
