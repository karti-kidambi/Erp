package com.sdp.erp.service;

import java.util.List;

import com.sdp.erp.dto.StudentDTO;
import com.sdp.erp.model.Admin;
import com.sdp.erp.model.Attendance;
import com.sdp.erp.model.Course;
import com.sdp.erp.model.Faculty;
import com.sdp.erp.model.Student;

public interface AdminService {
   Admin login(String email, String password);
   Student addStudent(Student student); // Updated return type
   void deleteStudent(Long studentId);
   Student modifyStudent(Student student); // Updated return type
   Faculty addFaculty(Faculty faculty); // Updated return type
   void deleteFaculty(Long facultyId);
   Faculty modifyFaculty(Faculty faculty); // Updated return type
   Course addCourse(Course course); // Updated return type
   void deleteCourse(Long courseId);
   Course modifyCourse(Course course);// Updated return type
   List<Object> getAllStudents();
   List<Attendance> findAllAttendance();
   List<Course> findAllCourses();
   List<Faculty> findAllFaculty();
   List<Student> findAllStudents();
}
