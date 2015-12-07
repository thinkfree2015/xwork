package com.efeiyi.ec.xwork.project.controller;

import com.efeiyi.ec.xw.project.model.Project;
import com.efeiyi.ec.xwork.project.service.ProjectManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;


/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/project")
public class ProjectController extends BaseController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private ProjectManager projectManager;
    @RequestMapping("/saveProject.do")
    public  String saveProject(HttpServletRequest request,Project project,String resultPage){
        String [] memberList = request.getParameterValues("user");
        try {
            projectManager.saveProject(project,memberList);
        }catch (Exception e){
            e.printStackTrace();
        }
        return  resultPage;
    }


}
