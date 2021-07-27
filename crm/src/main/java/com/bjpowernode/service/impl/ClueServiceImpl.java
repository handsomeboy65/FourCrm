package com.bjpowernode.service.impl;

import com.bjpowernode.mapper.ClueMapper;
import com.bjpowernode.mapper.CommonMapper;
import com.bjpowernode.pojo.Clue;
import com.bjpowernode.pojo.Page;
import com.bjpowernode.service.ClueService;
import com.bjpowernode.service.TablesName;
import com.bjpowernode.utils.ControllerUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

@Service
public class ClueServiceImpl implements ClueService {
    @Autowired
    ClueMapper clueMapper;
    @Autowired
    CommonMapper commonMapper;

    @Override
    public Clue getOne(String id) {
        return clueMapper.getOne(id);
    }

    @Override
    public void getPage(Map params, Page page) {
//      计算总条数
        int totalRows = clueMapper.getCount(params);
//        总页数

        int totalPages = (totalRows-1)/page.getRowsPerPage()+1;
/*//防止，超过数据还在拿
        Integer currentPage = page.getCurrentPage();
        if (currentPage>totalPages){
            currentPage =totalPages;
        }
        if (currentPage<=0){
            currentPage=1;
        }*/
        //      从哪里开始拿数据
        int startIndex = (page.getCurrentPage() - 1) * page.getRowsPerPage();
        //       数据
        List data = clueMapper.getPage(startIndex, page.getRowsPerPage(), params);
        page.setData(data);
        page.setTotalRows(totalRows);
        page.setTotalPages(totalPages);
        page.setVisiblePageLinks(totalPages);
    }


    @Override
    public int insert(String tableName, Map data) {
        return commonMapper.insert(tableName,data);
    }

    @Override
    public int update(String tableName, Map data) {
        return commonMapper.update(tableName,data);
    }

    @Override
    public int delete(String tableName, Serializable... ids) {
        return commonMapper.delete(tableName,ids);
    }


}
