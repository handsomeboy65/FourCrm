package com.bjpowernode.web.controller;

import com.bjpowernode.pojo.Page;

import com.bjpowernode.service.CustomerServer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("customer")
public class CustomerController {

    @Autowired
    CustomerServer customerServer;
    @GetMapping("getFilterAll.json")
    public Page getFilterAll(@RequestParam Map data, Page page){
        customerServer.getFilterAll(data,page);
        return page;
    }
}
