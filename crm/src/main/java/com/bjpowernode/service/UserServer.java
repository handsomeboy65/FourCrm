package com.bjpowernode.service;

import com.bjpowernode.pojo.User;

import java.util.List;

public interface UserServer {
    User getUser(String username,String password,String ip);
    User LoginFree(String username,String password,String ip);
    List<User> getALL();
}
