package com.efeiyi.ec.xwork.project.service;

import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xw.project.model.Project;
import com.efeiyi.ec.xw.project.model.ProjectUser;
import com.efeiyi.ec.xw.task.model.Task;

import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */
public interface ProjectManager {
   Project saveProject(Project project,String[] users);

    /**项目列表**/
   List<Project> getProject();
    /**添加任务**/
   Task saveTask(String taskGroupId,String title,String flowId,String userId);

    /**分配人员**/
    public User sendUser(String taskId,String userId);
}
