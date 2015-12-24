package com.efeiyi.ec.xwork.task.controller;

import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xw.project.model.Project;
import com.efeiyi.ec.xw.task.model.Task;
import com.efeiyi.ec.xw.task.model.TaskGroup;
import com.efeiyi.ec.xwork.project.service.ProjectManager;
import com.efeiyi.ec.xwork.task.service.TaskManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/task")
public class TaskController extends BaseController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private TaskManager taskManager;

    /**
     * 改变实例状态
     */

    @RequestMapping("/changeTaskStatus")
    @ResponseBody
    public  Map<String,List> changeTaskStatus(String taskId,String status){
        Task task = null;
        Map<String,List> map = new HashMap<>();
        try {
            task = taskManager.changeTaskInstanceStatus(taskId,"4");
            map.put("users",task.getCurrentInstance().getFlowActivity().getUser());

        }catch (Exception e){

        }
        return map;
    }


}
