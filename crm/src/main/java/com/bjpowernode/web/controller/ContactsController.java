package com.bjpowernode.web.controller;

import com.bjpowernode.pojo.Page;
import com.bjpowernode.service.ContactsServer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("contacts")
public class ContactsController {

    @Autowired
    ContactsServer contactsService;
    @GetMapping("getFilterAll.json")

    public Page getFilterAll(@RequestParam Map data, Page page){
        contactsService.getFilterAll(data,page);
        return page;
    }
}
