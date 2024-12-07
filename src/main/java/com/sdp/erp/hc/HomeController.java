package com.sdp.erp.hc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sdp.erp.dto.StudentDTO;
import com.sdp.erp.model.Admin;
import com.sdp.erp.model.Faculty;
import com.sdp.erp.model.Student;
import com.sdp.erp.service.AdminService;
import com.sdp.erp.service.FacultyService;
import com.sdp.erp.service.StudentService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	
	 @Autowired
	   private AdminService adminService;
	   @Autowired
	   private StudentService studentService;
	   @Autowired
	   private FacultyService facultyService;

    @GetMapping("/")
    public ModelAndView home() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("landing");
        modelAndView.addObject("title", "College ERP");
        return modelAndView;
    }
    
    @GetMapping("/login")
    public ModelAndView login() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("login");
        return modelAndView;
    }
    
    @PostMapping("/CheckLogin")
    public ModelAndView login(HttpServletRequest request) {
    	
    	ModelAndView mv = new ModelAndView("login");
    	
    	String username = request.getParameter("username");
    	String password = request.getParameter("password");
    	
        Admin result = adminService.login(username,password);
        Faculty faculty = facultyService.login(username, password);
        Student student = studentService.login(username, password);
        
        HttpSession session = request.getSession();
        
        if(result!=null)
        {
        	mv.setViewName("redirect:/admin/");
        }
        else if(faculty!=null)
        {
        	session.setAttribute("faculty", faculty);
        	mv.setViewName("redirect:/faculty/");
        }
        else if(student!=null)
        {
        	session.setAttribute("student", student);
        	mv.setViewName("redirect:/student/");
        }
        
        return mv;
        
    }
 
    

    @GetMapping("/student/course")
    public ModelAndView studentCourses() {
        ModelAndView modelAndView = new ModelAndView(); 
        modelAndView.setViewName("student/course");
        modelAndView.addObject("title", "Student Courses");
        return modelAndView;
    }
   

    
}
