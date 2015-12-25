package com.efeiyi.ec.xwork.websocket.service;

import com.efeiyi.ec.xw.message.model.Message;
import com.efeiyi.ec.xw.organization.model.User;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/12/24.
 */
public interface WebSocketService {
    List<User> getAllUsers(HttpServletRequest request)throws  Exception;
    int getUnReadNews(String username)throws  Exception;
    void saveMessageForOffLineUser(Message message)throws  Exception;
}
