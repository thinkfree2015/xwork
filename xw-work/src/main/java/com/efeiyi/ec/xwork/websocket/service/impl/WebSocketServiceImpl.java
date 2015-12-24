package com.efeiyi.ec.xwork.websocket.service.impl;

import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xwork.websocket.service.WebSocketService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2015/12/24.
 */
@Service
public class WebSocketServiceImpl implements WebSocketService {

    @Override
    public List<User> getAllUsers() throws Exception {
        return null;
    }

    @Override
    public int getUnReadNews(String username) throws Exception {
        return 0;
    }
}
