package com.efeiyi.ec.xwork.process;

import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xw.flow.model.FlowActivity;
import com.efeiyi.ec.xw.task.model.Task;
import com.efeiyi.ec.xwork.flow.service.FlowManager;
import com.efeiyi.ec.xwork.flow.service.impl.FlowManagerImpl;
import com.efeiyi.ec.xwork.util.ContextUtils;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.impl.BaseManagerImpl;
import org.apache.log4j.Logger;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.WebApplicationInitializer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/12/3.
 *
 */
@Service
public class ProcessEngine implements WebApplicationInitializer,ApplicationContextAware{
    private static Logger log = Logger.getLogger(ProcessEngine.class);



    @Autowired
    private XdoDao xdoDao;
    @Autowired
    private FlowManager flowManager;


    //创建流程实例
    public void createFlow(Map map) throws  Exception{
        ((FlowManagerImpl)ContextUtils.getBean("flowManagerImpl")).createFlow(map);
    }

    //为任务搭建匹配的流程实例
    public Task TaskFlow(String taskId,String flowId)throws  Exception{
        Task task = (Task)xdoDao.getObject(Task.class.getName(),taskId);
        task.setFlow((Flow)xdoDao.getObject(Flow.class.getName(),flowId));
        xdoDao.saveOrUpdateObject(Task.class.getName(),task);
        return  task;
    }

    //根据任务获取相关流程实例
    public Flow getFlow(String taskId) throws  Exception{
        Flow flow = null;
        if (taskId!=null && !"".equals(taskId)) {
             flow = ((FlowManagerImpl)ContextUtils.getBean("flowManagerImpl")).getFlow(taskId);
        }

        return  flow;
    }
    //获取当前活动
    public FlowActivity getFlowActivity(String taskId)throws  Exception{
       return flowManager.getFlowActivity(taskId);
    }
    //获取特定用户的任务

    //完成任务

    //查询执行对象

    //查询任务历史

    //查询执行历史

    //流转规则




    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {

    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        ContextUtils.setApplicationContext(applicationContext);
        log.debug("ApplicationContext registed");
    }
}
