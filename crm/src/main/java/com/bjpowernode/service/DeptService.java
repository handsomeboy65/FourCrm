package com.bjpowernode.service;

import com.bjpowernode.pojo.Dept;

import java.io.Serializable;
import java.util.List;

public interface DeptService {

    Dept getOne(String id);
    List<Dept> getALL();
    int update(Dept dept);
    int add(Dept dept);
    int delete(Serializable... id);
}
