package com.efeiyi.ec.xwork.task.service.impl;

import com.efeiyi.ec.xw.task.model.Task;
import com.efeiyi.ec.xwork.task.service.TaskManager;
import com.ming800.core.base.dao.XdoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * Created by Administrator on 2015/12/7.
 *
 */
@Service
public class TaskManagerImpl implements TaskManager {
    @Autowired
    private XdoDao xdoDao;
    @Override
    public Task createTask(Map map) throws Exception {
        Task task = new Task();
        if (map!=null && !map.isEmpty()){

        }
        xdoDao.saveOrUpdateObject(Task.class.getName(),task);
        return task;
    }
}
