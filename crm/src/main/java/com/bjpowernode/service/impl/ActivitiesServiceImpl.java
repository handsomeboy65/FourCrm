package com.bjpowernode.service.impl;

import com.bjpowernode.mapper.CommonMapper;
import com.bjpowernode.pojo.Activity;
import com.bjpowernode.service.ActivitiesServer;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

@Service
public class ActivitiesServiceImpl implements ActivitiesServer {
    @Resource
    CommonMapper commonMapper;

    @Override
    public List<Activity> getScreen(Map data) {
        return commonMapper.getAll(data);
    }

    @Override
    public void insert(String tableName, Map data) {
        commonMapper.insert(tableName,data);
    }

    @Override
    public void update(String tableName, Map data) {
        commonMapper.update(tableName,data);
    }

    @Override
    public void delete(String tableName, Serializable... ids) {
        commonMapper.delete(tableName,ids);
    }

    @Override
    public Activity getOne(String tableName,String id) {
        return commonMapper.getOne(tableName,id);
    }
}
