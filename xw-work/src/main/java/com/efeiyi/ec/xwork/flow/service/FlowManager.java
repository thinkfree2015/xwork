package com.efeiyi.ec.xwork.flow.service;

import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xw.flow.model.FlowActivity;
import org.apache.log4j.Logger;

import java.util.List;

/**
 * Created by Administrator on 2015/12/2.
 *
 */
public interface FlowManager {
     void addFlow(String... type)throws Exception;
     Flow getFlow(String begin)throws Exception;
     List<Flow> getAllFlows()throws Exception;
     void updateFlow(String old)throws Exception;
     FlowActivity getFlowActivity(String taskId)throws Exception;
}
