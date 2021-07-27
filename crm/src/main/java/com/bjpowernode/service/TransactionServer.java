package com.bjpowernode.service;


import com.bjpowernode.pojo.Page;

import java.util.Map;

public interface TransactionServer {
    void getFilterAll(Map data, Page page);
}
