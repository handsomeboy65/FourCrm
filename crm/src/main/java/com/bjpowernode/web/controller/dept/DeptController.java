package com.bjpowernode.web.controller.dept;

import com.bjpowernode.pojo.Dept;
import com.bjpowernode.service.DeptService;
import com.bjpowernode.utils.JsonMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("dept")
public class DeptController {
    @Resource
    DeptService valueService;

    @GetMapping
    public List<Dept> getAll(){
        List<Dept> all = valueService.getALL();
        return all;
    }

    @GetMapping("{id}")
    public Dept getOne(@PathVariable String id){
        Dept all = valueService.getOne(id);
        return all;
    }

    @PostMapping
    public Map add(Dept dept){
        valueService.add(dept);
        return JsonMap.jsonMap("添加成功");
    }

    @PutMapping
    public Map update(Dept dept){
        valueService.update(dept);
        return JsonMap.jsonMap("修改成功");
    }
    @DeleteMapping("{ids}")
    public Map delete(@PathVariable("ids") String[] ids){
        valueService.delete(ids);
        return JsonMap.jsonMap("删除成功");
    }
}
