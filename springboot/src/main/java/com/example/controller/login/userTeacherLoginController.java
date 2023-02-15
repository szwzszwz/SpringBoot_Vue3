package com.example.controller.login;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.entity.login.userTeacherLogin;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/userTeacherLogin")
public class userTeacherLoginController {

    @RequestMapping("/come")
    public String un_pwd(String username, String password){
        userTeacherLogin utl = new userTeacherLogin();
        QueryWrapper<userTeacherLogin> userQueryWrapper = new QueryWrapper<>();
        userQueryWrapper.le("username",username);

        List<userTeacherLogin> users = utl.selectList(userQueryWrapper);
        for(userTeacherLogin u : users){ // 循环数据库
            if(password.equals(u.getPassword())) {
                return "yes";
            }
        }
        return "no";
    }
}
