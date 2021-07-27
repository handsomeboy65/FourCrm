package com.bjpowernode.service.impl;

import com.bjpowernode.mapper.ValueMapper;
import com.bjpowernode.pojo.Value;
import com.bjpowernode.service.ValueService;
import com.bjpowernode.utils.UUIDUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.List;
@Service
public class ValueServiceImpl implements ValueService {
    @Resource
    ValueMapper valueMapper;
    @Override
    public Value getOne(String id) {
        return valueMapper.getOne(id);
    }

    @Override
    public List<Value> getALL() {
        return valueMapper.getALL();
    }

    @Override
    public int update(Value value) {
        return valueMapper.update(value);
    }

    @Override
    public int add(Value value) {
        value.setId(UUIDUtil.getUUID());
        return valueMapper.add(value);
    }

    @Override
    public int delete(Serializable... id) {
        return valueMapper.delete(id);
    }

    @Override
    public List<Value> getTypeCode(Serializable... typeCode) {
        return valueMapper.getTypeCode(typeCode);
    }
}
