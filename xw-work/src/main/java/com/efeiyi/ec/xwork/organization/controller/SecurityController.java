package com.efeiyi.ec.xwork.organization.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/14.
 */
@Controller
public class SecurityController {


    @RequestMapping({"/pc/login.do"})
    public String login(HttpServletRequest request){

        return "/login";

    }

}
