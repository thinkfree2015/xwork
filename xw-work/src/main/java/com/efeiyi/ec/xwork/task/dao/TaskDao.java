package com.efeiyi.ec.xwork.task.dao;


import com.efeiyi.ec.xw.organization.model.MyUser;
import com.efeiyi.ec.xw.task.model.TaskActivityInstanceExecution;
import com.ming800.core.base.dao.BaseDao;

import java.util.LinkedHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-16
 * Time: 下午4:18
 * To change this template use File | Settings | File Templates.
 */
public interface TaskDao  {

    public TaskActivityInstanceExecution getTaskActivityInstanceExecution(String taskInstanceId);

}
