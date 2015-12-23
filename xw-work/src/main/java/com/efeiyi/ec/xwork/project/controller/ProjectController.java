package com.efeiyi.ec.xwork.project.controller;

import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xw.project.model.Project;
import com.efeiyi.ec.xw.task.model.Task;
import com.efeiyi.ec.xw.task.model.TaskGroup;
import com.efeiyi.ec.xwork.project.service.ProjectManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/project")
public class ProjectController extends BaseController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private ProjectManager projectManager;

    /**
     * 保存项目爱
     * @param request
     * @param project
     * @param resultPage
     * @return
     */
    @RequestMapping("/saveProject.do")
    public  String saveProject(HttpServletRequest request,Project project,String resultPage){
        String [] memberList = request.getParameterValues("user");
        try {
            projectManager.saveProject(project,memberList);
        }catch (Exception e){
            e.printStackTrace();
        }
        return  resultPage;
    }

    /**
     * 添加任务清单
     * @param taskGroup
     * @param projectId
     * @return
     */
    @RequestMapping("/addTaskGroup.do")
    @ResponseBody
    public  String addTaskGroup(TaskGroup taskGroup,String projectId){
       try {
           taskGroup.setProject((Project)baseManager.getObject(Project.class.getName(),projectId));
           baseManager.saveOrUpdate(TaskGroup.class.getName(),taskGroup);
       }catch (Exception e){
           e.printStackTrace();
       }
       return taskGroup.getId();
    }

    /**
     * 添加任务
     * @param taskGroupId
     * @param title
     * @param flowId
     * @return
     */
    @RequestMapping("/addTask.do")
    @ResponseBody
    public  String addTask(String taskGroupId,String title,String flowId){
        Task task = projectManager.saveTask(taskGroupId,title,flowId);
        return task.getId();
    }

    /**
     * 分配任务
     * @param taskId
     * @param userId
     * @return
     */
    @RequestMapping("/sendUser.do")
    @ResponseBody
    public  String sendUser(String taskId,String userId){
        try {
           projectManager.sendUser(taskId,userId);
        }catch (Exception e){
            e.printStackTrace();
        }
        return taskId;
    }


    @RequestMapping("/changeActivity.do")
    @ResponseBody
    public   Map<String,List> changeActivity(String flowId){
        Map<String,List> map = new HashMap<>();
        try {
            Flow flow = (Flow)baseManager.getObject(Flow.class.getName(),flowId);
            map.put("users",flow.getActivityList().get(0).getUser());

        }catch (Exception e){
            e.printStackTrace();
        }
        return map;
    }


}
