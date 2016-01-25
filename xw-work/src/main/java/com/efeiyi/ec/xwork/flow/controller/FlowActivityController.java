package com.efeiyi.ec.xwork.flow.controller;

import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xw.flow.model.FlowActivity;
import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xwork.model.Flow.FlowParamBean;
import com.efeiyi.ec.xwork.process.ProcessEngine;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/12/8.
 */
@Controller
public class FlowActivityController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/flow/saveOrUpdateFlowActivity.do"})
    private String createFlow(HttpServletRequest request) throws Exception {
        Flow flow = (Flow) baseManager.getObject(Flow.class.getName(), request.getParameter("flow.id"));
        FlowActivity activity;
        String id = request.getParameter("id");
        if (!StringTools.isEmpty(id)) {
            activity = (FlowActivity) baseManager.getObject(FlowActivity.class.getName(), id);
        } else {
            activity = new FlowActivity();
        }
        if (flow != null && flow.getId() != null) {
            activity.setFlow(flow);
            activity.setSort(flow.getActivityList().size() == 0 ? 1 : flow.getActivityList().size() + 1);
        }
        String title = request.getParameter("title");
        String group = request.getParameter("group");
        String type = request.getParameter("type");
        String[] args = request.getParameterValues("user");
        List<User> list = new ArrayList<>();
        if (!StringTools.isEmpty(args) && args.length > 0) {
            for (int i = 0; i < args.length; i++) {
                User user = (User) baseManager.getObject(User.class.getName(), String.valueOf(args[i]));
                list.add(user);
            }
        }
        activity.setStatus("1");
        activity.setType(type);
        activity.setTitle(title);
        activity.setGroup(Integer.parseInt(group));
        activity.setUser(list);
        baseManager.saveOrUpdate(FlowActivity.class.getName(), activity);
        assert flow != null;
        return "redirect:/basic/xm.do?qm=viewFlow&id=" + flow.getId();
    }

    @ResponseBody
    @RequestMapping({"/flow/removeFlowActivity/{flowId}"})
    private String removeFlow(@PathVariable String flowId, HttpServletRequest request) throws Exception {
        baseManager.remove(Flow.class.getName(), flowId);
        return "succ";
    }

    @ResponseBody
    @RequestMapping({"/flow/getUsers/{groupName}"})
    private Map<String, User> getUsers(HttpServletRequest request, @PathVariable int groupName) throws Exception {
        Map<String, User> map = new HashMap<String, User>();
        String id = request.getParameter("id");
        String flowId = request.getParameter("flowId");
        FlowActivity flowActivity = (FlowActivity) baseManager.getObject(FlowActivity.class.getName(), id);
        Flow flow = (Flow) baseManager.getObject(Flow.class.getName(), flowId);
        List<User> users = flow.getNotifyUserList();
        if (users != null && users.size() > 0) {
            for (User user : users) {
                String flag = "false";
                if (user.getGroupName() == groupName) {
                    if (null != flowActivity && flowActivity.getId() != null) {
                        flag = equal(flowActivity, user, groupName);
                        map.put(user.getId() + flag, user);
                    } else {
                        map.put(user.getId() + flag, user);
                    }
                }
            }
        }
        return map;
    }

    public String equal(FlowActivity flowActivity, User user, int groupName) {
        List<User> list = flowActivity.getUser();
        if (!StringTools.isEmpty(list) && list.size() > 0) {
            for (User user1 : list) {
                if (user1.getGroupName() == groupName && user.getId().equals(user1.getId())) {
                    return "true";
                }
            }
        }
        return "false";
    }

}
