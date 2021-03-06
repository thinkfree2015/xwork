package com.efeiyi.ec.xwork.flow.service;

import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xw.flow.model.FlowActivity;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/12/2.
 *
 */
public interface FlowManager {
     void createFlow(Map map)throws Exception;
     Flow getFlow(String begin)throws Exception;
     List<Flow> getAllFlows()throws Exception;
     void updateFlow(String old)throws Exception;
     FlowActivity getFlowActivity(String taskId)throws Exception;
}
