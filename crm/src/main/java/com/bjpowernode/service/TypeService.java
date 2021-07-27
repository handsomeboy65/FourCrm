package com.bjpowernode.service;

import com.bjpowernode.pojo.Type;
import java.io.Serializable;
import java.util.List;

public interface TypeService {
    Type getOne(String code);
    List<Type> getALL();
    int update(Type type);
    int addType(Type type);
    int delete(Serializable...code);
}
