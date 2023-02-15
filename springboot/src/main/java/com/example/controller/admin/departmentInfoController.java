package com.example.controller.admin;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.entity.department.departmentInfo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/DepartmentInfoController")
public class departmentInfoController {

    @ResponseBody
    @RequestMapping("/departmentInfo")
    public String showInfo()
    {
        StringBuilder str = new StringBuilder();
        str.append("[");
        departmentInfo departmentinfo = new departmentInfo();
        QueryWrapper<departmentInfo> uqw = new QueryWrapper<>();
        List<departmentInfo> users = departmentinfo.selectList(uqw);

        for(departmentInfo s : users){
            if (!str.toString().equals("["))
                str.append(",");
            str.append("{\"Dno\":\"").append(s.getDno())
                    .append("\",\"Dname\":\"").append(s.getDname())
                    .append("\",\"Dduty\":\"").append(s.getDduty())
                    .append("\",\"Dhead\":\"").append(s.getDhead())
                    .append("\"}");
        }
        str.append("]");
        return str.toString();
    }
}
