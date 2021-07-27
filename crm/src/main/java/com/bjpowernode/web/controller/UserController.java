package com.bjpowernode.web.controller;

import com.bjpowernode.pojo.User;
import com.bjpowernode.service.UserServer;
import com.bjpowernode.utils.MD5Util;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("user")
public class UserController {
    @Resource
    UserServer userServer;
    @RequestMapping("login.do")
    //        if (StringUtils.isNoneBlank(user))loginAct
    //        forward——redirect
    @ResponseBody
    public Map longin(String username, String password,boolean loginTo,
                      HttpServletRequest request, HttpServletResponse response){
        String ip = request.getRemoteAddr();
//        调用Service
        User user =userServer.getUser(username,password,ip);
        request.getSession().setAttribute("user", user);
//        判断是否点击选中免登录
        if (loginTo){
            Cookie cookie = new Cookie("username",username);
            cookie.setMaxAge(3600*24*10);
            cookie.setPath("/");
            password = MD5Util.getMD5(password);
            Cookie cookie2 = new Cookie("password",password);
            cookie2.setMaxAge(3600*24*10);
            cookie2.setPath("/");
            response.addCookie(cookie);
            response.addCookie(cookie2);
        }
        HashMap hashMap = new HashMap();
        hashMap.put("success",true);
        hashMap.put("msg","登录成功");

        return hashMap;
    }

    @RequestMapping("logOut.do")
    public String logOut(HttpSession session, HttpServletResponse response){
        session.removeAttribute("user");
        Cookie cookie = new Cookie("username","");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
        return "redirect:/";
    }

    @GetMapping("getAll.json")
    @ResponseBody
    public List<User> getAll(){
        return userServer.getALL();
    }
}
