/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.efeiyi.ec.xwork.websocket.hndler;

import com.efeiyi.ec.xw.message.model.Message;
import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xwork.util.Constants;
import com.efeiyi.ec.xwork.websocket.service.WebSocketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;

/**
 *
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
    private HttpServletRequest request;
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        logger.debug("connect to the websocket success......");
        users.add(session);
        String userName = (String) session.getAttributes().get(Constants.WEBSOCKET_USERNAME);
        if(userName!= null){
            //查询未读消息
            int count = webSocketService.getUnReadNews((String) session.getAttributes().get(Constants.WEBSOCKET_USERNAME));

            session.sendMessage(new TextMessage("您有"+count + "条未读消息！"));
        }
    }

    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
        //这里做业务逻辑处理 1.即时消息 2.离线消息 3.通知页面改动
        saveMessageToOffLineUsers(message);
        sendMessageToUsers( new TextMessage(message.getPayload()+""));
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        if(session.isOpen()){
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
        for (WebSocketSession user : users) {
           if (user.getAttributes().get(Constants.WEBSOCKET_USERNAME).equals(userName)) {
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


    /**
     * 给所有离线用户发保存消息
     *
     * @param message
     */
    public void saveMessageToOffLineUsers(WebSocketMessage<?> message)throws Exception{
        List<User> allUsers = webSocketService.getAllUsers();
        //对 message进行处理 转化

        for (WebSocketSession user : users) {
            for (User user1:allUsers){
                try {
                    Message message1 = new Message();

                    if (user.getAttributes().get(Constants.WEBSOCKET_USERNAME).equals(user1.getUsername())){
                        if (user.isOpen()) {
                            user.sendMessage(message);
                        }
                        message1.setStatus("2");
                        webSocketService.saveMessageForOffLineUser(message1);
                    }else{
                        message1.setStatus("1");
                        webSocketService.saveMessageForOffLineUser(message1);
                    }

                } catch (IOException e) {
                    e.printStackTrace();
                }
            }


        }
    }
}
