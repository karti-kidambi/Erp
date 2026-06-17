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
   public ModelAndView studentDashboard(HttpServletRequest request) {
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("student-dashboard");
       modelAndView.addObject("title", "Student Dashboard");
       
       HttpSession session = request.getSession();
       Student s = (Student) session.getAttribute("student");
       if (s != null) {
           List<Course> courses = studentService.getCoursesById(s.getStudentId());
           List<GradePoints> grades = studentService.getGradePoints(s.getStudentId());
           List<Attendance> attendanceList = studentService.getAttendance(s.getStudentId());
           
           // Create a map for course grades
           Map<Long, GradePoints> courseGrades = new HashMap<>();
           for (GradePoints gp : grades) {
               courseGrades.put(gp.getCourseId(), gp);
           }
           
           // Calculate SGPA
           float totalCredits = 0;
           float totalPoints = 0;
           for (Course c : courses) {
               totalCredits += c.getCredits();
               GradePoints gp = courseGrades.get(c.getCourseId());
               float gpValue = (gp != null && gp.getGrade() != null) ? gp.getGrade() : 0.0f;
               totalPoints += gpValue * c.getCredits();
           }
           float sgpa = totalCredits > 0 ? (totalPoints / totalCredits) : 0.0f;
           
           // Calculate attendance per course
           Map<Long, Double> courseAttendance = new HashMap<>();
           Map<Long, Integer> presentCount = new HashMap<>();
           Map<Long, Integer> totalCount = new HashMap<>();
           
           for (Attendance att : attendanceList) {
               Long cId = att.getCourseId();
               totalCount.put(cId, totalCount.getOrDefault(cId, 0) + 1);
               if ("Present".equalsIgnoreCase(att.getStatus())) {
                   presentCount.put(cId, presentCount.getOrDefault(cId, 0) + 1);
               }
           }
           
           int overallPresent = 0;
           int overallTotal = 0;
           for (Course c : courses) {
               int present = presentCount.getOrDefault(c.getCourseId(), 0);
               int total = totalCount.getOrDefault(c.getCourseId(), 0);
               double pct = total > 0 ? ((double) present / total) * 100.0 : 100.0;
               courseAttendance.put(c.getCourseId(), pct);
               
               overallPresent += present;
               overallTotal += total;
           }
           double overallAttendance = overallTotal > 0 ? ((double) overallPresent / overallTotal) * 100.0 : 100.0;
           
           modelAndView.addObject("courses", courses);
           modelAndView.addObject("courseGrades", courseGrades);
           modelAndView.addObject("sgpa", String.format("%.2f", sgpa));
           modelAndView.addObject("courseAttendance", courseAttendance);
           modelAndView.addObject("overallAttendance", String.format("%.1f", overallAttendance));
       }
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
   public ModelAndView studentAttendance(@PathVariable Long studentId) {
       ModelAndView modelAndView = new ModelAndView();
       
       List<Attendance> attlist = studentService.getAttendance(studentId);
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
   public ModelAndView viewGrades(HttpServletRequest request) {
       ModelAndView modelAndView = new ModelAndView();
       HttpSession session = request.getSession();
       Student s = (Student) session.getAttribute("student");
       if (s != null) {
           List<GradePoints> gradePoints = studentService.getGradePoints(s.getStudentId());
           modelAndView.addObject("gradePoints", gradePoints);
       }
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
