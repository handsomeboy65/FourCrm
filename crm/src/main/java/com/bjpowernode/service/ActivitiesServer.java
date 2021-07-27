package com.bjpowernode.service;

import com.bjpowernode.pojo.Activity;
import org.apache.ibatis.annotations.Param;

import javax.servlet.http.HttpSession;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

public interface ActivitiesServer {

    List<Activity> getScreen(Map data);
    void insert(String tableName,
                Map data);
    void update(String tableName,
                 Map data);
    void delete(String tableName,
                 Serializable... ids);

    Activity getOne(String tableName,
                  String id);
}
