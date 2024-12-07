package com.sdp.erp.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdp.erp.dto.StudentDTO;
import com.sdp.erp.model.Admin;
import com.sdp.erp.model.Attendance;
import com.sdp.erp.model.Course;
import com.sdp.erp.model.Faculty;
import com.sdp.erp.model.Student;
import com.sdp.erp.repository.AdminRepository;
import com.sdp.erp.repository.AttendanceRepository;
import com.sdp.erp.repository.CourseRepository;
import com.sdp.erp.repository.FacultyRepository;
import com.sdp.erp.repository.StudentRepository;

@Service
public class AdminServiceImpl implements AdminService {
   @Autowired
   private AdminRepository adminRepository;
   @Autowired
   private StudentRepository studentRepository;
   @Autowired
   private FacultyRepository facultyRepository;
   @Autowired
   private CourseRepository courseRepository;
   @Autowired
   private AttendanceRepository attendanceRepository;


   @Override
   public Admin login(String email, String password) {
	      Admin admin = adminRepository.findByUsernameAndPassword(email,password);
	         return admin;
	   }
   

   @Override
   public Student addStudent(Student student) {
      return studentRepository.save(student); // Ensure the created Student is returned
   }

   @Override
   public void deleteStudent(Long studentId) {
      studentRepository.deleteById(studentId);
   }

   @Override
   public Student modifyStudent(Student student) {
      return studentRepository.save(student); // Ensure the updated Student is returned
   }
   @Override
   public List<Object> getAllStudents() {
      List<Student> students = studentRepository.findAll();
      return students.stream().map(this::convertToDTO).collect(Collectors.toList());
   }

   @Override
   public Faculty addFaculty(Faculty faculty) {
      return facultyRepository.save(faculty); // Ensure the created Faculty is returned
   }

   @Override
   public void deleteFaculty(Long facultyId) {
      facultyRepository.deleteById(facultyId);
   }

   @Override
   public Faculty modifyFaculty(Faculty faculty) {
      return facultyRepository.save(faculty); // Ensure the updated Faculty is returned
   }

   @Override
   public Course addCourse(Course course) {
      return courseRepository.save(course); // Ensure the created Course is returned
   }

   @Override
   public void deleteCourse(Long courseId) {
      courseRepository.deleteById(courseId);
   }

   @Override
   public Course modifyCourse(Course course) {
      return courseRepository.save(course); // Ensure the updated Course is returned
   }
   
   @Override
   public List<Attendance> findAllAttendance() {
      return attendanceRepository.findAll(); // Ensure the updated Course is returned
   }
   
   @Override
   public List<Course> findAllCourses() {
      return courseRepository.findAll(); // Ensure the updated Course is returned
   }
   @Override
   public List<Faculty> findAllFaculty() {
      return facultyRepository.findAll(); // Ensure the updated Course is returned
   }
   
   @Override
   public List<Student> findAllStudents() {
      return studentRepository.findAll(); // Ensure the updated Course is returned
   }
   
   
private <R> R convertToDTO(Student student1) {
	return null;
}
}
