package com.efeiyi.ec.xwork.project.controller;

import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xw.project.model.Project;
import com.efeiyi.ec.xw.project.model.ProjectUser;
import com.efeiyi.ec.xw.task.model.Task;
import com.efeiyi.ec.xw.task.model.TaskGroup;
import com.efeiyi.ec.xwork.organization.util.AuthorizationUtil;
import com.efeiyi.ec.xwork.project.service.ProjectManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Page;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;


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

    @RequestMapping("/pList.do")
    public String toProjectPlist(HttpServletRequest request,ModelMap modelMap){

        List<Project> projectList = projectManager.getProject();
        PageEntity pageEntity = new PageEntity();
        String pageIndex = request.getParameter("pageEntity.index");
        String pageSize = request.getParameter("pageEntity.size");
        if (pageIndex != null) {
            pageEntity.setIndex(Integer.parseInt(pageIndex));
            pageEntity.setSize(Integer.parseInt(pageSize));
        }
        PageInfo pageInfo = new PageInfo();
        List<Project> projects = new ArrayList<>();
        List<Project> list = new ArrayList<>();
        if(projectList!=null){
            for(Project project : projectList){
                 for(User user : project.getMemberList()){
                     if(user.getId().equals(AuthorizationUtil.getUser().getId())){
                         projects.add(project);
                         break;
                     }
                 }
            }
        }
        int l = pageEntity.getIndex()*pageEntity.getSize();
        int g = (pageEntity.getIndex()-1)*pageEntity.getSize();
        if(projects!=null){
            pageEntity.setCount(projects.size());
            pageInfo.setCount(projects.size());
            pageInfo.setPageEntity(pageEntity);
            int i = 0;
            for(Project project : projects){
                if(i<l&&i>=g){
                   if(i>=projects.size()){
                       break;
                   }
                    list.add(project);
                }
                i++;
            }
         pageInfo.setList(list);
        }
        modelMap.put("pageInfo",pageInfo);
        return "/project/projectPList2";
    }
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
     * @param title
     * @param projectId
     * @return
     */
    @RequestMapping("/addTaskGroup.do")
    @ResponseBody
    public  List addTaskGroup(String title,String projectId,HttpServletRequest request){
        List<TaskGroup> taskGroupList = null;
        TaskGroup taskGroup = new TaskGroup();
       try {
           XQuery xQuery = new XQuery("listTaskGroup_default",request);
           xQuery.put("project_id",projectId);
           taskGroupList = baseManager.listObject(xQuery);
           taskGroup.setProject((Project)baseManager.getObject(Project.class.getName(),projectId));
           taskGroup.setTitle(title);
           baseManager.saveOrUpdate(TaskGroup.class.getName(),taskGroup);
           taskGroupList.add(taskGroup);
       }catch (Exception e){
           e.printStackTrace();
       }
       return taskGroupList;
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
    public  List addTask(String taskGroupId,String title,String flowId,String userId,HttpServletRequest request){
        List<Task> taskList = null;
        try {
            XQuery xQuery = new XQuery("listTask_byGroup",request);
            xQuery.put("taskGroup_id",taskGroupId);
            taskList = baseManager.listObject(xQuery);
            Task task = projectManager.saveTask(taskGroupId,title,flowId,userId);
            task.setUsername(task.getCurrentUser().getUsername());
            taskList.add(task);
        }catch (Exception e){
            e.printStackTrace();
        }

        return taskList;
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
    public   List changeActivity(String flowId){
        Map<String,List> map = new HashMap<>();
        Flow flow = (Flow)baseManager.getObject(Flow.class.getName(),flowId);
        try {
            map.put("users",flow.getActivityList().get(0).getUser());
        }catch (Exception e){
            e.printStackTrace();
        }
        return flow.getActivityList().get(0).getUser();
    }

    @RequestMapping("/getProject.do")
    @ResponseBody
     public   Project getProject(String id){
        Project project = null;
        try {
            project = (Project)baseManager.getObject(Project.class.getName(),id);
        }catch (Exception e){
            e.printStackTrace();
        }
        return project;
    }
    @RequestMapping("/getTaskGroup.do")
    @ResponseBody
    public   List getTaskGroup(String projectId,HttpServletRequest request){
        List<TaskGroup> taskGroupList = null;
        try {
            XQuery xQuery = new XQuery("listTaskGroup_default",request);
            xQuery.put("project_id",projectId);
            taskGroupList = baseManager.listObject(xQuery);

        }catch (Exception e){
            e.printStackTrace();
        }
        return taskGroupList;
    }

    @RequestMapping("/getTask.do")
    @ResponseBody
    public   List getTask(String id,HttpServletRequest request){
        List<Task> taskList = null;
        try {
            XQuery xQuery = new XQuery("listTask_byGroup",request);
            xQuery.put("taskGroup_id",id);
            taskList = baseManager.listObject(xQuery);

        }catch (Exception e){
            e.printStackTrace();
        }
        return taskList;
    }
    @RequestMapping("/getCurrentInstanceUsers.do")
    @ResponseBody
    public   List getCurrentInstanceUsers(String id){
        List<User> userList = null;
        try {
           Task  task = (Task)baseManager.getObject(Task.class.getName(),id);
            userList = task.getCurrentInstance().getFlowActivity().getUser();
        }catch (Exception e){
            e.printStackTrace();
        }
        return userList;
    }
    @RequestMapping("/getCurrentUser.do")
    @ResponseBody
    public   String getCurrentUser(String id){
       String userId = "null";
        try {
            Task  task = (Task)baseManager.getObject(Task.class.getName(),id);
            if(task.getCurrentUser()!=null) {
                userId = task.getCurrentUser().getId();
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return userId;
    }
    @RequestMapping("/getFlow.do")
    @ResponseBody
    public   Flow getFlow(String id){
        Flow flow = null;
        try {
            Task  task = (Task)baseManager.getObject(Task.class.getName(),id);
            flow = task.getFlow();
        }catch (Exception e){
            e.printStackTrace();
        }
        return flow;
    }
    @RequestMapping("/view.do")
    public   String projectView(HttpServletRequest request,ModelMap modelMap){

        try {
            //流程
            XQuery xQuery = new XQuery("listFlow_default",request);
            List<Flow> flowList = baseManager.listObject(xQuery);
            modelMap.put("flowList",flowList);
            modelMap.put("id",request.getParameter("id"));
        }catch (Exception e){
            e.printStackTrace();
        }
        return "/project/projectView";
    }

}
