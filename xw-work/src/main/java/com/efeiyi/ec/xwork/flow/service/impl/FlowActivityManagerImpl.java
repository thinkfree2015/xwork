package com.efeiyi.ec.xwork.flow.service.impl;

import com.efeiyi.ec.xw.flow.model.FlowActivity;
import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xwork.flow.service.FlowActivityManager;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/12/2.
 *
 */
@Service
public class FlowActivityManagerImpl implements FlowActivityManager {
    private static Logger logger = Logger.getLogger(FlowManagerImpl.class);
    @Autowired
    private XdoDao xdoDao;

    @Autowired
    private BaseManager baseManager;


    @Override
    public void createFlowActivity(Map map)throws Exception{//测试使用
        logger.info("create flowActivity begin");
//        int index = Integer.parseInt(map.get("sort").toString());
//        FlowActivity  flowActivity = new FlowActivity();
//        if (map==null){
//            logger.info("args is null");
//        }
//        flowActivity.setTitle(map.get("title")!=null&& !"".equals(map.get("title").toString())?map.get("title").toString():"");
//        flowActivity.setType(map.get("type") != null && !"".equals(map.get("type").toString()) ? map.get("type").toString() : "");
//        if(map.get("sort")!=null && !"".equals(map.get("type"))){
//            flowActivity.setSort(index);
//        }
//        //获取默认任的该节点的用户
//        List<User> users = xdoDao.getObjectList("from User where groupName=? and status!='0' order by id desc", new Object[]{index});
//        flowActivity.setUser(users);
//        baseManager.saveOrUpdate(FlowActivity.class.getName(),flowActivity);
        logger.info("create flowActivity success");
    }
    /**
     * 生成流程节点   默认
     * @param index is sort
     *根据用户选择的流程创建相应节点
     */
    @Override
    public FlowActivity getFlowActivity(String index) throws Exception {
        //return  xdoDao.getObjectList("from FlowActivity where sort>=? order by id desc", new Object[]{ Integer.parseInt(index)});

        int begin = Integer.parseInt(index);
            FlowActivity  flowActivity = new FlowActivity();
            String title;
           switch (begin){
               case 1:
                   title="运营组";
                   break;
               case 2:
                   title="产品组";
                   break;
               case 3:
                   title="UI设计组";
                   break;
               case 4:
                   title="前端开发组";
                   break;
               case 5:
                   title="开发组";
                   break;
               case 6:
                   title="测试组";
                   break;
             default:title="运维组";
            }
            flowActivity.setTitle(title);
            flowActivity.setType("one");
            flowActivity.setSort(1);
            flowActivity.setStatus("1");
            //获取默认任的该节点的用户
            List<User> users = xdoDao.getObjectList("from User where groupName=? and status!='0' order by id desc", new Object[]{index});
            flowActivity.setUser(users);
            baseManager.saveOrUpdate(FlowActivity.class.getName(),flowActivity);
        return  flowActivity;
    }


}
