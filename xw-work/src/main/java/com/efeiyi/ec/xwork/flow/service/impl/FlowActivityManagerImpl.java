package com.efeiyi.ec.xwork.flow.service.impl;

import com.efeiyi.ec.xw.flow.model.FlowActivity;
import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xwork.flow.service.FlowActivityManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/12/2.
 *
 */
@Service
public class FlowActivityManagerImpl implements FlowActivityManager {
    private static Logger logger = Logger.getLogger(FlowManagerImpl.class);
    @Autowired
    private HttpServletRequest request;
    @Autowired
    private BaseManager baseManager;


    @Override
    public void createFlowActivity(Map map)throws Exception{
        logger.info("create flowActivity begin");
        FlowActivity  flowActivity = new FlowActivity();
        if (map==null){
            logger.info("args is null");
            baseManager.saveOrUpdate(FlowActivity.class.getName(),flowActivity);
        }
        flowActivity.setTitle(map.get("title").toString());
        flowActivity.setType(map.get("type").toString());
        flowActivity.setUser((List<User>) map.get("users"));
        baseManager.saveOrUpdate(FlowActivity.class.getName(),flowActivity);
        logger.info("create flowActivity success");
    }

    @Override
    public List<FlowActivity> getFlowActivitys() throws Exception {
        XQuery xQuery = new XQuery("listFlowActivity_default",request);
        return  baseManager.listObject(xQuery);
    }


}
