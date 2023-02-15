package com.example.controller.student;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.entity.student.studentGrade;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
@RequestMapping("/studentgrade")
public class studentGradeController {

    @ResponseBody
    @RequestMapping("/gradeInfo")
    public String studentgrade(String id){
        StringBuilder str = new StringBuilder();
        str.append("[");
        studentGrade sg = new studentGrade();
        QueryWrapper<studentGrade> sgqw = new QueryWrapper<>();
        sgqw.le("id",id);
        List<studentGrade> list = sg.selectList(sgqw);

        for(studentGrade s : list){
            if(id.equals(Integer.toString(s.getId()))){
                System.out.println(s.getNumcourse());
                if(!str.toString().equals("["))
                    str.append(",");
                str.append("{\"numcourse\":\"").append(s.getNumcourse())
                        .append("\",\"namecourse\":\"").append(s.getNamecourse())
                        .append("\",\"nameteacher\":\"").append(s.getNameteacher())
                        .append("\",\"grade\":\"").append(s.getGrade())
                        .append("\"}");
            }
        }
        str.append("]");
        return str.toString();
    }
}
