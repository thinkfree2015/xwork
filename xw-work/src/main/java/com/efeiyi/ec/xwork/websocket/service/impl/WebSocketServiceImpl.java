package com.efeiyi.ec.xwork.websocket.service.impl;

import com.efeiyi.ec.xw.message.model.Message;
import com.efeiyi.ec.xw.message.model.UserMessage;
import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xwork.websocket.service.WebSocketService;
import com.ming800.core.base.dao.hibernate.XdoDaoSupport;
import com.ming800.core.base.service.BaseManager;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
    public List<User> getAllUsers() throws Exception {
        Query query = xdoDao.getSession().createQuery("FROM User u WHERE  u.status != '0'");
        List<User> list = query.list();
        return list;
    }

    @Override
    public int getUnReadNews(String username) throws Exception {
        try{
        Query query = xdoDao.getSession().createQuery(" from UserMessage a where a.status=? and a.user.username=?");
        query.setString(0,"1");
        query.setString(1, username);
        List<UserMessage> messages = (List<UserMessage>)query.list();
        List<Message> m = new ArrayList<Message>();

        if (messages!=null && !messages.isEmpty()){
            for (UserMessage message:messages){
                m.add(message.getMessage());
            }
        }
            return m.size();
        }catch (Exception e){
            e.printStackTrace();
            return  0;
        }

    }

    @Override
    public void saveMessageForOffLineUser(Message message) throws Exception {
        baseManager.saveOrUpdate(Message.class.getName(),message);
    }

    @Override
    public User getUser(String username) throws Exception {
        Query query = xdoDao.getSession().createQuery("FROM User u WHERE u.username=?  and u.status != '0'");
        query.setString(0,username);
        User user = (User)query.uniqueResult();
        if (user!=null)
        return user;
        return new User();
    }
}
