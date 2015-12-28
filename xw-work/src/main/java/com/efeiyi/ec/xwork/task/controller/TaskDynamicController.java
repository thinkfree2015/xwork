package com.efeiyi.ec.xwork.task.controller;

import com.efeiyi.ec.xw.task.model.TaskDynamic;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/12/24.
 */
@Controller
public class TaskDynamicController {


    @Autowired
    private BaseManager baseManager;


    @ResponseBody
    @RequestMapping("/taskDynamic/{userId}")
    public List<TaskDynamic> allOrOne(@PathVariable String userId, HttpServletRequest request) throws Exception {
        List<TaskDynamic> list = null;
        if (!StringTools.isEmpty(userId)) {
            XQuery xQuery;
            if (!"0".equals(userId)) {
                xQuery = new XQuery("listTaskDynamic_byUser", request);
                xQuery.put("creator_id", userId);
            } else {
                xQuery = new XQuery("listTaskDynamic_all", request);
            }
            list = baseManager.listObject(xQuery);
            if (!StringTools.isEmpty(list) && list.size() > 0) {
                for (TaskDynamic taskDynamic : list) {
                    taskDynamic.setProjectId(taskDynamic.getTask().getTaskGroup().getProject().getId() == null ? "" : taskDynamic.getTask().getTaskGroup().getProject().getId());
                    taskDynamic.setTaskId(taskDynamic.getTask().getId() == null ? "" : taskDynamic.getTask().getId());
                    taskDynamic.setTaskTitle(taskDynamic.getTask().getTitle() == null ? "" : taskDynamic.getTask().getTitle());
                }
            }
        }
        return list;
    }


}
