package com.bjpowernode.service.impl;

import com.bjpowernode.mapper.DeptMapper;
import com.bjpowernode.pojo.Dept;
import com.bjpowernode.service.DeptService;
import com.bjpowernode.utils.UUIDUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.List;
@Service
public class DeptServiceImpl implements DeptService {
    @Resource
    DeptMapper deptMapper;
    @Override
    public Dept getOne(String id) {
        return deptMapper.getOne(id);
    }

    @Override
    public List<Dept> getALL() {
        return deptMapper.getALL();
    }

    @Override
    public int update(Dept dept) {
        return deptMapper.update(dept);
    }

    @Override
    public int add(Dept dept) {
        dept.setId(UUIDUtil.getUUID());
        return deptMapper.add(dept);
    }

    @Override
    public int delete(Serializable... id) {
        return deptMapper.delete(id);
    }
}
