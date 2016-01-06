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
    public  String addTask(String taskGroupId,String title,String flowId,String userId){
        Task task = projectManager.saveTask(taskGroupId,title,flowId,userId);
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


}
