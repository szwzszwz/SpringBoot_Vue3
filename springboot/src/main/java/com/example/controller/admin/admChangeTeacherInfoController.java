package com.example.controller.admin;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.dao.student.studentGradeDao;
import com.example.dao.teacher.teacherInfoDao;
import com.example.entity.teacher.teacherInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import java.util.*;

@RestController
@RequestMapping("/admChangeTeacherInfoController")
public class admChangeTeacherInfoController {
    final private teacherInfoDao dao;
    final private studentGradeDao sgDao;
    @Autowired
    public admChangeTeacherInfoController(teacherInfoDao dao,studentGradeDao sgDao){
        this.dao = dao;
        this.sgDao = sgDao;
    }
    @ResponseBody
    @RequestMapping("/changeInfoById")
    // 修改老师信息
    public void test1(String numteacher,
                      String course, String college,
                      String title, String salary){
        teacherInfo teacherInfo = new teacherInfo();
        QueryWrapper<teacherInfo> uqw = new QueryWrapper<>();
        uqw.eq("numteacher",numteacher);
        teacherInfo.setNumteacher(Integer.parseInt(numteacher));
        teacherInfo.setCourse(course);
        teacherInfo.setSalary(salary);
        teacherInfo.setCollege(college);
        teacherInfo.setTitle(title);
        dao.update(teacherInfo,uqw);
    }

    @ResponseBody
    @RequestMapping("/insertInfoById")
    // 添加老师信息
    public void test2(String numteacher, String name,
                      String sex, String age, String numcourse,
                      String course, String college,
                      String title, String salary){
        teacherInfo teacherInfo = new teacherInfo();
        teacherInfo.setCourse(course);
        teacherInfo.setNumcourse(numcourse);
        teacherInfo.setSalary(salary);
        teacherInfo.setCollege(college);
        teacherInfo.setNumteacher(Integer.parseInt(numteacher));
        teacherInfo.setName(name);
        teacherInfo.setAge(age);
        teacherInfo.setSex(sex);
        teacherInfo.setTitle(title);
        dao.insert(teacherInfo); //插入
    }

    @ResponseBody
    @RequestMapping("/deleteInfoById")
    // 删除老师信息
    public String test3(String id, String name){
        Map<String,Object> map = new HashMap<>();
        map.put("numteacher",id);
        map.put("name",name);
        int result = dao.deleteByMap(map);
        Map<String,Object> map1 = new HashMap<>();
        map1.put("nameteacher",name);
        sgDao.deleteByMap(map1);

        if(result == 1)
            return "success";
        else return "error";
    }
}
