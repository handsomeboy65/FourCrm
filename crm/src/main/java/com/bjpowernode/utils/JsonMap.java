package com.bjpowernode.utils;

import java.util.HashMap;
import java.util.Map;

public class JsonMap {
   static Map map = new HashMap();
    public static Map jsonMap(String msg){
        map.put("success",true);
        map.put("msg",msg);
        return map;
    }
}
