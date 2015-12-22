package com.efeiyi.ec.xwork.flow.controller;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/12/17.
 */
public class FlowActivityHandle implements DoHandler {
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String qm = request.getParameter("qm");
        if (qm.startsWith("form")){
            modelMap.addAttribute("flowId",request.getParameter("flowId"));
        }else if(qm.startsWith("saveOrUpdate")){
            modelMap.addAttribute("flowId",request.getParameter("flow.id"));
        }
        return modelMap;
    }
}
