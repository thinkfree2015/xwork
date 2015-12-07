package com.efeiyi.ec.xwork.process;

import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xw.flow.model.FlowActivity;
import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xw.task.model.Task;
import com.efeiyi.ec.xw.task.model.TaskActivityInstance;
import com.efeiyi.ec.xwork.flow.service.FlowManager;
import com.efeiyi.ec.xwork.flow.service.impl.FlowManagerImpl;
import com.efeiyi.ec.xwork.util.ContextUtils;
import com.ming800.core.base.dao.XdoDao;
import org.apache.log4j.Logger;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Service;
import org.springframework.web.WebApplicationInitializer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import java.util.*;

/**
 * Created by Administrator on 2015/12/3.
 * 流程引擎
 */
@Service
public class ProcessEngine implements WebApplicationInitializer,ApplicationContextAware{
    private static Logger log = Logger.getLogger(ProcessEngine.class);
    @Autowired
    private XdoDao xdoDao;
    @Autowired
    private FlowManager flowManager;

    /**
     * 创建流程实例
     * @param map
     * @return "/wiki/everyArt"
     */
    public void createFlow(Map map) throws  Exception{
        ((FlowManagerImpl)ContextUtils.getBean("flowManagerImpl")).createFlow(map);
    }
    /**
     * 为任务搭建匹配的流程实例
     * @param taskId ,flowId
     * @return task
     */
    public Task TaskFlow(String taskId,String flowId)throws  Exception{
        Task task = (Task)xdoDao.getObject(Task.class.getName(),taskId);
        task.setFlow((Flow)xdoDao.getObject(Flow.class.getName(),flowId));
        xdoDao.saveOrUpdateObject(Task.class.getName(),task);
        return  task;
    }

    /**
     * 根据任务获取相关流程实例
     * @param taskId
     * @return flow
     */
    public Flow getFlow(String taskId) throws  Exception{
        Flow flow = null;
        if (taskId!=null && !"".equals(taskId)) {
             flow = ((FlowManagerImpl)ContextUtils.getBean("flowManagerImpl")).getFlow(taskId);
        }

        return  flow;
    }
    /**
     * 获取当前活动
     * @param taskId
     * @return FlowActivity
     */
    public FlowActivity getFlowActivity(String taskId)throws  Exception{
       return flowManager.getFlowActivity(taskId);
    }

    /**
     * 处理当前任务节点
     * @param TaskActivityInstanceId ,status
     * @return null
     */
    public void completeTask(String TaskActivityInstanceId,String status)throws  Exception{
        TaskActivityInstance activityInstance = (TaskActivityInstance)xdoDao.getObject(TaskActivityInstance.class.getName(),TaskActivityInstanceId);
        activityInstance.setStatus(status);
        xdoDao.saveOrUpdateObject(TaskActivityInstance.class.getName(),activityInstance);
    }
    /**
     * 创建新的任务接点
     * @param map
     * @return activityInstance
     */
    public TaskActivityInstance createTask(Map map)throws  Exception{
        TaskActivityInstance activityInstance = new TaskActivityInstance();
        if (map!=null && !map.isEmpty()){
            activityInstance.setStatus("0");//初始化为未处理  0未处理 1正在处理 2搁置 3已完成 4已放弃
            activityInstance.setContent(map.get("content")!=null ? map.get("content").toString():"");
            activityInstance.setContent(map.get("issue")!=null ? map.get("issue").toString():"");
            if (map.get("excutor")!=null&& !"".equals(map.get("excutor").toString())){
                User user = (User)xdoDao.getObject(User.class.getName(),map.get("excutor").toString());
                activityInstance.setExcutor(user);
                activityInstance.setCreateDatetime(new Date());
            }

        }
        xdoDao.saveOrUpdateObject(TaskActivityInstance.class.getName(),activityInstance);
        return activityInstance;
    }



    /**
     * 流转处理
     * @param taskId ,next
     * @return nextFlowActivity
     */
    public FlowActivity flowRule(String taskId,String next)throws  Exception{

        if(taskId==null && !"".equals(taskId) && next==null && !"".equals(next)){

            log.info("args is null,please check again");
            return null;
         }
        int nexts = Integer.parseInt(next);//下一流程节点
        //获取当前流程节点
        FlowActivity flowActivity = getFlowActivity(taskId);
        int location = flowActivity.getSort();
        Flow flow = flowActivity.getFlow();
        //目前简化流转规则
        //结束当前节点，激活指定节点  <--- or --->
        flowActivity.setStatus("0");
        FlowActivity nextFlowActivity = flow.getActivityList().get(nexts);
        nextFlowActivity.setStatus("1");
        xdoDao.saveOrUpdateObject(FlowActivity.class.getName(),flowActivity);
        xdoDao.saveOrUpdateObject(FlowActivity.class.getName(),nextFlowActivity);

        return nextFlowActivity;
    }

    /**
     * 查询执行对象
     * @param TaskActivityInstanceId
     * @return user
     */
    public User getExcutor(String TaskActivityInstanceId)throws  Exception{
        TaskActivityInstance activityInstance =(TaskActivityInstance) xdoDao.getObject(TaskActivityInstance.class.getName(),TaskActivityInstanceId);
        User excutor = activityInstance.getExcutor();
        return excutor;
    }



    /**
     * 查询执行历史
     * @param taskId
     * @return task
     */
    public List<TaskActivityInstance> getTaskActivityList(String taskId)throws  Exception{
     return ((Task)xdoDao.getObject(Task.class.getName(),taskId)).getTaskActivityList();
    }



    /**
     * 获取特定用户的任务
     * @param userId
     * @return tasks
     */
    public Set<Task> getTaskList(String userId)throws  Exception{
         List<TaskActivityInstance>  activityInstanceList =(List<TaskActivityInstance>) xdoDao.getObjectList("from User where excutor_id=? and status!='3' or status!='4' order by id desc ", new Object[]{userId});
         Set<Task> tasks = new HashSet<Task>();
         for(TaskActivityInstance taskActivityInstance : activityInstanceList){
             Task task = taskActivityInstance.getTask();
             tasks.add(task);
         }
        return  tasks;
    }



    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {

    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        ContextUtils.setApplicationContext(applicationContext);
        log.debug("ApplicationContext registed");
    }
}
