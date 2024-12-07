package com.sdp.erp.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sdp.erp.model.Attendance;
import com.sdp.erp.model.Course;
import com.sdp.erp.model.Faculty;
import com.sdp.erp.model.Student;
import com.sdp.erp.service.FacultyService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/faculty")
public class FacultyController {
   @Autowired
   private FacultyService facultyService;

   
   
   
   @GetMapping("/")
   public ModelAndView facultyDashboard() {
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("faculty-dashboard");
       modelAndView.addObject("title", "Faculty Dashboard");
       return modelAndView;
   }
   
   @GetMapping("/courses")
   public ModelAndView facultyCourses(@RequestParam Long facultyId) {
       ModelAndView modelAndView = new ModelAndView();
       List<Course> courses = facultyService.getCoursesByFacultyId(facultyId);
       List<Course> uniqueCourses = courses.stream()
    		    .distinct()
    		    .collect(Collectors.toList());

       modelAndView.addObject("courses", uniqueCourses);
       modelAndView.setViewName("faculty/courses");
       return modelAndView;
   }
   
   @PostMapping("/uploadMaterial")
   public String uploadMaterial(
           @RequestParam String materialType,
           @RequestParam MultipartFile materialFile,
           @RequestParam String description,HttpServletRequest request) {
	   HttpSession session = request.getSession();
	   Faculty f = (Faculty) session.getAttribute("faculty");
       return "redirect:/faculty/courses?facultyId="+f.getFacultyId();
   }
   
   @GetMapping("/assignments")
   public ModelAndView manageAssignments() {
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("faculty/assignments");
       return modelAndView;
   }
   @GetMapping("/students")
   public ModelAndView displayStudents(@RequestParam long courseId) {
       ModelAndView modelAndView = new ModelAndView();
       List<Student> students = facultyService.getStudentsByCourseId(courseId);
       modelAndView.addObject("students", students);
       modelAndView.setViewName("faculty/students");
       return modelAndView;
   }
   
   @GetMapping("/getstudents")
   public ModelAndView viewStudents() {
       ModelAndView modelAndView = new ModelAndView();
       List<Student> students = facultyService.getAllStudents();
       modelAndView.addObject("students", students);
       modelAndView.setViewName("faculty/students");
       return modelAndView;
   }


   
   @GetMapping("/attendance")
   public ModelAndView facultyAttendance(@RequestParam Long facultyId) {
	   ModelAndView modelAndView = new ModelAndView();
       List<Course> courses = facultyService.getCoursesByFacultyId(facultyId); 
       List<Course> uniqueCourses = courses.stream()
    		    .distinct()
    		    .collect(Collectors.toList());

       modelAndView.addObject("courses", uniqueCourses); 
       List<Student> students = facultyService.getAllStudents();
       modelAndView.addObject("students", students);
       
       String currentDate = LocalDate.now().toString();
       modelAndView.addObject("currentDate", currentDate); 
       
       modelAndView.setViewName("faculty/attendance"); 
       return modelAndView;
   }

   
   @PostMapping("/attendance/save")
   public String saveAttendance(HttpServletRequest request, RedirectAttributes redirectAttributes) {
       HttpSession session = request.getSession();
       Faculty faculty = (Faculty) session.getAttribute("faculty");

       try {
           Long courseId = Long.valueOf(request.getParameter("courseId"));
           String date = request.getParameter("date");

           List<Attendance> attendanceList = new ArrayList<>();
           Enumeration<String> parameterNames = request.getParameterNames();

           while (parameterNames.hasMoreElements()) {
               String paramName = parameterNames.nextElement();

               if (paramName.startsWith("attendance-")) {
                   Long studentId = Long.valueOf(paramName.substring("attendance-".length()));
                   String status = request.getParameter(paramName);
                   String remarks = request.getParameter("remarks-" + studentId);

                   Attendance attendance = new Attendance();
                   attendance.setCourseId(courseId);
                   attendance.setStudentId(studentId);
                   attendance.setDate(date);
                   attendance.setStatus(status);
                   attendanceList.add(attendance);
               }
           }

           facultyService.saveAttendance(attendanceList);

           redirectAttributes.addFlashAttribute("successMessage", "Attendance saved successfully!");
       } catch (Exception e) {
           e.printStackTrace();
           redirectAttributes.addFlashAttribute("errorMessage", "Failed to save attendance. Please try again.");
       }

       return "redirect:/faculty/";
   }


}
