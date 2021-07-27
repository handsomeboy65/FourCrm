package com.bjpowernode.web.controller;

import com.bjpowernode.pojo.User;
import com.bjpowernode.service.UserServer;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
public class LocationController {
    @Resource
    UserServer userServer;


    @RequestMapping("/**/*.html")
    public String LocationController(HttpServletRequest request){
        String uri = request.getRequestURI();
        String location = uri.substring(1, uri.indexOf("."));
        return location;

    }
    @RequestMapping("/")
//    *********************************
//    *********************************
//    验证cookie  给通过拦截器的令牌
    public String LoginFree(@CookieValue(name = "username",required = false)
                                        String username,
                             @CookieValue(name = "password",required = false)
                                        String password,HttpServletRequest request){


       if (StringUtils.isNoneBlank(username,password)){
           String ip = request.getRemoteAddr();
           User user = userServer.LoginFree(username, password, ip);
           if (user!=null) {
               request.getSession().setAttribute("user", user);
               return "redirect:/workbench/index.html";
           }
       }

        return "index";
    }

}
