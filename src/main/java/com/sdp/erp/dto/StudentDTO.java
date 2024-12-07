package com.sdp.erp.dto;

import java.util.List;

public class StudentDTO {
   private Long studentId;
   private String name;
   private String email;
   private List<CourseDTO> courses;

   // Getters and setters
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

   public List<CourseDTO> getCourses() {
      return courses;
   }

   public void setCourses(List<CourseDTO> courses) {
      this.courses = courses;
   }
}
