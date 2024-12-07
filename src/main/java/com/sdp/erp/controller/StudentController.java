package com.sdp.erp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sdp.erp.dto.CourseDTO;
import com.sdp.erp.dto.StudentDTO;
import com.sdp.erp.model.Attendance;
import com.sdp.erp.model.Course;
import com.sdp.erp.model.GradePoints;
import com.sdp.erp.model.Student;
import com.sdp.erp.service.StudentService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/student")
public class StudentController {
   @Autowired
   private StudentService studentService;

   @GetMapping("/")
   public ModelAndView studentDashboard() {
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("student-dashboard");
       modelAndView.addObject("title", "Student Dashboard");
       return modelAndView;
   }

   @GetMapping("/courses")
   public ModelAndView getCourses(HttpServletRequest request) {
	   ModelAndView mv = new ModelAndView("student/course");
	   HttpSession session = request.getSession();
	   Student  s =(Student) session.getAttribute("student");
      List<Course> courses = studentService.getCoursesById(s.getStudentId());
      mv.addObject("courses", courses);
      return mv;
   }

   @GetMapping("/attendance/{studentId}")
   public ModelAndView studentAttendance(@PathVariable int studentId) {
       ModelAndView modelAndView = new ModelAndView();
       
       List<Attendance> attlist = studentService.viewAllAttendance();
       List<CourseDTO> clist = studentService.getCourses(); // Assume this fetches all courses
       
       // Create a map for fast course lookup (Course ID -> Course Name)
       Map<Long, String> courseMap = new HashMap<>();
       for (CourseDTO course : clist) {
           courseMap.put(course.getCourseId(), course.getCourseName());
       }
       
       modelAndView.addObject("attlist", attlist);
       modelAndView.addObject("courseMap", courseMap);
       modelAndView.setViewName("Studentattendance");
       modelAndView.addObject("title", "Student Attendance");
       return modelAndView;
   }


   @GetMapping("/viewGrades")
   public ModelAndView viewGrades() {
       ModelAndView modelAndView = new ModelAndView();
       List<GradePoints> gradePoints = studentService.viewgrades(); // Assuming this returns a list of grade points
       modelAndView.addObject("gradePoints", gradePoints);
       modelAndView.setViewName("viewGrades");
       modelAndView.addObject("title", "View Grades");
       return modelAndView;
   }

   @PostMapping("/{studentId}/enroll/{courseId}")
   public ResponseEntity<StudentDTO> enrollInCourse(@PathVariable Long studentId, @PathVariable Long courseId) {
      StudentDTO student = studentService.enrollInCourse(studentId, courseId);
      return ResponseEntity.ok(student);
   }
}
