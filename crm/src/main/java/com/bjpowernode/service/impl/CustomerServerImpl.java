package com.bjpowernode.service.impl;

import com.bjpowernode.mapper.CustomerMapper;
import com.bjpowernode.pojo.Page;
import com.bjpowernode.service.CustomerServer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
@Service
public class CustomerServerImpl implements CustomerServer {

    @Autowired
    CustomerMapper customerMapper;
    @Override
    public void getFilterAll(Map data, Page page) {
        //        计算总记录数
        int totalRows = customerMapper.getCount(data);
//        计算总页数
        int totalPages = (totalRows - 1) / page.getRowsPerPage() + 1;
//        哪里开始拿数据
        int startRows = (page.getCurrentPage() - 1) * page.getRowsPerPage();
        List filterAll = customerMapper.getFilterAll(startRows, page.getRowsPerPage(), data);
//        存放数据
        page.setTotalPages(totalPages);
        page.setTotalRows(totalRows);
        page.setData(filterAll);
    }
}
