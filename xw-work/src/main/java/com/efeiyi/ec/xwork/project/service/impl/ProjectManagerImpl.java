package com.efeiyi.ec.xwork.project.service.impl;


import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xw.flow.model.FlowActivity;
import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xw.project.model.Project;
import com.efeiyi.ec.xw.project.model.ProjectUser;
import com.efeiyi.ec.xw.task.model.*;
import com.efeiyi.ec.xwork.organization.util.AuthorizationUtil;
import com.efeiyi.ec.xwork.project.service.ProjectManager;
import com.ming800.core.base.dao.XdoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */
@Service
public class ProjectManagerImpl implements ProjectManager {


    @Autowired
    private XdoDao xdoDao;

    //创建项目
    @Override
    public Project saveProject(Project project,String [] users){
       if("".equals(project.getId())){
           project.setId(null);
       }
        boolean f = false;
        xdoDao.saveOrUpdateObject(project);
        if(users!=null) {
            if (users.length > 0) {
                for (int i=0;i<users.length;i++){
                    if(users[i].equals(AuthorizationUtil.getMyUser().getId())){
                        if(!f){
                           f=true;
                        }else {
                            continue;
                        }
                    }
                    ProjectUser projectUser = new ProjectUser();
                    projectUser.setProject(project);
                    projectUser.setUser((User) xdoDao.getObject(User.class.getName(), users[i]));
                    xdoDao.saveOrUpdateObject(projectUser);


                }
            }
        }
        return  project;
    }

    //创建任务
    @Override
    public  Task saveTask(String taskGroupId,String title,String flowId){
        //流程
        Flow flow = (Flow)xdoDao.getObject(Flow.class.getName(),flowId);
        //流程节点
        List<FlowActivity> flowActivityList =  flow.getActivityList();
        //添加任务为第一个节点
        FlowActivity flowActivity = flowActivityList.get(0);
        //节点 (组)
 //       Integer group = flowActivity.getGroup();
        //节点可选成员
 //       List<User> userList = flowActivity.getUser();
//        //激活该节点
//        flowActivity.setStatus("2");
//        //更新该节点
//        xdoDao.saveOrUpdateObject(flowActivity);


        //创建新任务
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String date = sdf.format(new Date());
        Task task = new Task();
        try {
            task.setTitle(title);
            task.setCreateDatetime(sdf.parse(date));
            task.setFlow(flow);
            task.setTaskGroup((TaskGroup)xdoDao.getObject(TaskGroup.class.getName(),taskGroupId));
            //添加新任务
            xdoDao.saveOrUpdateObject(Task.class.getName(),task);


            //创建任务实例
            TaskActivityInstance taskActivityInstance = new TaskActivityInstance();
            //加入任务
            taskActivityInstance.setTask(task);
            //加入流程节点 (第一个节点)
            taskActivityInstance.setFlowActivity(flowActivity);
            //设置实例状态 1 :未处理    2:正在处理      3:搁置    4:已完成   5:已放弃
            taskActivityInstance.setStatus("1");
            //设置激活状态
            taskActivityInstance.setActivate("1");
            //创建时间
            taskActivityInstance.setCreateDatetime(new Date());
            //默认处理人为当前用户
            taskActivityInstance.setExcutor(AuthorizationUtil.getUser());

//            //问题
//            taskActivityInstance.setIssue(task.getTitle());
//            //动态
//            taskActivityInstance.setContent(AuthorizationUtil.getUser().getUsername()+"创建了任务: "+task.getTitle());
            //添加实例
            xdoDao.saveOrUpdateObject(taskActivityInstance);


            //动态
            TaskDynamic taskDynamic = new TaskDynamic();
            taskDynamic.setTask(task);
            taskDynamic.setCreateDatetime(new Date());
            //默认当前用户
            taskDynamic.setCreator(AuthorizationUtil.getUser());
            taskDynamic.setTaskActivityInstance(taskActivityInstance);
            taskDynamic.setMessage(AuthorizationUtil.getUser().getUsername() + "创建了任务:" + task.getTitle());
            //保存动态
            xdoDao.saveOrUpdateObject(taskDynamic);
        }catch (Exception e){
            e.printStackTrace();
        }
        return  task;
    }



    @Override
    public  User sendUser(String taskId,String userId){
        User user = null;
        //新的任务处理人
        if(!userId.equals("null")){
            user = (User)xdoDao.getObject(User.class.getName(),userId);
        }

        Task task = (Task)xdoDao.getObject(Task.class.getName(),taskId);

        //原处理人员

        User oldUser = task.getCurrentUser();

        //改变任务处理人员
        task.setCurrentUser(user);

        xdoDao.saveOrUpdateObject(task);

        //改变当前任务实例的处理人
        TaskActivityInstance taskActivityInstance = task.getCurrentInstance();
        taskActivityInstance.setExcutor(user);

        xdoDao.saveOrUpdateObject(taskActivityInstance);

        //添加任务操作动态记录

        TaskDynamic taskDynamic = new TaskDynamic();
        taskDynamic.setTaskActivityInstance(taskActivityInstance);
        taskDynamic.setTask(task);
        taskDynamic.setCreator(AuthorizationUtil.getUser());
        taskDynamic.setCreateDatetime(new Date());
        if(user==null){
            taskDynamic.setMessage(" 取消了 "+oldUser.getName()+" 的任务");
        }else {
            taskDynamic.setMessage(" 给 " + user.getName() + " 指派了任务");
        }

        xdoDao.saveOrUpdateObject(taskDynamic);

        return  user;
    }

}
