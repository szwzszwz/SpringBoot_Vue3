package com.example.controller.register;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.dao.login.userStudentLoginDao;
import com.example.entity.login.userStudentLogin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/registerStudent")
public class registerStudentController {

    final private userStudentLoginDao dao;

    @Autowired
    public registerStudentController(userStudentLoginDao dao){
        this.dao = dao;
    }

    @RequestMapping("/register")
    public String is_already_registered(String username,String password){
        userStudentLogin usl = new userStudentLogin();
        QueryWrapper<userStudentLogin> uslqw = new QueryWrapper<>();
        uslqw.eq("username",username);
        List<userStudentLogin> list = usl.selectList(uslqw);
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
