package com.example.controller.register;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.dao.login.userTeacherLoginDao;
import com.example.entity.login.userTeacherLogin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/registerTeacher")
public class registerTeacherController {

    final private userTeacherLoginDao dao;

    @Autowired
    public registerTeacherController(userTeacherLoginDao dao){
        this.dao = dao;
    }

    @RequestMapping("/register")
    public String is_already_registered(String username,String password){
        userTeacherLogin usl = new userTeacherLogin();
        QueryWrapper<userTeacherLogin> uslqw = new QueryWrapper<>();
        uslqw.eq("username",username);
        List<userTeacherLogin> list = usl.selectList(uslqw);
        if(!list.isEmpty())
            return "no";
        else{
            usl.setUsername(username);
            usl.setPassword(password);
            dao.insert(usl);
        }
        return "yes";
    }
}
