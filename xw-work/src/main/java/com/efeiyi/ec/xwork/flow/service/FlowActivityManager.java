package com.efeiyi.ec.xwork.flow.service;

import com.efeiyi.ec.xw.flow.model.FlowActivity;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/12/2.
 */
public interface FlowActivityManager {

    void createFlowActivity(Map map)throws Exception;
    FlowActivity getFlowActivity(String index)throws Exception;
}
