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
   private Long courseId;
   private String subject;
   private Float grade; // represent grade points (0 to 10)
   private Float internalMarks; // mid-semester / internal (out of 30)
   private Float externalMarks; // end-semester / external (out of 70)
   private Float totalMarks; // sum of internal + external
   private String gradeLetter; // O, A+, A, B+, B, C, P, F

   public void calculateGrade() {
       float internal = this.internalMarks != null ? this.internalMarks : 0.0f;
       float external = this.externalMarks != null ? this.externalMarks : 0.0f;
       this.totalMarks = internal + external;
       
       if (this.totalMarks >= 90) {
           this.gradeLetter = "O";
           this.grade = 10.0f;
       } else if (this.totalMarks >= 80) {
           this.gradeLetter = "A+";
           this.grade = 9.0f;
       } else if (this.totalMarks >= 70) {
           this.gradeLetter = "A";
           this.grade = 8.0f;
       } else if (this.totalMarks >= 60) {
           this.gradeLetter = "B+";
           this.grade = 7.0f;
       } else if (this.totalMarks >= 50) {
           this.gradeLetter = "B";
           this.grade = 6.0f;
       } else if (this.totalMarks >= 45) {
           this.gradeLetter = "C";
           this.grade = 5.0f;
       } else if (this.totalMarks >= 40) {
           this.gradeLetter = "P";
           this.grade = 4.0f;
       } else {
           this.gradeLetter = "F";
           this.grade = 0.0f;
       }
   }

   // Getters and Setters
   public Long getId() {
       return id;
   }
   public void setId(Long id) {
       this.id = id;
   }
   public Long getStudentId() {
       return studentId;
   }
   public void setStudentId(Long studentId) {
       this.studentId = studentId;
   }
   public Long getCourseId() {
       return courseId;
   }
   public void setCourseId(Long courseId) {
       this.courseId = courseId;
   }
   public String getSubject() {
       return subject;
   }
   public void setSubject(String subject) {
       this.subject = subject;
   }
   public Float getGrade() {
       return grade;
   }
   public void setGrade(Float grade) {
       this.grade = grade;
   }
   public Float getInternalMarks() {
       return internalMarks;
   }
   public void setInternalMarks(Float internalMarks) {
       this.internalMarks = internalMarks;
       calculateGrade();
   }
   public Float getExternalMarks() {
       return externalMarks;
   }
   public void setExternalMarks(Float externalMarks) {
       this.externalMarks = externalMarks;
       calculateGrade();
   }
   public Float getTotalMarks() {
       return totalMarks;
   }
   public void setTotalMarks(Float totalMarks) {
       this.totalMarks = totalMarks;
   }
   public String getGradeLetter() {
       return gradeLetter;
   }
   public void setGradeLetter(String gradeLetter) {
       this.gradeLetter = gradeLetter;
   }
}
