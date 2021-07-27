package com.bjpowernode.service;

import com.bjpowernode.pojo.Value;

import java.io.Serializable;
import java.util.List;

public interface ValueService {
    Value getOne(String id);
    List<Value> getALL();
    int update(Value value);
    int add(Value value);
    int delete(Serializable... id);
    List<Value> getTypeCode(Serializable... typeCode);
}
