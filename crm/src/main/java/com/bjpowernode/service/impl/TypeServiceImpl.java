package com.bjpowernode.service.impl;

import com.bjpowernode.mapper.TypeMapper;
import com.bjpowernode.pojo.Type;
import com.bjpowernode.service.TypeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.List;
@Service
public class TypeServiceImpl implements TypeService {
    @Resource
    TypeMapper typeMapper;
    @Override
    public Type getOne(String code) {
        return typeMapper.getOne(code);
    }

    @Override
    public List<Type> getALL() {
        return typeMapper.getALL();
    }

    @Override
    public int update(Type type) {
        return typeMapper.update(type);
    }

    @Override
    public int addType(Type type) {
        return typeMapper.addType(type);
    }

    @Override
    public int delete(Serializable... code) {
        return typeMapper.delete(code);
    }
}
