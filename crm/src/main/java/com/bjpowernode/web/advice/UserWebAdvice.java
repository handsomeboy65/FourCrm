package com.bjpowernode.web.advice;

import com.bjpowernode.exception.UserException;
import org.springframework.web.bind.annotation.ControllerAdvice;


import org.springframework.web.bind.annotation.ExceptionHandler;

import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class UserWebAdvice {
    @ExceptionHandler(UserException.class)
    @ResponseBody
    public Map UserWebAdvice(Exception e){
        Map map = new HashMap();
        map.put("success",false);
        map.put("msg",e.getMessage());
        return map;
    }
//    public Map UserWebAdvice(Exception e) {
//        return new HashMap(){{
//          put("success",false);
//          put("msg",e.getMessage());
//        }};
//    }
}
