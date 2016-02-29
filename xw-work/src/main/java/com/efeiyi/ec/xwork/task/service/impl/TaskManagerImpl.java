package com.efeiyi.ec.xwork.task.service.impl;

import com.efeiyi.ec.xw.flow.model.FlowActivity;
import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xw.task.model.Task;
import com.efeiyi.ec.xw.task.model.TaskActivityInstance;
import com.efeiyi.ec.xw.task.model.TaskActivityInstanceExecution;
import com.efeiyi.ec.xw.task.model.TaskDynamic;
import com.efeiyi.ec.xwork.organization.util.AuthorizationUtil;
import com.efeiyi.ec.xwork.task.dao.TaskDao;
import com.efeiyi.ec.xwork.task.service.TaskManager;
import com.ming800.core.base.dao.XdoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.LinkedHashMap;
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
    @Autowired
    private TaskDao taskDao;
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
        //默认用户
              User  user = (User)xdoDao.getObject(User.class.getName(),AuthorizationUtil.getUser().getId());

        //当前流程节点
              FlowActivity currentActivity = task.getCurrentActivity();

        //当前任务实例列表   参数 task.id flowActivity.id
              LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
               map.put("taskId",taskId);
               map.put("flowActivityId",currentActivity.getId());
               List<TaskActivityInstance> taskActivityInstanceList = (List<TaskActivityInstance>)xdoDao.getObjectList("select m FROM TaskActivityInstance m WHERE  task.id = :taskId AND flowActivity.id= :flowActivityId ORDER BY createDatetime", map);
        //判断当前用户 有没有权限完成任务
              if(currentActivity.getUser().indexOf(user)==-1){
                  return  null;
              }
/**---------------------------------------------------------------------------------**/
//        //当前任务实例
//        TaskActivityInstance taskActivityInstance = task.getCurrentInstance();
//        //改变实例状态
//        taskActivityInstance.setStatus(status);
        //动态
        String message = "";

        //创建完成任务动态
        TaskDynamic taskDynamic = new TaskDynamic();
        taskDynamic.setCreateDatetime(new Date());
        taskDynamic.setCreator(user);
        taskDynamic.setTask(task);
//        taskDynamic.setTaskActivityInstance(taskActivityInstance);
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
            //是否进行下一个节点
            Boolean isNext = true;
            //判断该节点 的类型 1 one 2 xor 3 and
            if("2".equals(currentActivity.getType())){

                for (TaskActivityInstance instance : taskActivityInstanceList){
                    //设置所有该节点的任务实例 为 未激活状态  即已完成 状态
                    instance.setStatus(status);
                    instance.setActivate("0");
                    xdoDao.saveOrUpdateObject(instance);
                    //当前用户 完成的任务
                    if(instance.getExcutor().getId().equals(user.getId())){
                        taskDynamic.setTaskActivityInstance(instance);
                    }
                    //设置每个实例的问题状态 为 已执行
                    TaskActivityInstanceExecution taskActivityInstanceExecution = taskDao.getTaskActivityInstanceExecution(instance.getId());
                    if(taskActivityInstanceExecution!=null){
                        taskActivityInstanceExecution.setStatus("1");
                        xdoDao.saveOrUpdateObject(taskActivityInstanceExecution);
                    }
                }
            }else if("3".equals(currentActivity.getType())){

                for(TaskActivityInstance instance : taskActivityInstanceList){
                    if(instance.getExcutor().getId().equals(user.getId())){
                        //设置当前用户 该任务实例 的状态为 未激活状态 即 已完成状态
                        instance.setStatus(status);
                        instance.setActivate("0");
                        xdoDao.saveOrUpdateObject(instance);
                        taskDynamic.setTaskActivityInstance(instance);
                        //设置当前用户 该任务实例 的问题状态 为 已执行
                        TaskActivityInstanceExecution taskActivityInstanceExecution = taskDao.getTaskActivityInstanceExecution(instance.getId());
                        if(taskActivityInstanceExecution!=null){
                            taskActivityInstanceExecution.setStatus("1");
                            xdoDao.saveOrUpdateObject(taskActivityInstanceExecution);
                        }
                    }else {
                        if("1".equals(instance.getActivate())){
                            isNext = false;
                        }
                    }
                }

            }


            //当前节点任务实例设置为 未激活状态
//            taskActivityInstance.setActivate("0");
//            xdoDao.saveOrUpdateObject(taskActivityInstance);

            //问题
