package com.bjpowernode.web.controller;

import com.bjpowernode.pojo.Clue;
import com.bjpowernode.pojo.Page;
import com.bjpowernode.service.ClueService;
import com.bjpowernode.service.TablesName;
import com.bjpowernode.utils.ControllerUtils;
import com.bjpowernode.utils.JsonMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("clue")
@ResponseBody
public class ClueController {
    @Autowired
   private ClueService clueService;
   private String tableName= TablesName.TablesNames.Clue;


    @RequestMapping("page.json")
    public Page page(@RequestParam Map params, Page page) {
        clueService.getPage(params, page);
        return page;
    }

    @GetMapping("{id}")
    public Clue getOne(@PathVariable("id") String id){
        return clueService.getOne(id);
    }
    @PostMapping
    public Map inset(@RequestParam Map data, HttpSession session){
        ControllerUtils.save(data,session);
        clueService.insert(tableName,data);
        return JsonMap.jsonMap("添加成功");
    }
    @PutMapping
    public Map update(@RequestParam Map data,HttpSession session){
        ControllerUtils.save(data,session);
        clueService.update(tableName,data);
        return JsonMap.jsonMap("修改成功");
    }
    @DeleteMapping("{ids}")
    public Map delete(@PathVariable("ids") String[] ids){
        clueService.delete(tableName,ids);
        return JsonMap.jsonMap("删除成功");
    }
}
