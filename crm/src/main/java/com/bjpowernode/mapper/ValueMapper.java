package com.bjpowernode.mapper;

import com.bjpowernode.pojo.Type;
import com.bjpowernode.pojo.Value;

import java.io.Serializable;
import java.util.List;

public interface ValueMapper {
    Value getOne(String id);
    List<Value> getALL();
    int update(Value value);
    int add(Value value);
    int delete(Serializable... id);
    List<Value> getTypeCode(Serializable... typeCode);
}
