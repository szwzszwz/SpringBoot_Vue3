package com.example.controller.student;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.entity.student.studentInfo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
@RequestMapping("/studentInfo")
public class studentInfoController {

    @RequestMapping("loginInfo")
    public studentInfo StringloginInfo(String id){
        studentInfo user = new studentInfo();
        QueryWrapper<studentInfo> userQueryWrapper = new QueryWrapper<>();
        userQueryWrapper.le("id",id);
        List<studentInfo> users = user.selectList(userQueryWrapper);
        for(studentInfo u : users){
            if(id.equals(Integer.toString(u.getId()))){
                return u;
            }
        }
        return user;
    }
}
