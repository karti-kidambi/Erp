package com.sdp.erp.dto;

import java.util.List;

public class CourseDTO { 
	private Long courseId;
	private String courseName;
	private List<StudentDTO> students; 
	// Getters and setters
	public Long getCourseId() {
		return courseId;
	}
	public void setCourseId(Long courseId) {
		this.courseId = courseId;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public List<StudentDTO> getStudents() {
		return students;
	}
	public void setStudents(List<StudentDTO> students) {
		this.students = students;
	}
	
}