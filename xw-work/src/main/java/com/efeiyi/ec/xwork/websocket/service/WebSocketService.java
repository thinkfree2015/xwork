package com.efeiyi.ec.xwork.websocket.service;

import com.efeiyi.ec.xw.organization.model.User;

import java.util.List;

/**
 * Created by Administrator on 2015/12/24.
 */
public interface WebSocketService {
   List<User> getAllUsers()throws  Exception;
    int getUnReadNews(String username)throws  Exception;
}