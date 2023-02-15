package com.example.controller.admin;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.dao.student.studentGradeDao;
import com.example.dao.student.studentInfoDao;
import com.example.entity.student.studentGrade;
import com.example.entity.student.studentInfo;
import com.example.entity.teacher.teacherInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import java.util.*;

@RestController
@RequestMapping("/admChangeUserInfoController")
public class admChangeStudentInfoController {
    final private studentInfoDao dao;
    final private studentGradeDao sgDao;
    @Autowired
    public admChangeStudentInfoController(studentInfoDao dao,studentGradeDao sgDao){
        this.dao = dao;
        this.sgDao = sgDao;
    }
    private void changeCourse(String id,String name,String Classroom){
        studentGrade sg = new studentGrade();
        QueryWrapper<studentGrade> uqw = new QueryWrapper<>();
        uqw.eq("classroom",Classroom);
        List<studentGrade> lists = sg.selectList(uqw);

        List<String> find_all_teacher_names = new ArrayList<>();
        String sign_name = lists.get(0).getNamestudent(); // 获取相同班级的第一个同学的名字
        for(studentGrade list : lists) {
            if(list.getNamestudent().equals(sign_name)) {
                find_all_teacher_names.add(list.getNameteacher()); // 根据该同学姓名获取所有老师信息
            }
        }

        for(String find_all_teacher_name : find_all_teacher_names) { // 向对应老师中插入该学生课程信息
            System.out.println(find_all_teacher_name);
            studentGrade studentgrade = new studentGrade();
            studentgrade.setId(Integer.valueOf(id));
            studentgrade.setNamestudent(name);

            // 根据老师姓名，查找科目和编号
            teacherInfo tInfo = new teacherInfo();
            QueryWrapper<teacherInfo> tea = new QueryWrapper<>();
            tea.eq("name",find_all_teacher_name);
            teacherInfo teacher = tInfo.selectOne(tea);

            studentgrade.setNumcourse(teacher.getNumcourse());
            studentgrade.setNamecourse(teacher.getCourse());
            studentgrade.setNameteacher(find_all_teacher_name);
            studentgrade.setGrade("-1"); // 初始化学生成绩-1
            studentgrade.setClassroom(Classroom);
            studentgrade.setCredit(4);
            sgDao.insert(studentgrade);
        }
    }

    @ResponseBody
    @RequestMapping("/changeInfoById")
    // 修改学生信息
    public void test1(String id,String name, String age, String Classroom, String college, String hotel){
        studentInfo studentinfo = new studentInfo();
        QueryWrapper<studentInfo> uqw = new QueryWrapper<>();
        uqw.eq("id",id);
        studentinfo.setClassroom(Classroom);
        studentinfo.setHotel(hotel);
        studentinfo.setCollege(college);
        studentinfo.setAge(Integer.parseInt(age));
        dao.update(studentinfo, uqw);

        // 先删除原有班级信息
        Map<String, Object> map1 = new HashMap<>();
        map1.put("id", id);
        sgDao.deleteByMap(map1);

        // 创建新的班级信息
        changeCourse(id, name, Classroom);

    }

    @ResponseBody
    @RequestMapping("/insertInfoById")
    // 添加学生信息
    public void test2(String id, String name,
                      String sex, String age,
                      String Classroom, String college,
                      String time, String hotel){

        studentInfo studentinfo = new studentInfo();
        studentinfo.setClassroom(Classroom);
        studentinfo.setHotel(hotel);
        studentinfo.setCollege(college);
        studentinfo.setId(Integer.valueOf(id));
        studentinfo.setName(name);
        studentinfo.setAge(Integer.parseInt(age));
        studentinfo.setSex(sex);
        studentinfo.setTime(time);

        changeCourse(id, name, Classroom);
        dao.insert(studentinfo); //插入
    }

    @ResponseBody
    @RequestMapping("/deleteInfoById")
    // 删除学生信息
    public String test3(String id, String name){
        Map<String,Object> map = new HashMap<>();
        map.put("id",id);
        map.put("name",name);

        Map<String,Object> map1 = new HashMap<>();
        map1.put("id",id);

        int result_student = dao.deleteByMap(map);
        sgDao.deleteByMap(map1);

        if(result_student == 1)
            return "success";
        else return "error";
    }
}
