package com.example.controller.student;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.entity.student.studentGrade;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
@RequestMapping("/studentcourses")
public class studentCoursesController {

    @ResponseBody
    @RequestMapping("/courseInfo")
    public String studentCourse(Integer id, String classroom){
        studentGrade ss = new studentGrade();
        QueryWrapper<studentGrade> ssqw = new QueryWrapper<>();
        ssqw.le("classroom",classroom)
                .eq("id",id);
        List<studentGrade> list = ss.selectList(ssqw);
        StringBuilder str = new StringBuilder();
        str.append("[");
        for(studentGrade s : list){
            if(classroom.equals(s.getClassroom())){
                System.out.println("classroom" + classroom);
                System.out.println("s.getClassroom():" + s.getClassroom());
                System.out.println(s.getNamecourse());
                if(!str.toString().equals("["))
                    str.append(",");
                str.append("{\"num_course\":\"").append(s.getNumcourse())
                        .append("\",\"name_course\":\"").append(s.getNamecourse())
                        .append("\",\"name_teacher\":\"").append(s.getNameteacher())
                        .append("\",\"credit\":\"").append(s.getCredit())
                        .append("\"}");
            }
        }
        str.append("]");
        return str.toString();
    }

}
