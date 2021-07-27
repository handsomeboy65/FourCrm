package com.bjpowernode.web.controller;

import com.bjpowernode.pojo.Type;
import com.bjpowernode.service.TypeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.Serializable;

@Controller
public class TypeOneController {
    @Resource
    TypeService typeService;
   @RequestMapping("typeOne.do")
    public ModelAndView typeController(String code){
       System.out.println(code);
            ModelAndView modelAndView = new ModelAndView();
            modelAndView.addObject("typeOne",typeService.getOne(code));
            modelAndView.setViewName("settings/dictionary/type/edit");
            return modelAndView;
    }


}
