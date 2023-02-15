package com.example.controller.teacher;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.entity.teacher.teacherInfo;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/teacherInfo")
public class teacherinfoController {
    @RequestMapping("/loginInfo") // 接收老师的用户名和密码
    public teacherInfo un_pwd(String numteacher){
        System.out.println("id:" + numteacher);
        teacherInfo user = new teacherInfo();
        QueryWrapper<teacherInfo> userQueryWrapper = new QueryWrapper<>();
        userQueryWrapper.le("numteacher",numteacher);
        List<teacherInfo> users = user.selectList(userQueryWrapper);
        for(teacherInfo u : users){
            if(numteacher.equals(Integer.toString(u.getNumteacher()))){
                return u;
            }
        }
        return user;
    }
}
