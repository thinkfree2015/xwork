package com.efeiyi.ec.xwork.task.controller;

import com.efeiyi.ec.xw.organization.model.MyUser;
import com.efeiyi.ec.xw.project.model.Project;
import com.efeiyi.ec.xw.project.model.ProjectUser;
import com.efeiyi.ec.xw.task.model.Task;
import com.efeiyi.ec.xw.task.model.TaskActivityInstanceExecution;
import com.efeiyi.ec.xw.task.model.TaskGroup;
import com.efeiyi.ec.xwork.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/12/29.
 */
@Controller
public class TaskActivityInstanceExecutionController {

    @Autowired
    private BaseManager baseManager;

    @ResponseBody
    @RequestMapping("/taskActivityInstanceExecution/{projectId}")
    public List<TaskActivityInstanceExecution> findOnlyProjectData(@PathVariable String projectId, HttpServletRequest request) throws Exception {
        List<TaskActivityInstanceExecution> list = new ArrayList<>();
        MyUser user = AuthorizationUtil.getMyUser();
        if (!"0".equals(projectId)) {
            String hql = "from TaskGroup g where g.project.id=:projectId";
            LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
            queryMap.put("projectId", projectId);
            List<TaskGroup> groups = baseManager.listObject(hql, queryMap);
            if (!StringTools.isEmpty(groups) && groups.size() > 0) {
                for (TaskGroup group : groups) {
                    if (!StringTools.isEmpty(group.getTaskList()) && group.getTaskList().size() > 0) {
                        for (Task task : group.getTaskList()) {
                            XQuery xQuery = new XQuery("listTaskActivityInstanceExecution_default", request);
                            xQuery.put("task_id", task.getId());
                            List<TaskActivityInstanceExecution> executions = baseManager.listObject(xQuery);
                            if (!StringTools.isEmpty(executions) && executions.size() > 0) {
                                for (TaskActivityInstanceExecution execution : executions) {
                                    if ((user.getId()).equals(execution.getUser().getId())) {
                                        execution.setTaskId(task.getId());
                                        execution.setTaskTitle(task.getTitle());
                                        execution.setTaskContent(task.getContent());
                                        list.add(execution);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            XQuery xQuery = new XQuery("listProjectUser_byUser", request);
            xQuery.put("user_id", user.getId());
            List<ProjectUser> projectUsers = baseManager.listObject(xQuery);
            if (!StringTools.isEmpty(projectUsers) && projectUsers.size() > 0) {
                for (ProjectUser projectUser : projectUsers) {
                    Project project = (Project) baseManager.getObject(Project.class.getName(), projectUser.getProject().getId());
                    String hql = "from TaskGroup g where g.project.id=:projectId";
                    LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
                    queryMap.put("projectId", project.getId());
                    List<TaskGroup> groups = baseManager.listObject(hql, queryMap);
                    if (!StringTools.isEmpty(groups) && groups.size() > 0) {
                        for (TaskGroup group : groups) {
                            if (group.getTaskList() != null && group.getTaskList().size() > 0) {
                                for (Task task : group.getTaskList()) {
                                    XQuery query = new XQuery("listTaskActivityInstanceExecution_default", request);
                                    query.put("task_id", task.getId());
                                    List<TaskActivityInstanceExecution> executions = baseManager.listObject(query);
                                    if (!StringTools.isEmpty(executions) && executions.size() > 0) {
                                        for (TaskActivityInstanceExecution execution : executions) {
                                            if ((user.getId()).equals(execution.getUser().getId())) {
                                                execution.setTaskId(task.getId());
                                                execution.setTaskTitle(task.getTitle());
                                                execution.setTaskContent(task.getContent());
                                                list.add(execution);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return list;
    }

}
