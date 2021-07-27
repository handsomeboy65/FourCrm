package com.bjpowernode.pojo;

import lombok.Data;

@Data
public class Type {
private String  code;
private String  name;
private String  description;

    public Type() {
    }

    public Type(String code, String name, String description) {
        this.code = code;
        this.name = name;
        this.description = description;
    }

}
