package com.example.controller.login;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.entity.login.userStudentLogin;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/userStudentLogin")
public class userStudentLoginController {

    @RequestMapping("/come") // 接收学生的用户名和密码
    public String un_pwd(String username, String password){
        userStudentLogin usl = new userStudentLogin();
        QueryWrapper<userStudentLogin> userQueryWrapper = new QueryWrapper<>();
        userQueryWrapper.le("username",username);

        List<userStudentLogin> users = usl.selectList(userQueryWrapper);
        for(userStudentLogin u : users){ // 循环数据库
            if(password.equals(u.getPassword())) {
                return "yes";
            }
        }
       return "no";
    }
}
