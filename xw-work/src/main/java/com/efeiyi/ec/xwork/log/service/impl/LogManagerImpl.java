package com.efeiyi.ec.xwork.log.service.impl;

import com.efeiyi.ec.xwork.log.dao.LogDao;
import com.efeiyi.ec.xwork.log.service.LogManager;
import com.ming800.core.p.model.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: lxh
 * Date: 2010-1-15
 * Time: 13:41:03
 * To change this template use File | Settings | File Templates.
 */

@Service
public class LogManagerImpl implements LogManager {

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    @Autowired
    private LogDao logDao;
    @Override
    public void saveLog(String targetName,String operation) throws ParseException{

        Log log = new Log();
        //log.setUsername(AuthorizationUtil.getMyUser().getUsername());
        log.setCreateTime(sdf.parse(sdf.format(new Date())));
        log.setTargetName(targetName);
        log.setOperation(operation);
        logDao.saveLog(log);
    }
}
