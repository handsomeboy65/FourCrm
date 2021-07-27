package com.bjpowernode.mapper;

import com.bjpowernode.pojo.Clue;
import com.bjpowernode.pojo.Page;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public interface ClueMapper {
    Clue getOne(String id);
    int getCount(@Param("data") Map data);
    List getPage(@Param("startIndex") Integer startIndex,
              @Param("getRowsPerPage") Integer getRowsPerPage,
              @Param("data") Map data);


}
