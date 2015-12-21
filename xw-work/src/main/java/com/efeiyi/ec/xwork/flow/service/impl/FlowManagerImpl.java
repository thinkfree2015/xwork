package com.efeiyi.ec.xwork.flow.service.impl;

import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xw.flow.model.FlowActivity;
import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xw.task.model.Task;
import com.efeiyi.ec.xwork.flow.service.FlowActivityManager;
import com.efeiyi.ec.xwork.flow.service.FlowManager;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentLinkedQueue;

/**
 * Created by Administrator on 2015/12/2.
 *
 */
@Service
public class FlowManagerImpl implements FlowManager {
    private static Logger logger = Logger.getLogger(FlowManagerImpl.class);
    @Autowired
    private BaseManager baseManager;
    @Override
    public void createFlow(Map map) throws Exception{
        Flow flow;
        if (StringTools.isEmpty(map.get("flowId"))){
            flow = new Flow();
        }else{
            flow = (Flow) baseManager.getObject(Flow.class.getName(),String.valueOf(map.get("flowId")));
        }
        if (map!=null || map.size()==0){
            List<FlowActivity> flowActivities=null;
            //标准流程 添加标准的5个节点   产品 ui 前端 开发 测试 运维 运营
          if(map.get("begin")!=null&& !"".equals(map.get("begin"))){
               flowActivities = flowActivityManager.getFlowActivitys(map.get("begin").toString());
          }
            flow.setActivityList(flowActivities);
            flow.setTitle(map.get("title")!=null && !"".equals(map.get("title")) ? map.get("title").toString():"");
            List<User> users = (List<User>) map.get("users");
            flow.setNotifyUserList(users);//为流程选择成员
            flow.setStatus("1");//立即生效
        }
        baseManager.saveOrUpdate(Flow.class.getName(),flow);
    }

    @Override
    public Flow getFlow(String taskId)throws Exception {
        Task task =  (Task)baseManager.getObject(Task.class.getName(), taskId);
        return task.getFlow();
}

    @Override
    public List<Flow> getAllFlows() throws Exception{
        return null;
    }

    @Override
    public void updateFlow(String old)throws Exception {

    }
    private ConcurrentLinkedQueue<FlowActivity> createFlowActivitys(){
        return null;
    }
    @Override
    public FlowActivity getFlowActivity(String taskId) throws Exception {
        Task task =null;
        if (taskId!=null && !"".equals(taskId)){
             task =  (Task)baseManager.getObject(Task.class.getName(), taskId);
        }
        List<FlowActivity> flowActivityList = task.getFlow().getActivityList();
        for (FlowActivity flowActivity :flowActivityList){
            if ("1".equals(flowActivity.getStatus()))//状态为1是激活
              break;
            return  flowActivity;

        }
        logger.info("pleale check no active  FlowActivity find");
        return new FlowActivity();
    }
}
