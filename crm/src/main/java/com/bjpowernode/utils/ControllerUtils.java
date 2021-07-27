package com.bjpowernode.utils;

import com.bjpowernode.pojo.User;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.http.HttpSession;
import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.Map;

public class ControllerUtils {
    //     添加用户和时间
    public static void save(Map map, HttpSession session){
        User user = (User)session.getAttribute("user");
        String createBy=user.getLoginAct() +"|"+user.getName();
        String createTime=DateTimeUtil.stringNewTime(new Date());
            map.put("id",UUIDUtil.getUUID());
            map.put("createBy",createBy);
            map.put("createTime",createTime);
    }

    //            修改用户和时间
    public static void edit(Map data, HttpSession session){
        User user = (User)session.getAttribute("user");
        String editBy=user.getLoginAct() +"|"+user.getName();
        String editTime=DateTimeUtil.stringNewTime(new Date());
            data.put("editBy",editBy);
            data.put("editTime",editTime);
    }
}
