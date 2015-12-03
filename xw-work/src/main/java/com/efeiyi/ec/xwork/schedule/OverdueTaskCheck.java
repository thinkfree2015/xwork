package com.efeiyi.ec.xwork.schedule;

import com.efeiyi.ec.xw.task.model.Task;

/**
 * Created by Administrator on 2015/12/3.
 *
 */
public interface OverdueTaskCheck {
    //定时扫描是否有过期任务
    Task taskCheck()throws  Exception;
}
