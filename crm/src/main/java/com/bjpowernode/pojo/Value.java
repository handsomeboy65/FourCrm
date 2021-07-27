package com.bjpowernode.pojo;

import lombok.Data;

@Data
public class Value {
    private String id;
    private String value;
    private String text;
    private String orderNo;
    private String typeCode;

    public Value() {
    }

    public Value(String id, String value, String text, String orderNo, String typeCode) {
        this.id = id;
        this.value = value;
        this.text = text;
        this.orderNo = orderNo;
        this.typeCode = typeCode;
    }
}
