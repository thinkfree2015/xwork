package com.efeiyi.ec.xwork.flow.controller;

import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xwork.model.Flow.FlowParamBean;
import com.efeiyi.ec.xwork.process.ProcessEngine;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2015/12/8.
 *
 */
@Controller
public class FlowActivityController {
    @Autowired
    private ProcessEngine processEngine;
    @Autowired
    private BaseManager baseManager;
       @RequestMapping({"/flow/createFlowActivity.do"})
    private String createFlow(HttpServletRequest request)throws  Exception{
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("title",request.getParameter("title")!=null?request.getParameter("title"):"");
        map.put("sort",request.getParameter("sort")!=null?request.getParameter("sort"):'0');
        map.put("type",request.getParameter("type")!=null?request.getParameter("type"):"");
        processEngine.createFlowActivity(map);
        return "/flow/flowActivityPList";
    }

    @ResponseBody
    @RequestMapping({"/flow/removeFlowActivity/{flowId}"})
    private String removeFlow(@PathVariable String flowId, HttpServletRequest request)throws  Exception{
        baseManager.remove(Flow.class.getName(),flowId);
        return "succ";
    }

    @RequestMapping({"/flow/newFlowActivity.do"})
    private String showNewFlowFrom()throws  Exception{
        return "/flow/flowActivityFrom";
    }

}
