package com.example.controller.teacher;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.entity.teacher.teacherInfo;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/teachercontroller")
public class teacherController {
    @RequestMapping("/returnteacherinfo")
    public String test1(String college){
        StringBuilder str = new StringBuilder();
        str.append("[");
        teacherInfo user = new teacherInfo();
        QueryWrapper<teacherInfo> uqw = new QueryWrapper<>();
        uqw.eq("college",college);

        List<teacherInfo> list = user.selectList(uqw);

        for(teacherInfo s : list){
            if(!str.toString().equals("["))
                str.append(",");
            str.append("{\"numteacher\":\"").append(s.getNumteacher())
                    .append("\",\"name\":\"").append(s.getName())
                    .append("\",\"age\":\"").append(s.getAge())
                    .append("\",\"sex\":\"").append(s.getSex())
                    .append("\",\"course\":\"").append(s.getCourse())
                    .append("\",\"college\":\"").append(s.getCollege())
                    .append("\",\"title\":\"").append(s.getTitle())
                    .append("\",\"salary\":\"").append(s.getSalary())
                    .append("\"}");
        }
        str.append("]");
        return str.toString();
    }
}







