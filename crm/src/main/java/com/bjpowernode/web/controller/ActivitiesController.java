package com.bjpowernode.web.controller;


import com.bjpowernode.pojo.Activity;
import com.bjpowernode.service.ActivitiesServer;
import com.bjpowernode.service.TablesName;
import com.bjpowernode.utils.ControllerUtils;
import com.bjpowernode.utils.JsonMap;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("act")
public class ActivitiesController {
    @Resource
    private ActivitiesServer act;

    @GetMapping
    public List<Activity> getScreen(@RequestParam Map data){
       return act.getScreen(data);
    }

    @GetMapping("{id}")
    public Activity getOne(@PathVariable("id") String id){
        return act.getOne(TablesName.TablesNames.ACT,id);
    }

    @PostMapping
    public Map insert(@RequestParam Map data, HttpSession session){
        ControllerUtils.save(data,session);
        act.insert(TablesName.TablesNames.ACT,data);
        return JsonMap.jsonMap("添加成功");
    }
    @PutMapping
    public Map update(@RequestParam Map data, HttpSession session){
        ControllerUtils.edit(data,session);
        act.update(TablesName.TablesNames.ACT,data);
        return JsonMap.jsonMap("修改成功");
    }
    @DeleteMapping("{ids}")
    public Map delete(@PathVariable("ids") String[] ids){
        act.delete(TablesName.TablesNames.ACT,ids);
       return JsonMap.jsonMap("删除成功");
    }

    @GetMapping("export.do")
    public void download(HttpServletResponse response,Map data) throws IOException {
        //创建Excel
        HSSFWorkbook excel = new HSSFWorkbook();
        HSSFSheet sheet = excel.createSheet("万通集团活动表");//命名
//        设置第一行标题
        int i =0;
        HSSFRow row = sheet.createRow(i++);
        int a=0;
        row.createCell(a++).setCellValue("名称");
        row.createCell(a++).setCellValue("所有者");
        row.createCell(a++).setCellValue("开始日期");
        row.createCell(a++).setCellValue("结束日期");
        List<Activity> screen = act.getScreen(data);
        for (Activity activity : screen) {
//            循环设置数据
            row = sheet.createRow(i++);
            a = 0;
            row.createCell(a++).setCellValue(activity.getName());
            row.createCell(a++).setCellValue(activity.getOwner());
            row.createCell(a++).setCellValue(activity.getStartDate());
            row.createCell(a++).setCellValue(activity.getEndDate());
        }
        response.addHeader("Content-Disposition", "attachment;filename=activity.xls");
//        下载文件
        excel.write(response.getOutputStream());
    }

    @PostMapping("import.do")
    public Map importExcel(MultipartFile file,HttpSession session) throws IOException {
//        解析Excel
        HSSFWorkbook sheets = new HSSFWorkbook(file.getInputStream());
        HSSFSheet sheetAt = sheets.getSheetAt(0);
        int i=1;
        HSSFRow row;
        HashMap hashMap = new HashMap();
        while ((row=sheetAt.getRow(i++))!=null){
            int a=0;
            String name = row.getCell(a++).getStringCellValue();
            String owner = row.getCell(a++).getStringCellValue();
            String startDate = row.getCell(a++).getStringCellValue();
            String endDate = row.getCell(a++).getStringCellValue();

            hashMap.put("name",name);
            hashMap.put("owner",owner);
            hashMap.put("startDate",startDate);
            hashMap.put("endDate",endDate);
        }
        act.insert(TablesName.TablesNames.ACT,hashMap);
        ControllerUtils.save(hashMap,session);

        return JsonMap.jsonMap("导入成功");
    }
}
