package com.efeiyi.ec.xwork.project.service;

import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xw.project.model.Project;
import com.efeiyi.ec.xw.task.model.Task;

/**
 * Created by Administrator on 2015/8/17.
 */
public interface ProjectManager {
   Project saveProject(Project project,String[] users);

    /**添加任务**/
   Task saveTask(String taskGroupId,String title,String flowId,String userId);

    /**分配人员**/
    public User sendUser(String taskId,String userId);
}
