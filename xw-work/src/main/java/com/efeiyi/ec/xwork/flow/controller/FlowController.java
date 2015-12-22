package com.efeiyi.ec.xwork.flow.controller;

import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xwork.model.Flow.FlowParamBean;
import com.efeiyi.ec.xwork.process.ProcessEngine;
import com.ming800.core.base.service.BaseManager;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/12/8.
 *
 */
@Controller
public class FlowController {
    @Autowired
    private ProcessEngine processEngine;
    @Autowired
    private BaseManager baseManager;
    @RequestMapping({"/flow/createFlow.do"})
    private String createFlow(FlowParamBean paramBean,HttpServletRequest request)throws  Exception{
        Map<String,Object> map = new HashMap<>();
        map.put("title",request.getParameter("title"));
        String[] args = request.getParameterValues("user");
        List<User> list = new ArrayList<>();
        if (!StringTools.isEmpty(args) && args.length > 0){
            for(int i = 0;i<args.length;i++){
                User user = (User) baseManager.getObject(User.class.getName(),String.valueOf(args[i]));
                list.add(user);
            }
        }
        paramBean.setNotifyUserList(list);
        if (!StringTools.isEmpty(paramBean.getId())){
            map.put("flowId",paramBean.getId());
        }
        map.put("users",paramBean.getNotifyUserList());
        processEngine.createFlow(map);
        return "redirect:/basic/xm.do?qm=plistFlow_default";
    }

//    @ResponseBody
//    @RequestMapping({"/flow/removeFlow/{flowId}"})
//    private String removeFlow(@PathVariable String flowId, HttpServletRequest request)throws  Exception{
//        baseManager.remove(Flow.class.getName(),flowId);
//        return "succ";
//    }
//
//    @RequestMapping({"/flow/newFlow.do"})
//    private String showNewFlowFrom(ModelMap modelMap)throws  Exception{
//        MyUser user = AuthorizationUtil.getMyUser();
//        modelMap.addAttribute("myUser",user);
//        return "/flow/flowFrom";
//    }

}
