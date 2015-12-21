package com.efeiyi.ec.xwork.flow.controller;

import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xw.flow.model.FlowActivity;
import com.efeiyi.ec.xw.organization.model.MyUser;
import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xwork.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/12/17.
 */
public class FlowActivityHandle implements DoHandler {
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String qm = request.getParameter("qm");
        if (qm.startsWith("form")){
            modelMap.addAttribute("flowId",request.getParameter("flowId"));
        }else if(qm.startsWith("saveOrUpdate")){
            modelMap.addAttribute("flowId",request.getParameter("flow.id"));
            String title = request.getParameter("title");
            String sort = request.getParameter("sort");
            String type = request.getParameter("type");
            FlowActivity fa = new FlowActivity();
            fa.setSort(Integer.valueOf(sort));
            fa.setStatus(String.valueOf(1));
            fa.setTitle(title);
            fa.setType(type);
            fa.setFlow((Flow) baseManager.getObject(Flow.class.getName(),String.valueOf(modelMap.get("flowId"))));
            modelMap.addAttribute("object",fa);
        }
        XQuery xQuery = new XQuery("listUser_default", request);
        List<User> list = baseManager.listObject(xQuery);
        List<User> proList = new ArrayList<>();
        List<User> uiList = new ArrayList<>();
        List<User> webList = new ArrayList<>();
        List<User> devList = new ArrayList<>();
        List<User> testList = new ArrayList<>();
        List<User> operateList = new ArrayList<>();
        if (!StringTools.isEmpty(list)) {
            for (User user : list) {
                if ("1".equals(String.valueOf(user.getGroupName()))) {
                    proList.add(user);
                } else if ("2".equals(String.valueOf(user.getGroupName()))) {
                    uiList.add(user);
                } else if ("3".equals(String.valueOf(user.getGroupName()))) {
                    webList.add(user);
                } else if ("4".equals(String.valueOf(user.getGroupName()))) {
                    devList.add(user);
                } else if ("5".equals(String.valueOf(user.getGroupName()))) {
                    testList.add(user);
                } else if ("6".equals(String.valueOf(user.getGroupName()))) {
                    operateList.add(user);
                }
            }
            modelMap.addAttribute("proList", proList);
            modelMap.addAttribute("uiList", uiList);
            modelMap.addAttribute("webList", webList);
            modelMap.addAttribute("devList", devList);
            modelMap.addAttribute("testList", testList);
            modelMap.addAttribute("operateList", operateList);
        }
        return modelMap;
    }
}
