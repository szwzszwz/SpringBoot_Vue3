package com.example.controller.login;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.entity.login.admLogin;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/admLogin")
public class admLoginController {

    @RequestMapping("/login")
    public String un_pwd(String username, String password) {
        admLogin al = new admLogin();
        QueryWrapper<admLogin> alqw = new QueryWrapper<>();
        alqw.eq("username",username);
        List<admLogin> list = al.selectList(alqw);
        for (admLogin a : list)
            if (password.equals(a.getPassword()))
                return "yes";
        return "no";
    }
}
