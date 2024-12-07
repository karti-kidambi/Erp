package com.sdp.erp.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdp.erp.dto.CourseDTO;
import com.sdp.erp.dto.StudentDTO;
import com.sdp.erp.model.Attendance;
import com.sdp.erp.model.Course;
import com.sdp.erp.model.GradePoints;
import com.sdp.erp.model.Student;
import com.sdp.erp.repository.AttendanceRepository;
import com.sdp.erp.repository.CourseRepository;
import com.sdp.erp.repository.GradePointsRepository;
import com.sdp.erp.repository.StudentRepository;

@Service
public class StudentServiceImpl implements StudentService {
   @Autowired
   private StudentRepository studentRepository;
   @Autowired
   private CourseRepository courseRepository;
   @Autowired
   private GradePointsRepository gradePointsRepository;
   @Autowired
   private AttendanceRepository attendanceRepository;

   @Override
   public Student login(String email, String password) {
      Student student = studentRepository.findByEmailAndPassword(email,password);
      if(student!=null)
         return student;
      return null;
   }

   @Override
   public List<CourseDTO> getCourses() {
      List<Course> courses = courseRepository.findAll();
      return courses.stream().map(this::convertToDTO).collect(Collectors.toList());
   }
   
   @Override
   public List<Course> getCoursesById(long sid) {
      List<Course> courses = studentRepository.findAllCourses(sid);
      return courses;
   }

   @Override
   public List<Attendance> getAttendance(Long studentId) {
      return attendanceRepository.findByStudentId(studentId);
   }
   
   @Override
   public List<Attendance> viewAllAttendance() {
      return attendanceRepository.findAll();
   }

   @Override
   public List<GradePoints> getGradePoints(Long studentId) {
      return gradePointsRepository.findByStudentId(studentId);
   }
   
   @Override
   public List<GradePoints> viewgrades() {
      return gradePointsRepository.findAll();
   }
   @Override
   public List<Student> getAllStudents() {
       return studentRepository.findAll();
   }

   @Override
   public void addStudent(Student student) {
       studentRepository.save(student);
   }

   @Override
   public Optional<Student> getStudentById(Long id) {
       return studentRepository.findById(id);
   }

   @Override
   public void updateStudent(Student student) {
       Student existingStudent = studentRepository.findById(student.getStudentId())
                                   .orElseThrow(() -> new RuntimeException("Student not found"));
       
       existingStudent.setName(student.getName());
       existingStudent.setEmail(student.getEmail());
       existingStudent.setGradepoint(student.getGradepoint());

       studentRepository.save(existingStudent);
   }
   @Override
   public boolean deleteStudent(Long id) {
       if (studentRepository.existsById(id)) {
           studentRepository.deleteById(id);
           return true;
       }
       return false;
   }

   @Override
   public StudentDTO enrollInCourse(Long studentId, Long courseId) {
      Student student = studentRepository.findById(studentId).orElseThrow(() -> new RuntimeException("Student not found"));
      Course course = courseRepository.findById(courseId).orElseThrow(() -> new RuntimeException("Course not found"));

      if (student.getCourses().stream().noneMatch(c -> c.getCourseId().equals(courseId))) {
         student.getCourses().add(course);
      }

      studentRepository.save(student);
      return convertToDTO(student);
   }
   
   @Override
   public Course getCourseById(Long id) {
       return courseRepository.findById(id).get();
   }
   
   
   
   
   private StudentDTO convertToDTO(Student student) {
      StudentDTO studentDTO = new StudentDTO();
      studentDTO.setStudentId(student.getStudentId());
      studentDTO.setName(student.getName());
      studentDTO.setEmail(student.getEmail());

      List<CourseDTO> courseDTOs = new ArrayList<>();
      for (Course course : student.getCourses()) {
         CourseDTO courseDTO = new CourseDTO();
         courseDTO.setCourseId(course.getCourseId());
         courseDTO.setCourseName(course.getCourseName());
         courseDTOs.add(courseDTO);
      }

      studentDTO.setCourses(courseDTOs);
      return studentDTO;
   }

   private CourseDTO convertToDTO(Course course) {
      CourseDTO courseDTO = new CourseDTO();
      courseDTO.setCourseId(course.getCourseId());
      courseDTO.setCourseName(course.getCourseName());

      List<StudentDTO> studentDTOs = new ArrayList<>();
      for (Student student : course.getStudents()) {
         StudentDTO studentDTO = new StudentDTO();
         studentDTO.setStudentId(student.getStudentId());
         studentDTO.setName(student.getName());
         studentDTO.setEmail(student.getEmail());
         studentDTOs.add(studentDTO);
      }

      courseDTO.setStudents(studentDTOs);
      return courseDTO;
   }
}
