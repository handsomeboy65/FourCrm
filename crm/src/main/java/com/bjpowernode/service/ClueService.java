package com.bjpowernode.service;

import com.bjpowernode.pojo.Activity;
import com.bjpowernode.pojo.Clue;
import com.bjpowernode.pojo.Page;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public interface ClueService {
    Clue getOne(String id);
    void getPage(Map params, Page page);
    int insert(String tableName,
                 Map data);
    int update(String tableName,
                 Map data);
    int delete(String tableName,
               Serializable... ids);
}
