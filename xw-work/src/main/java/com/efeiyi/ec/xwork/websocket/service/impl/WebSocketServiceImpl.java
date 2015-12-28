package com.efeiyi.ec.xwork.websocket.service.impl;

import com.efeiyi.ec.xw.message.model.Message;
import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xwork.websocket.service.WebSocketService;
import com.ming800.core.base.dao.hibernate.XdoDaoSupport;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/12/24.
 *
 */
@Service
public class WebSocketServiceImpl implements WebSocketService {
    @Autowired
    private BaseManager baseManager;
    @Autowired
    private XdoDaoSupport xdoDao;
    @Override
    public List<User> getAllUsers(HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listUser_default",request);
        List<User> list = baseManager.listObject(xQuery);
        return list;
    }

    @Override
    public int getUnReadNews(String username) throws Exception {
        try{
        Query query = xdoDao.getSession().createSQLQuery(" select a.* from xw_message a LEFT  join xw_user u on a.receiver_id = u.id where a.status=? and u.username=?")
                .addEntity(Message.class);
        query.setString(0,"1");
        query.setString(1, username);
        List<Message> messages = (List<Message>)query.list();
        if (messages!=null && !messages.isEmpty())
            return  messages.size();

        }catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public void saveMessageForOffLineUser(Message message) throws Exception {
        baseManager.saveOrUpdate(Message.class.getName(),message);
    }
}
