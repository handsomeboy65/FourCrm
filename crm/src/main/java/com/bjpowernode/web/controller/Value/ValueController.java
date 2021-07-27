package com.bjpowernode.web.controller.Value;
import com.bjpowernode.pojo.Value;
import com.bjpowernode.service.ValueService;
import com.bjpowernode.utils.JsonMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("value")
public class ValueController {
    @Resource
    ValueService valueService;

    @GetMapping
    public List<Value> getAll(){
        List<Value> all = valueService.getALL();
        return all;
    }

    @PostMapping
    public Map add(Value value){
        valueService.add(value);
        return JsonMap.jsonMap("添加成功");
    }

    @PutMapping
    public Map update(Value value){
        valueService.update(value);
        return JsonMap.jsonMap("修改成功");
    }
    @DeleteMapping("{id}")
    public Map deleteType(@PathVariable("id") String[] codes){
        valueService.delete(codes);
        return JsonMap.jsonMap("删除成功");
    }

}