//            TaskActivityInstanceExecution taskActivityInstanceExecution = taskDao.getTaskActivityInstanceExecution(taskActivityInstance.getId());
//            if(taskActivityInstanceExecution!=null){
//                taskActivityInstanceExecution.setStatus("1");
//                xdoDao.saveOrUpdateObject(taskActivityInstanceExecution);
//            }
            if(isNext) {
                //所有节点
                List<FlowActivity> flowActivityList = task.getFlow().getActivityList();
                //当前所处节点位置
//            Integer sort = taskActivityInstance.getFlowActivity().getSort();
                Integer sort = currentActivity.getSort();
                //下一个节点
                FlowActivity nextFlowActivity = null;
                for (FlowActivity flowActivity : flowActivityList) {
                    if (flowActivity.getSort() == sort + 1) {
                        nextFlowActivity = flowActivity;
                        break;
                    }
                }

                //判断是否为最后一个节点

                if (nextFlowActivity == null) {
                    task.setCurrentUser(null);
                    task.setCurrentActivity(null);
                    xdoDao.saveOrUpdateObject(task);
                } else {
                    //下一个节点的第一个人为默认
//                    task.setCurrentUser(nextFlowActivity.getUser().get(0));
//                    xdoDao.saveOrUpdateObject(task);

                    //设置任务 下一个实例节点 为 当前节点
                    task.setCurrentActivity(nextFlowActivity);
                    xdoDao.saveOrUpdateObject(task);
                    //创建下一节点的任务实例
                    for (User nextUser : nextFlowActivity.getUser()) {

                        TaskActivityInstance nextTaskActivityInstance = new TaskActivityInstance();
                        nextTaskActivityInstance.setActivate("1");
                        //创建人默认为当前用户
                        nextTaskActivityInstance.setExcutor(nextUser);
                        nextTaskActivityInstance.setStatus("1");
                        nextTaskActivityInstance.setCreateDatetime(new Date());
                        nextTaskActivityInstance.setTask(task);
                        nextTaskActivityInstance.setFlowActivity(nextFlowActivity);
                        xdoDao.saveOrUpdateObject(nextTaskActivityInstance);
//                        task.setCurrentInstance(nextTaskActivityInstance);
//                        xdoDao.saveOrUpdateObject(task);

                        //问题
                        TaskActivityInstanceExecution taskActivityInstanceExecution1 = new TaskActivityInstanceExecution();
                        taskActivityInstanceExecution1.setTaskActivityInstance(nextTaskActivityInstance);
                        taskActivityInstanceExecution1.setTask(task);
                        taskActivityInstanceExecution1.setCreateDatetime(new Date());
                        taskActivityInstanceExecution1.setStatus("0");
                        taskActivityInstanceExecution1.setUser(nextUser);
                        xdoDao.saveOrUpdateObject(taskActivityInstanceExecution1);
                    }
                    message += ",并进入下一个节点:" + nextFlowActivity.getTitle();


//                    //问题
//                    TaskActivityInstanceExecution taskActivityInstanceExecution1 = new TaskActivityInstanceExecution();
//                    taskActivityInstanceExecution1.setTaskActivityInstance(nextTaskActivityInstance);
//                    taskActivityInstanceExecution1.setTask(task);
//                    taskActivityInstanceExecution1.setCreateDatetime(new Date());
//                    taskActivityInstanceExecution1.setStatus("0");
//                    taskActivityInstanceExecution1.setUser(task.getCurrentUser());
//                    xdoDao.saveOrUpdateObject(taskActivityInstanceExecution1);


//                //创建下一个节点 动态
//                TaskDynamic nextTaskDynamic = new TaskDynamic();
//                nextTaskDynamic.setMessage("任务进入下一个节点");
//                nextTaskDynamic.setCreateDatetime(new Date());
//                nextTaskDynamic.setCreator(AuthorizationUtil.getUser());
//                nextTaskDynamic.setTask(task);
//                nextTaskDynamic.setTaskActivityInstance(nextTaskActivityInstance);
//                xdoDao.saveOrUpdateObject(nextTaskDynamic);
                }
            }else {

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


    @Override
    public void removeTask(String taskId){
        Task task = (Task)xdoDao.getObject(Task.class.getName(),taskId);
        task.setStatus("0");
        xdoDao.saveOrUpdateObject(task);

        TaskActivityInstance taskActivityInstance = task.getCurrentInstance();
        taskActivityInstance.setStatus("5");
        xdoDao.saveOrUpdateObject(taskActivityInstance);
        //动态
        TaskDynamic taskDynamic = new TaskDynamic();
        taskDynamic.setMessage("删除了任务");
        taskDynamic.setTaskActivityInstance(taskActivityInstance);
        taskDynamic.setTask(task);
        taskDynamic.setCreator(AuthorizationUtil.getUser());
        taskDynamic.setCreateDatetime(new Date());
        xdoDao.saveOrUpdateObject(taskDynamic);
    }

}
