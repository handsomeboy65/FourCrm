package com.bjpowernode.service.impl;

import com.bjpowernode.exception.UserException;
import com.bjpowernode.mapper.UserMapper;
import com.bjpowernode.pojo.User;
import com.bjpowernode.service.UserServer;
import com.bjpowernode.utils.DateTimeUtil;
import com.bjpowernode.utils.MD5Util;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserServerImpl implements UserServer {
//    需求说明
//    登录时，除了要验证用户名和密码是否正确之外，还需要验证：
//1、	关于失效时间：如果过期，在页面上给出提示
//2、	是否锁定，如果处于锁定状态，在页面上给出提示
//3、	判断用户使用的电脑的IP是否在允许范围内，如果不在范围内，在页面上给出提示
//4、登录时，需要对密码进行MD5加密处理，然后再与数据库中进行比较
//5、要求使用ajax完成登录的验证，验证通过，跳转到工作台首页。
//
//    登录失败可能的原因：
//    用户名或密码错误。
//    关于失效时间：如果失效时间为空，则表示永不失效
//    关于锁定状态：0锁定  1启用
//    关于允许访问的IP：为空表示不限制，多个IP使用逗号分隔
@Resource
UserMapper userMapper;


    @Override
    public User getUser(String username, String password,String ip) {

         password = MD5Util.getMD5(password);

        User user= userMapper.getUser(username,password);
        //1. 除了要验证用户名和密码是否正确
        if (user==null){
            throw new UserException("用户名或者密码错误");
        }


        //2. 关于失效时间：如果过期，在页面上给出提示
        long expireTime =0;
        if (user.getExpireTime().length()==10){
            expireTime=  DateTimeUtil.longTimeOne(user.getExpireTime());
        }
        if (user.getExpireTime().length()==19){
            expireTime = DateTimeUtil.longTimeOne(user.getExpireTime());
        }
        long newTime = System.currentTimeMillis();
        if (newTime>expireTime){
            throw new UserException("账号已过期");
        }


        //3、	是否锁定，如果处于锁定状态，在页面上给出提示
        if ("1".equals(user.getLockStatus())){}else {
            throw new UserException("该账号被锁定禁止访问");
        }


        //4. 判断用户使用的电脑的IP是否在允许范围内，如果不在范围内，在页面上给出提示
        String allowIps = user.getAllowIps();
        if (!allowIps.contains(ip)){
            throw new UserException("当前IP地址不允许登录");
        }
        return user;
    }




//    Cooke Session 免登录验证
    @Override
    public User LoginFree(String username, String password,String ip) {

        User user= userMapper.getUser(username,password);
        //1. 除了要验证用户名和密码是否正确
        if (user==null){
            return null;
        }


        //2. 关于失效时间：如果过期，在页面上给出提示
        long expireTime =0;
        if (user.getExpireTime().length()==10){
            expireTime=  DateTimeUtil.longTimeOne(user.getExpireTime());
        }
        if (user.getExpireTime().length()==19){
            expireTime = DateTimeUtil.longTimeOne(user.getExpireTime());
        }
        long newTime = System.currentTimeMillis();
        if (newTime>expireTime){
            return null;
        }


        //3、	是否锁定，如果处于锁定状态，在页面上给出提示
        if ("1".equals(user.getLockStatus())){}else {
            return null;
        }


        //4. 判断用户使用的电脑的IP是否在允许范围内，如果不在范围内，在页面上给出提示
        String allowIps = user.getAllowIps();
        if (!allowIps.contains(ip)){
            return null;
        }
        return user;
    }

    @Override
    public List<User> getALL() {
        return userMapper.getALL();
    }

}
