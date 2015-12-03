package com.efeiyi.ec.xwork.schedule.impl;

import com.efeiyi.ec.xw.task.model.Task;
import com.efeiyi.ec.xwork.schedule.OverdueTaskCheck;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/12/3.
 *
 */
public class OverdueTaskCheckImpl implements OverdueTaskCheck {
    /*@Scheduled(cron="0 0/10 * * * *") */
    @Override
    public Task taskCheck() throws Exception {
        return null;
    }
}
