package com.bjpowernode.web.controller;

import com.bjpowernode.pojo.Type;
import com.bjpowernode.service.TypeService;
import com.bjpowernode.utils.JsonMap;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("type")
public class TypeController {
    @Resource
    TypeService typeService;
    @GetMapping
    public List<Type> getAll(){
        List<Type> all = typeService.getALL();
        return all;
    }

    @PostMapping
    public Map addType(Type type){
        typeService.addType(type);
        return JsonMap.jsonMap("添加成功");
    }

    @PutMapping
    public Map updateType(Type type){
        typeService.update(type);
        return JsonMap.jsonMap("修改成功");
    }

    @DeleteMapping("{codes}")
    public Map deleteType(@PathVariable("codes") String[] codes){
        typeService.delete(codes);
        return JsonMap.jsonMap("删除成功");
    }
}
