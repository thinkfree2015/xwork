package com.efeiyi.ec.xwork.flow.controller;

import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xw.flow.model.FlowActivity;
import com.efeiyi.ec.xw.organization.model.User;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/12/18.
 */
public class FlowHandle implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private Flow flow ;

    public Flow getFlow() {
        return flow;
    }

    public void setFlow(Flow flow) {
        this.flow = flow;
    }

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listUser_default", request);
        List<User> list = baseManager.listObject(xQuery);
        List<Map<User,String>> proList = new ArrayList<Map<User,String>>();
        List<Map<User,String>> uiList = new ArrayList<Map<User,String>>();
        List<Map<User,String>> webList = new ArrayList<Map<User,String>>();
        List<Map<User,String>> devList = new ArrayList<Map<User,String>>();
        List<Map<User,String>> testList = new ArrayList<Map<User,String>>();
        List<Map<User,String>> operateList = new ArrayList<Map<User,String>>();
        String id = request.getParameter("id");
        if (!StringTools.isEmpty(id)){
            flow = (Flow) baseManager.getObject(Flow.class.getName(),id);
        }
        List<FlowActivity> result = new ArrayList<FlowActivity>();
        List<FlowActivity> afList = this.flow.getActivityList();
        if (!StringTools.isEmpty(afList) && afList.size() > 0){
            for (FlowActivity fa : afList){
                if ("0".equals(fa.getStatus())){
                    result.add(fa);
                    modelMap.addAttribute("identity","0");
                }
            }
            if (result.size() != afList.size()){
                modelMap.addAttribute("result","show");
            }
        }
        if (!StringTools.isEmpty(list)) {
            for (User user : list) {
                Map<User,String> map = new HashMap<>();
                String flagg;
                if ("1".equals(String.valueOf(user.getGroupName()))) {
                    if (flow != null && flow.getId() != null){
                        flagg = equal(user);
                        map.put(user,flagg);
                    }else{
                        map.put(user,"");
                    }
                    proList.add(map);
                } else if ("2".equals(String.valueOf(user.getGroupName()))) {
                    if (flow != null && flow.getId() != null){
                        flagg = equal(user);
                        map.put(user,flagg);
                    }else{
                        map.put(user,"");
                    }
                    uiList.add(map);
                } else if ("3".equals(String.valueOf(user.getGroupName()))) {
                    if (flow != null && flow.getId() != null){
                        flagg = equal(user);
                        map.put(user,flagg);
                    }else{
                        map.put(user,"");
                    }
                    webList.add(map);
                } else if ("4".equals(String.valueOf(user.getGroupName()))) {
                    if (flow != null && flow.getId() != null){
                        flagg = equal(user);
                        map.put(user,flagg);
                    }else{
                        map.put(user,"");
                    }
                    devList.add(map);
                } else if ("5".equals(String.valueOf(user.getGroupName()))) {
                    if (flow != null && flow.getId() != null){
                        flagg = equal(user);
                        map.put(user,flagg);
                    }else{
                        map.put(user,"");
                    }
                    testList.add(map);
                } else if ("6".equals(String.valueOf(user.getGroupName()))) {
                    if (flow != null && flow.getId() != null){
                        flagg = equal(user);
                        map.put(user,flagg);
                    }else{
                        map.put(user,"");
                    }
                    operateList.add(map);
                }
            }
            modelMap.addAttribute("proList", proList);
            modelMap.addAttribute("uiList", uiList);
            modelMap.addAttribute("webList", webList);
            modelMap.addAttribute("devList", devList);
            modelMap.addAttribute("testList", testList);
            modelMap.addAttribute("operateList", operateList);
        }

        return modelMap;
    }
    public String equal(User user){
        List<User> list = this.flow.getNotifyUserList();
        String flag="";
        for (User user1 : list){
            if (user.getId() == user1.getId()){
                flag = "true";
                break;
            }
        }
        return flag;
    }

}
