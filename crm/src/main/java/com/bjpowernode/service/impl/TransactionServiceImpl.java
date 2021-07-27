package com.bjpowernode.service.impl;

import com.bjpowernode.mapper.TransactionMapper;
import com.bjpowernode.pojo.Page;
import com.bjpowernode.service.TransactionServer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
@Service
public class TransactionServiceImpl implements TransactionServer {
    @Autowired
    TransactionMapper transactionMapper;

    @Override
    public void getFilterAll(Map data, Page page) {
//        获取总记录条数
        int totalRows = transactionMapper.getCount(data);
//        计算总页数
        Integer rowsPerPage = page.getRowsPerPage();
        int totalPages = (totalRows - 1) / rowsPerPage + 1;
//        当前显示数据
        int startRows = (page.getCurrentPage() - 1) * page.getRowsPerPage();
        List filterAll = transactionMapper.getFilterAll(startRows, page.getRowsPerPage(), data);
//        存放数据
        page.setTotalPages(totalPages);
        page.setTotalRows(totalRows);
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        System.out.println(filterAll);
        page.setData(filterAll);
    }
}
