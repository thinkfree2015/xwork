package com.efeiyi.ec.xwork.project.service.impl;


import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xw.project.model.Project;
import com.efeiyi.ec.xw.project.model.ProjectUser;
import com.efeiyi.ec.xwork.organization.util.AuthorizationUtil;
import com.efeiyi.ec.xwork.project.service.ProjectManager;
import com.ming800.core.base.dao.XdoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */
@Service
public class ProjectManagerImpl implements ProjectManager {


    @Autowired
    private XdoDao xdoDao;

    @Override
    public Project saveProject(Project project,String [] users){
       if("".equals(project.getId())){
           project.setId(null);
       }
        boolean f = false;
        xdoDao.saveOrUpdateObject(project);
        if(users!=null) {
            if (users.length > 0) {
                for (int i=0;i<users.length;i++){
                    if(users[i].equals(AuthorizationUtil.getMyUser().getId())){
                        if(!f){
                           f=true;
                        }else {
                            continue;
                        }
                    }
                    ProjectUser projectUser = new ProjectUser();
                    projectUser.setProject(project);
                    projectUser.setUser((User) xdoDao.getObject(User.class.getName(), users[i]));
                    xdoDao.saveOrUpdateObject(projectUser);


                }
            }
        }
        return  project;
    }

}
