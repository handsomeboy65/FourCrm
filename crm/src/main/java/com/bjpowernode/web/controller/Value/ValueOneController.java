package com.bjpowernode.web.controller.Value;

import com.bjpowernode.pojo.Type;
import com.bjpowernode.pojo.Value;
import com.bjpowernode.service.TypeService;
import com.bjpowernode.service.ValueService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class ValueOneController {
    @Resource
    ValueService valueService;
    @RequestMapping("valueOne.do")
    public ModelAndView getOne(String id,ModelAndView modelAndView){
        modelAndView.addObject("value",valueService.getOne(id));
        modelAndView.setViewName("settings/dictionary/value/edit");
        return modelAndView;
    }

    @RequestMapping("getTypeCode.do")
    @ResponseBody
    public List<Value> getTypeCode(String[] code){
        List<Value> typeCode = valueService.getTypeCode(code);
        return typeCode;
    }
}
