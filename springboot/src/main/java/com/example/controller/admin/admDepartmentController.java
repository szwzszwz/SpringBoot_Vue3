package com.example.controller.admin;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.dao.department.departmentInfoDao;
import com.example.entity.department.departmentInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/OperationDepartmentController")
public class admDepartmentController {
    final private departmentInfoDao dao;

    @Autowired
    public admDepartmentController(departmentInfoDao dao){
        this.dao = dao;
    }

    @ResponseBody
    @RequestMapping("/changeInfoById")
    // 修改部门信息
    public void test1(String Dno, String Dname,
                      String Dhead){

        departmentInfo departmentinfo = new departmentInfo();
        QueryWrapper<departmentInfo> uqw = new QueryWrapper<>();
        uqw.eq("Dno",Dno);
        
        departmentinfo.setDname(Dname);
        departmentinfo.setDhead(Dhead);
        dao.update(departmentinfo,uqw);
    }

    @ResponseBody
    @RequestMapping("/insertInfoById")
    // 添加部门信息
    public void test2(String Dno, String Dname,
                      String Dduty, String Dhead){

        departmentInfo departmentinfo = new departmentInfo();

        departmentinfo.setDno(Dno);
        departmentinfo.setDname(Dname);
        departmentinfo.setDduty(Dduty);
        departmentinfo.setDhead(Dhead);
        dao.insert(departmentinfo); //插入
    }

    @ResponseBody
    @RequestMapping("/deleteInfoById")
    // 删除部门信息
    public String test3(String Dno, String Dname){
        Map<String,Object> map = new HashMap<>();
        map.put("Dno",Dno);
        map.put("Dname",Dname);
        int result = dao.deleteByMap(map);
        if(result == 1)
            return "success";
        else return "error";
    }
}
