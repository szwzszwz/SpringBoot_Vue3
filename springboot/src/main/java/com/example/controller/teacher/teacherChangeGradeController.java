package com.example.controller.teacher;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.dao.student.studentGradeDao;
import com.example.entity.student.studentGrade;
import com.example.entity.teacher.teacherInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import java.util.*;


@RestController
@RequestMapping("/teacherChangeGradeController")
public class teacherChangeGradeController {

    @ResponseBody
    @RequestMapping("/returnClass")
    public String returnClass(String numteacher) {
        StringBuilder str = new StringBuilder();
        str.append("[");
        String course = "";

        teacherInfo ti = new teacherInfo();
        QueryWrapper<teacherInfo> tiqw = new QueryWrapper<>();
        tiqw.eq("numteacher", numteacher);
        List<teacherInfo> list = ti.selectList(tiqw);

        for (teacherInfo t : list) {
            if (numteacher.equals(Integer.toString(t.getNumteacher())))
                course = t.getCourse();
        }
        studentGrade sg = new studentGrade();
        QueryWrapper<studentGrade> sgqw = new QueryWrapper<>();
        sgqw.eq("namecourse", course);
        List<studentGrade> list1 = sg.selectList(sgqw);
        int i = 1;
        HashSet<String> set = new HashSet<>();
        for (studentGrade s : list1) {
            if (course.equals(s.getNamecourse())) {
                set.add(s.getClassroom());
            }
        }
        for (String a : set){
            if(!str.toString().equals("["))
                str.append(",");
            str.append("{\"Class").append(i)
                    .append("\":\"").append(a)
                    .append("\"}");
            i++;
        }
        str.append("]");
        return str.toString();
    }

    @ResponseBody
    @RequestMapping("/returngrade")
    public String returngrade(String classroom, String numteacher) {
        StringBuilder str = new StringBuilder();
        str.append("[");
        String course = "";
        teacherInfo ti = new teacherInfo();
        QueryWrapper<teacherInfo> tiqw = new QueryWrapper<>();
        tiqw.le("numteacher", numteacher);
        List<teacherInfo> list = ti.selectList(tiqw);
        for (teacherInfo t : list) {
            if (numteacher.equals(Integer.toString(t.getNumteacher())))
                course = t.getCourse();
        }
        studentGrade sg = new studentGrade();
        QueryWrapper<studentGrade> sgqw = new QueryWrapper<>();
        sgqw.le("classroom", classroom);
        List<studentGrade> list2 = sg.selectList(sgqw);

        for (studentGrade s : list2) {
            if (course.equals(s.getNamecourse()) && classroom.equals(s.getClassroom())) {
                if (!str.toString().equals("["))
                    str.append(",");
                str.append("{\"id\":\"").append(s.getId())
                        .append("\",\"namestudent\":\"").append(s.getNamestudent())
                        .append("\",\"namecourse\":\"").append(s.getNamecourse())
                        .append("\",\"grade\":\"").append(s.getGrade())
                        .append("\"}");
            }
        }
        str.append("]");
        return str.toString();
    }

    final private studentGradeDao dao;

    @Autowired
    public teacherChangeGradeController(studentGradeDao dao){
        this.dao = dao;
    }

    @ResponseBody
    @RequestMapping("/changevalue")
    public void returngrade(String id, String namecourse, String grade) {
        studentGrade sg = new studentGrade();
        QueryWrapper<studentGrade> sgqw = new QueryWrapper<>();
        sgqw.eq("id", id)
                .eq("namecourse", namecourse);
        sg.setGrade(grade);
        dao.update(sg, sgqw);
    }
}





