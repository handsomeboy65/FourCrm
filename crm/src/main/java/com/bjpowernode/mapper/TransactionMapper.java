package com.bjpowernode.mapper;

import com.bjpowernode.pojo.Transaction;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface TransactionMapper {
    List getFilterAll(@Param("startIndex") Integer startIndex,
                                   @Param("getRowsPerPage") Integer getRowsPerPage,
                                   @Param("data") Map data);
    int getCount(@Param("data") Map data);
}
