package com.efeiyi.ec.xwork.task.service.impl;

import com.efeiyi.ec.xw.flow.model.FlowActivity;
import com.efeiyi.ec.xw.task.model.Task;
import com.efeiyi.ec.xw.task.model.TaskActivityInstance;
import com.efeiyi.ec.xw.task.model.TaskDynamic;
import com.efeiyi.ec.xwork.organization.util.AuthorizationUtil;
import com.efeiyi.ec.xwork.task.service.TaskManager;
import com.ming800.core.base.dao.XdoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/12/7.
 *
 */
@Service
public class TaskManagerImpl implements TaskManager {
    @Autowired
    private XdoDao xdoDao;
    @Override
    public Task createTask(Map map) throws Exception {
        Task task = new Task();
        if (map!=null && !map.isEmpty()){

        }
        xdoDao.saveOrUpdateObject(Task.class.getName(),task);
        return task;
    }


    @Override
    public Task changeTaskInstanceStatus(String taskId,String status){
        //当前任务
              Task task = (Task)xdoDao.getObject(Task.class.getName(),taskId);
        //当前任务实例
              TaskActivityInstance taskActivityInstance = task.getCurrentInstance();
        //改变实例状态
              taskActivityInstance.setStatus(status);

        //动态
        String message = "";

        //创建完成任务动态
        TaskDynamic taskDynamic = new TaskDynamic();
        taskDynamic.setCreateDatetime(new Date());
        taskDynamic.setCreator(AuthorizationUtil.getUser());
        taskDynamic.setTask(task);
        taskDynamic.setTaskActivityInstance(taskActivityInstance);
        //1 :未处理    2:正在处理      3:搁置    4:已完成   5:已放弃
        if("1".equals(status)){

        }
        if("2".equals(status)){
            message = "正在处理任务";
            taskDynamic.setMessage(message);
        }
        if("3".equals(status)){
            message = "已搁置任务";
            taskDynamic.setMessage(message);
        }
        //已完成任务 则任务节点走向下一节点
        if("4".equals(status)){
            message = "已完成任务";




            //当前节点任务实例设置为 未激活状态
            taskActivityInstance.setActivate("0");
            xdoDao.saveOrUpdateObject(taskActivityInstance);
            //所有节点
            List<FlowActivity> flowActivityList = task.getFlow().getActivityList();
            //当前所处节点位置
            Integer group = taskActivityInstance.getFlowActivity().getGroup();
            //下一个节点
            FlowActivity nextFlowActivity = null;
            for(FlowActivity flowActivity : flowActivityList){
                if(flowActivity.getGroup()==group+1){
                    nextFlowActivity = flowActivity;
                    break;
                }
            }

            //判断是否为最后一个节点

            if(nextFlowActivity == null){

            }else {
                //创建下一节点的任务实例
                TaskActivityInstance nextTaskActivityInstance = new TaskActivityInstance();
                nextTaskActivityInstance.setActivate("1");
                //创建人默认为当前用户
                nextTaskActivityInstance.setExcutor(AuthorizationUtil.getUser());
                nextTaskActivityInstance.setStatus("1");
                nextTaskActivityInstance.setCreateDatetime(new Date());
                nextTaskActivityInstance.setTask(task);
                nextTaskActivityInstance.setFlowActivity(nextFlowActivity);
                xdoDao.saveOrUpdateObject(nextTaskActivityInstance);
                task.setCurrentInstance(nextTaskActivityInstance);
                xdoDao.saveOrUpdateObject(task);

                message += ",并进入下一个节点:"+nextFlowActivity.getTitle();

//                //创建下一个节点 动态
//                TaskDynamic nextTaskDynamic = new TaskDynamic();
//                nextTaskDynamic.setMessage("任务进入下一个节点");
//                nextTaskDynamic.setCreateDatetime(new Date());
//                nextTaskDynamic.setCreator(AuthorizationUtil.getUser());
//                nextTaskDynamic.setTask(task);
//                nextTaskDynamic.setTaskActivityInstance(nextTaskActivityInstance);
//                xdoDao.saveOrUpdateObject(nextTaskDynamic);
            }
            taskDynamic.setMessage(message);

        }
        if("5".equals(status)){
            message = "已放弃任务";
            taskDynamic.setMessage(message);
        }

        xdoDao.saveOrUpdateObject(taskDynamic);

        return  task;

    }
}