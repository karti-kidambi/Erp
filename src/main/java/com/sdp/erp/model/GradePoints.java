package com.sdp.erp.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class GradePoints {
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   private Long id;
   private Long studentId;
   private String subject;
   private Float grade;
   // getters and setters
public Long getId() {
	return id;
}
public Long getStudentId() {
	return studentId;
}
public String getSubject() {
	return subject;
}
public Float getGrade() {
	return grade;
}
public void setId(Long id) {
	this.id = id;
}
public void setStudentId(Long studentId) {
	this.studentId = studentId;
}
public void setSubject(String subject) {
	this.subject = subject;
}
public void setGrade(Float grade) {
	this.grade = grade;
}
}
