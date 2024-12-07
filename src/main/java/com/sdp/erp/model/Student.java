package com.sdp.erp.model;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;

@Entity
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long studentId;

    private String name;
    private String email;
    private String course;
    private String password;
    @ManyToMany @JoinTable( name = "student_course", 
    		joinColumns = @JoinColumn(name = "student_id"), 
    		inverseJoinColumns = @JoinColumn(name = "course_id") 
    ) 
    private List<Course> courses = new ArrayList<>();
    
    private int gradepoint;
    public List<Course> getCourses(){
    	return courses;
    }
    public void setCourses(List<Course>courses) {
    	this.courses=courses;
    }

    // Getters and Setters
    public Long getStudentId() {
        return studentId;
    }

    public void setStudentId(Long studentId) {
        this.studentId = studentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getGradepoint() {
		return gradepoint;
	}
	public void setGradepoint(int gradepoint) {
		this.gradepoint = gradepoint;
	}

	
}
