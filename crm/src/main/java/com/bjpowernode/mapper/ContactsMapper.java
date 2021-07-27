package com.bjpowernode.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ContactsMapper {
    List getFilterAll(@Param("startIndex") Integer startIndex,
                      @Param("getRowsPerPage") Integer getRowsPerPage,
                      @Param("data") Map data);
    int getCount(@Param("data") Map data);
}
