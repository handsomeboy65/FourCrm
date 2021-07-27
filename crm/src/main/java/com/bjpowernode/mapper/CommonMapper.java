package com.bjpowernode.mapper;

import com.bjpowernode.pojo.Activity;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;
import java.util.List;
import java.util.Map;


public interface CommonMapper {
    List<Activity> getAll(Map data);
    int insert(@Param("tableName") String tableName,
                @Param("data") Map data);
    int update(@Param("tableName") String tableName,
                @Param("data") Map data);
    int delete(@Param("tableName") String tableName,
               @Param("ids") Serializable... ids);

    Activity getOne(@Param("tableName")String tableName,
                  @Param("id") String id);
}
