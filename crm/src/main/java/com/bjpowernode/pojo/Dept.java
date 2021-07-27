package com.bjpowernode.pojo;

import lombok.Data;

@Data
public class Dept {
    private String id;
    private String no;
    private String name;
    private String manager;
    private String description;
    private String phone;

    public Dept() {
    }

    public Dept(String id, String no, String name, String manager, String description, String phone) {
        this.id = id;
        this.no = no;
        this.name = name;
        this.manager = manager;
        this.description = description;
        this.phone = phone;
    }
}
