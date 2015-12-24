package com.efeiyi.ec.xwork.task.service;

import com.efeiyi.ec.xw.task.model.Task;

import java.util.Map;

/**
 * Created by Administrator on 2015/12/7.
 *
 */
public interface TaskManager {
    Task createTask(Map map)throws Exception;

    public Task changeTaskInstanceStatus(String taskId,String status);
}
