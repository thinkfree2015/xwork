package com.efeiyi.ec.xwork.project.service.impl;


import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xw.flow.model.FlowActivity;
import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xw.project.model.Project;
import com.efeiyi.ec.xw.task.model.*;
import com.efeiyi.ec.xwork.organization.util.AuthorizationUtil;
import com.efeiyi.ec.xwork.project.dao.XWorkProjectDao;
import com.efeiyi.ec.xwork.project.service.ProjectManager;
import com.efeiyi.ec.xwork.task.dao.TaskDao;
import com.ming800.core.base.dao.XdoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */
@Service
public class ProjectManagerImpl implements ProjectManager {


    @Autowired
    private XdoDao xdoDao;

    @Autowired
    private TaskDao taskDao;

    @Autowired
    private XWorkProjectDao projectDao;
    //创建项目
    @Override
    public Project saveProject(Project project,String [] users){
       if("".equals(project.getId())){
           project.setId(null);
       }
        List<User> userList = new ArrayList<>();
        userList.add(AuthorizationUtil.getUser());
        if(users!=null) {
            if (users.length > 0) {
                for (int i=0;i<users.length;i++){
                    if(!users[i].equals(AuthorizationUtil.getMyUser().getId())){
                        userList.add((User) xdoDao.getObject(User.class.getName(), users[i]));
                    }


                }
            }
        }
        project.setMemberList(userList);
        xdoDao.saveOrUpdateObject(project);
        return  project;
    }

    //创建任务
    @Override
    public  Task saveTask(String taskGroupId,String title,String flowId,String userId){

        User user = null;
        if(!userId.equals("null")){
            user = (User)xdoDao.getObject(User.class.getName(),userId);
        }
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
            task.setStatus("1");
            task.setUsernotifyUserList(flowActivity.getUser());
            task.setTaskGroup((TaskGroup)xdoDao.getObject(TaskGroup.class.getName(),taskGroupId));
            //当前任务处理人
            task.setCurrentUser(user);
            //创建人
            task.setAuthor(AuthorizationUtil.getUser());
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
            // 任务实例处理人
            taskActivityInstance.setExcutor(user);

//            //问题
//            taskActivityInstance.setIssue(task.getTitle());
//            //动态
//            taskActivityInstance.setContent(AuthorizationUtil.getUser().getUsername()+"创建了任务: "+task.getTitle());
            //添加实例
            xdoDao.saveOrUpdateObject(taskActivityInstance);


            //问题
            TaskActivityInstanceExecution taskActivityInstanceExecution = new TaskActivityInstanceExecution();
            taskActivityInstanceExecution.setTaskActivityInstance(taskActivityInstance);
            taskActivityInstanceExecution.setTask(task);
            taskActivityInstanceExecution.setCreateDatetime(new Date());
            taskActivityInstanceExecution.setStatus("0");
            taskActivityInstanceExecution.setUser(user);
            xdoDao.saveOrUpdateObject(taskActivityInstanceExecution);

            //动态
            TaskDynamic taskDynamic = new TaskDynamic();
            taskDynamic.setTask(task);
            taskDynamic.setCreateDatetime(new Date());
            //当前用户
            taskDynamic.setCreator(AuthorizationUtil.getUser());
            taskDynamic.setTaskActivityInstance(taskActivityInstance);
            taskDynamic.setMessage("创建了任务" );
            xdoDao.saveOrUpdateObject(taskDynamic);
            //user null 则只创建，未分配  不为null 则两条动态:创建任务 分配人员
            if(user!=null){
                TaskDynamic taskDynamic1 = new TaskDynamic();
                taskDynamic1.setTask(task);
                taskDynamic1.setCreateDatetime(new Date());
                //当前用户
                taskDynamic1.setCreator(AuthorizationUtil.getUser());
                taskDynamic1.setTaskActivityInstance(taskActivityInstance);
                taskDynamic1.setMessage(" 给 " + user.getName() + " 指派了任务");
                xdoDao.saveOrUpdateObject(taskDynamic1);
            }



            //保存动态

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
        //改变我的问题user
        TaskActivityInstanceExecution taskActivityInstanceExecution = taskDao.getTaskActivityInstanceExecution(taskActivityInstance.getId());
        if(taskActivityInstanceExecution!=null){
            taskActivityInstanceExecution.setUser(user);
            xdoDao.saveOrUpdateObject(taskActivityInstanceExecution);
        }

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

    @Override
    public List<Project> getProject() {

        return projectDao.projectPList();
    }
}
