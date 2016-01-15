package com.efeiyi.ec.xwork.task.controller;

import com.efeiyi.ec.xw.organization.model.MyUser;
import com.efeiyi.ec.xw.project.model.Project;
import com.efeiyi.ec.xw.project.model.ProjectUser;
import com.efeiyi.ec.xwork.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/12/29.
 */
public class TaskActivityInstanceExecutionHandle implements DoHandler {
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        MyUser user = AuthorizationUtil.getMyUser();
        XQuery xQuery = new XQuery("listProjectUser_byUser",request);
        xQuery.put("user_id",user.getId());
        List<ProjectUser> list = baseManager.listObject(xQuery);
        List<Project> projectList = new ArrayList<>();
        if (!StringTools.isEmpty(list)&&list.size() > 0){
            for (ProjectUser projectUser : list){
                System.out.println("projectID: "+projectUser.getProject().getId());
                Project project = (Project) baseManager.getObject(Project.class.getName(),projectUser.getProject().getId());
                System.out.println(project.getTitle()+"==============");
                projectList.add(project);
            }
        }
        modelMap.addAttribute("myUser",user);
        modelMap.addAttribute("list",projectList);
        return modelMap;
    }
}
