package com.bjpowernode.web.controller.listener;

import com.bjpowernode.pojo.Value;
import com.bjpowernode.service.ValueService;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebListener
public class Cache implements ServletContextListener {
    public void contextInitialized(ServletContextEvent sce) {
        WebApplicationContext springContext = ContextLoader.getCurrentWebApplicationContext();
        ValueService valueService = springContext.getBean(ValueService.class);
        List<Value> values = valueService.getALL();
        // 笔试题：将list处理为Map<String, List>, key是typeCode，List是typeCode相同的实例
        Map<String, List> map = new HashMap<>();
        for (Value value : values) {
            String key = value.getTypeCode();
            List list = map.get(key);
            if (list == null) {
                list = new ArrayList();
                map.put(key, list);
            }
            list.add(value);
        }
        sce.getServletContext().setAttribute("valueList", map);
    }
}
