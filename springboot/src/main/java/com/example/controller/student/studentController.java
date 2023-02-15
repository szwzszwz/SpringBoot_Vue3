package com.example.controller.student;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.entity.student.studentInfo;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/studentcontroller")
 public class studentController {
    @RequestMapping("/returnstudentinfo")
    public String test1(String college,String Classroom){
        StringBuilder str = new StringBuilder();
        str.append("[");
        studentInfo user = new studentInfo();
        QueryWrapper<studentInfo> uqw = new QueryWrapper<>();
        uqw.eq("college",college)
                .eq("Classroom",Classroom);

        List<studentInfo> list = user.selectList(uqw);
        if(list.isEmpty())
            return "error";
        for(studentInfo s : list){
            if(!str.toString().equals("["))
                str.append(",");
            str.append("{\"id\":\"").append(s.getId())
                    .append("\",\"name\":\"").append(s.getName())
                    .append("\",\"age\":\"").append(s.getAge())
                    .append("\",\"sex\":\"").append(s.getSex())
                    .append("\",\"Classroom\":\"").append(s.getClassroom())
                    .append("\",\"college\":\"").append(s.getCollege())
                    .append("\",\"time\":\"").append(s.getTime())
                    .append("\",\"hotel\":\"").append(s.getHotel())
                    .append("\"}");
        }
        str.append("]");
        return str.toString();
    }
}
