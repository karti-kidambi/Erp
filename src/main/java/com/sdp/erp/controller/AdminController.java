package com.sdp.erp.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sdp.erp.model.Course;
import com.sdp.erp.model.Faculty;
import com.sdp.erp.model.Student;
import com.sdp.erp.service.AdminService;
import com.sdp.erp.service.FacultyService;
import com.sdp.erp.service.StudentService;

@Controller
@RequestMapping("/admin")
public class AdminController {
   @Autowired
   private AdminService adminService;
   @Autowired
   private FacultyService facultyService;
   @Autowired
   private StudentService studentService;


   
  
   @GetMapping("/")
   public ModelAndView adminDashboard() {
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("admin-dashboard");
       modelAndView.addObject("title", "Admin Dashboard");
       return modelAndView;
   }
   
   @GetMapping("/attendance")
   public ModelAndView adminAttendance() {
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("Adminattendance");
       modelAndView.addObject("title", "Admin Attendance");
       modelAndView.addObject("attlist", adminService.findAllAttendance());
       return modelAndView;
   }
   
   @GetMapping("/students")
   public ModelAndView adminStudents() {
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("admin/students");
       modelAndView.addObject("title", "Admin Students");
       modelAndView.addObject("studentsList", adminService.findAllStudents());
       return modelAndView;
   }  
   @GetMapping("/courses")
   public ModelAndView adminCourses() {
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("Admincourses");
       modelAndView.addObject("title", "Admin Courses");
       modelAndView.addObject("courselist", adminService.findAllCourses());
       modelAndView.addObject("facultylist", adminService.findAllFaculty());
       return modelAndView;
   }
   
   @GetMapping("/faculty")
   public ModelAndView adminFacutlies() {
       ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("admin/faculty");
       modelAndView.addObject("title", "Admin Students");
       modelAndView.addObject("facultylist", adminService.findAllFaculty());
       return modelAndView;
   }  
   
   @PostMapping("faculties")
   public String addFaculty(@ModelAttribute Faculty faculty, RedirectAttributes redirectAttributes) {
	   faculty.setPassword("erp123");
       facultyService.addFaculty(faculty);
       redirectAttributes.addFlashAttribute("message", "Faculty added successfully!");
       return "redirect:/admin/faculty";
   }
   
   @GetMapping("/edit/{id}")
   public String editFacultyPage(@PathVariable Long id, Model model) {
       Faculty faculty = facultyService.getFacultyById(id).get();
       if (faculty != null) {
           model.addAttribute("faculty", faculty);
           return "admin/editfaculty"; 
       }
       return "redirect:/admin/faculty?error=notfound";
   }

   @PostMapping("/update/{id}")
   public String updateFaculty(@PathVariable Long id, @ModelAttribute Faculty faculty) {
       Faculty existingFaculty = facultyService.getFacultyById(id).get();
       if (existingFaculty != null) {
           existingFaculty.setUsername(faculty.getUsername());
           existingFaculty.setEmail(faculty.getEmail());
           existingFaculty.setDepartment(faculty.getDepartment());
           facultyService.updateFaculty(id, faculty);
           return "redirect:/admin/faculty?success=updated";
       }
       return "redirect:/admin/faculty?error=notfound";
   }
   
   @GetMapping
   public String listStudents(Model model) {
       model.addAttribute("studentsList", studentService.getAllStudents());
       return "admin/students"; 
   }

   @PostMapping("/addstudent")
   public String addStudent(@ModelAttribute Student student, RedirectAttributes redirectAttributes) {
	   student.setPassword("erp123");
	   student.setGradepoint(0);
       studentService.addStudent(student);
       redirectAttributes.addFlashAttribute("message", "Student added successfully!");
       return "redirect:/admin/students";
   }

   @GetMapping("/student/edit/{id}")
   public ModelAndView editStudent(@PathVariable Long id) {
	   ModelAndView mv = new ModelAndView();
	   mv.setViewName("admin/editstudent");
       Student student = studentService.getStudentById(id).get();
       mv.addObject("student", student);
       return mv;
   }

   @PostMapping("/updatestudent")
   public ModelAndView updateStudent(@ModelAttribute Student student) {
       ModelAndView mv = new ModelAndView();
       try {
    	   System.out.println(student.getGradepoint());
           studentService.updateStudent(student);
           mv.setViewName("redirect:/admin/students"); 
       } catch (Exception e) {
           mv.setViewName("editstudent"); 
           mv.addObject("errorMessage", "Failed to update student: " + e.getMessage());
           mv.addObject("student", student);
       }
       return mv;
   }
   
  
   @PostMapping("/student/delete/{id}")
   public String deleteStudent(@PathVariable Long id, RedirectAttributes redirectAttributes) {
       boolean isDeleted = studentService.deleteStudent(id);
       if (isDeleted) {
           redirectAttributes.addFlashAttribute("message", "Student deleted successfully!");
       } else {
           redirectAttributes.addFlashAttribute("error", "Student not found!");
       }
       return "redirect:/admin/students";
   }

   @PostMapping("/faculty/delete/{id}")
   public String deleteFaculty(@PathVariable Long id, RedirectAttributes redirectAttributes) {
       boolean isDeleted = facultyService.deleteFaculty(id);
       if (isDeleted) {
           redirectAttributes.addFlashAttribute("message", "Faculty deleted successfully!");
       } else {
           redirectAttributes.addFlashAttribute("error", "Faculty not found!");
       }
       return "redirect:/admin/faculty";
   }
   

   @PostMapping("/addCourse")
   public String addCourse(@ModelAttribute Course course, @RequestParam Long facultyId, Model model) {
       Faculty faculty = facultyService.getFacultyById(facultyId).get();
       if (faculty != null) {
           course.getFaculties().add(faculty);
           faculty.getCourses().add(course);
           adminService.addCourse(course);
           facultyService.addFaculty(faculty);
       } else {
           model.addAttribute("error", "Faculty not found");
       }
       return "redirect:/admin/courses";
   }
   
  
}
