/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.efeiyi.ec.xwork.websocket.hndler;

import com.alibaba.fastjson.JSONObject;
import com.efeiyi.ec.xw.message.model.Message;
import com.efeiyi.ec.xw.message.model.UserMessage;
import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xwork.organization.util.AuthorizationUtil;
import com.efeiyi.ec.xwork.util.Constants;
import com.efeiyi.ec.xwork.websocket.service.WebSocketService;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;

/**
 * @author kayson
 */
@Component
public class SystemWebSocketHandler implements WebSocketHandler {

    private static final Logger logger;

    private static final ArrayList<WebSocketSession> users;

    static {
        users = new ArrayList<>();
        logger = Logger.getLogger(SystemWebSocketHandler.class);
    }

    @Autowired
    private WebSocketService webSocketService;
    @Autowired
    private BaseManager baseManager;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        logger.debug("connect to the websocket success......");
        users.add(session);
        String userName = (String) session.getAttributes().get(Constants.WEBSOCKET_USERNAME);
        if (userName != null) {
            //查询未读消息
            int count = webSocketService.getUnReadNews((String) session.getAttributes().get(Constants.WEBSOCKET_USERNAME));
            if (count > 0){
                session.sendMessage(new TextMessage("您有" + count + "条未读消息！"));
            }
        }
    }

    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
        try {
            //这里做业务逻辑处理 1.即时消息 2.离线消息 3.通知页面改动
            String msg = message.getPayload().toString();
            JSONObject jasonObject = (JSONObject) JSONObject.parse(msg);
            Message message1 = new Message();//对 message进行处理 转化
            if (jasonObject.getString("content") != null) {
                message1.setContent(jasonObject.getString("content"));
            } else {
                message1.setContent("");
            }
            message1.setCreateDatetime(new Date());
            message1.setType("1");//暂时都默认为文本消息
            User user = webSocketService.getUser((String) session.getAttributes().get(Constants.WEBSOCKET_USERNAME));
            message1.setCreator(user);
            //传参为id
            if(jasonObject.getString("id")!=null&&!"".equals(jasonObject.getString("id"))) {
                String[] ids = jasonObject.getString("id").substring(1, jasonObject.getString("id").length() - 1).split(",");
            }
            String receiver = jasonObject.getString("receiver") == null ? "" : jasonObject.getString("receiver");
            if (receiver != null && !"".equals(receiver)) {//消息不指定接收者，默认发送所有人
                saveMessageForReceiver(receiver, message1);
                sendMessageToUser(receiver, new TextMessage(message.getPayload() + ""));
            } else {
                saveMessageToOffLineUsers(message1);
                sendMessageToUsers(new TextMessage(message.getPayload() + ""));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        if (session.isOpen()) {
            session.close();
        }
        logger.debug("websocket connection closed......");
        users.remove(session);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
        logger.debug("websocket connection closed......");
        users.remove(session);
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }

    /**
     * 给所有在线用户发送消息
     *
     * @param message
     */
    public void sendMessageToUsers(TextMessage message) {
        for (WebSocketSession user : users) {
            try {
                if (user.isOpen()) {
                    user.sendMessage(message);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 给某个用户发送消息
     *
     * @param userName
     * @param message
     */
    public void sendMessageToUser(String userName, TextMessage message) {
        String[] args = userName.substring(1, userName.length() - 1).split(",");
        for (int i = 0; i < args.length; i++) {
            for (WebSocketSession user : users) {
                if (user.getAttributes().get(Constants.WEBSOCKET_USERNAME).equals(args[i])) {
                    try {
                        if (user.isOpen()) {
                            user.sendMessage(message);
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    break;
                }
            }
        }

    }


    /**
     * 给所有离线用户保存消息
     *
     * @param message1
     */
    public void saveMessageToOffLineUsers(Message message1) throws Exception {

        List<User> allUsers = webSocketService.getAllUsers();
        for (WebSocketSession user : users) {
            for (User user1 : allUsers) {
                try {
                    UserMessage userMessage = new UserMessage();
                    if (user.getAttributes().get(Constants.WEBSOCKET_USERNAME).equals(user1.getUsername())) {
                        if (user.isOpen()) {
                            message1.setStatus("2");
                        }

                    } else {
                        message1.setStatus("1");

                    }
                    userMessage.setUser(user1);
                    userMessage.setMessage(message1);
                    baseManager.saveOrUpdate(Message.class.getName(), message1);
                    baseManager.saveOrUpdate(UserMessage.class.getName(), userMessage);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }


        }
    }

    /**
     * 保存某个用户的信息
     *
     * @param message1
     */
    public void saveMessageForReceiver(String username, Message message1) throws Exception {

        String[] args = username.substring(1, username.length() - 1).split(",");
        for (int i = 0; i < args.length; i++) {
            User u = webSocketService.getUser(args[i]);
            UserMessage userMessage = new UserMessage();
            for (WebSocketSession user : users) {
                try {
                    if (u.getUsername().equals(user.getAttributes().get(Constants.WEBSOCKET_USERNAME))) {
                        message1.setStatus("2");
                        userMessage.setStatus("2");
                    } else {
                        message1.setStatus("1");
                        userMessage.setStatus("1");
                    }
                    userMessage.setUser(u);
                    userMessage.setMessage(message1);
                    baseManager.saveOrUpdate(Message.class.getName(), message1);
                    baseManager.saveOrUpdate(UserMessage.class.getName(), userMessage);
                    break;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
