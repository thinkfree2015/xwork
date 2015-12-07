package com.efeiyi.ec.xwork.project.service;

import com.efeiyi.ec.xw.project.model.Project;

/**
 * Created by Administrator on 2015/8/17.
 */
public interface ProjectManager {
   Project saveProject(Project project,String[] users);
}
