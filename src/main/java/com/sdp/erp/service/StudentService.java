package com.sdp.erp.service;

import java.util.List;
import java.util.Optional;

import com.sdp.erp.dto.CourseDTO;
import com.sdp.erp.dto.StudentDTO;
import com.sdp.erp.model.Attendance;
import com.sdp.erp.model.Course;
import com.sdp.erp.model.GradePoints;
import com.sdp.erp.model.Student;

public interface StudentService {
   Student login(String name, String password);
   List<CourseDTO> getCourses();
   List<Attendance> getAttendance(Long studentId);
   List<GradePoints> getGradePoints(Long studentId);
 
   
   StudentDTO enrollInCourse(Long studentId, Long courseId);
   	List<GradePoints> viewgrades();
	List<Attendance> viewAllAttendance();
	void addStudent(Student student);
	Optional<Student> getStudentById(Long id);
	void updateStudent(Student updatedStudent);
	boolean deleteStudent(Long id);
	List<Student> getAllStudents();
	List<Course> getCoursesById(long sid);
	Course getCourseById(Long id);
}
