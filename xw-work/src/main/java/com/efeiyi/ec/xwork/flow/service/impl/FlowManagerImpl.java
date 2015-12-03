package com.efeiyi.ec.xwork.flow.service.impl;

import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xw.flow.model.FlowActivity;
import com.efeiyi.ec.xw.task.model.Task;
import com.efeiyi.ec.xwork.flow.service.FlowActivityManager;
import com.efeiyi.ec.xwork.flow.service.FlowManager;
import com.ming800.core.base.service.BaseManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
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
    @Autowired
    private FlowActivityManager flowActivityManager;
    @Override
    public void addFlow(String... type) throws Exception{
        Flow flow = new Flow();
        if (type==null || type.length==0){//标准流程 添加标准的5个节点   产品 ui 前端 开发 测试
            List<FlowActivity> list = flowActivityManager.getFlowActivitys();

        }
        if (type!=null && type.length==1){
         for (String s :type){

         }

        }
   /*  if (type!=null && !"".equals(type)){
         switch (type){
             case "standard":
                 flow.setTitle("标准流程");
                 break;
             case "short":

                 break;
             default:

         }

     }else{

     }*/
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
            if ("1".equals(flowActivity.getStatus()))
              break;
            return  flowActivity;

        }
        logger.info("pleale check no active  FlowActivity find");
        return new FlowActivity();
    }
}
