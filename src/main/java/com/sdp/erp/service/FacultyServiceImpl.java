package com.sdp.erp.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdp.erp.model.Attendance;
import com.sdp.erp.model.Course;
import com.sdp.erp.model.Faculty;
import com.sdp.erp.model.Student;
import com.sdp.erp.repository.AttendanceRepository;
import com.sdp.erp.repository.CourseRepository;
import com.sdp.erp.repository.FacultyRepository;
import com.sdp.erp.repository.GradePointsRepository;
import com.sdp.erp.repository.StudentRepository;

@Service
public class FacultyServiceImpl implements FacultyService {
   @Autowired
   private FacultyRepository facultyRepository;
   @Autowired
   private StudentRepository studentRepository;
   @Autowired
   private AttendanceRepository attendanceRepository;
   @Autowired
   private GradePointsRepository gradePointsRepository;
   @Autowired
   private CourseRepository courseRepository;
   @Override
   public Faculty login(String username, String password) {
      Faculty faculty = facultyRepository.findByEmailAndPassword(username, password);
         return faculty;
   }
  
   @Override
   public Faculty addFaculty(Faculty faculty) {
       return facultyRepository.save(faculty);
   }

   @Override
   public List<Faculty> getAllFaculties() {
       return facultyRepository.findAll();
   }

   @Override
   public Optional<Faculty> getFacultyById(Long id) {
       return facultyRepository.findById(id);
   }

   @Override
   public boolean updateFaculty(Long id, Faculty updatedFaculty) {
       Optional<Faculty> existingFaculty = facultyRepository.findById(id);
       if (existingFaculty.isPresent()) {
           Faculty faculty = existingFaculty.get();
           faculty.setUsername(updatedFaculty.getUsername());
           faculty.setEmail(updatedFaculty.getEmail());
           faculty.setDepartment(updatedFaculty.getDepartment());
           facultyRepository.save(faculty);
           return true;
       }
       return false;
   }
   @Override
   public boolean deleteFaculty(Long id) {
       if (facultyRepository.existsById(id)) {
           facultyRepository.deleteById(id);
           return true;
       }
       return false;
   }
   
   public List<Student> getStudentsByCourseId(Long courseId) {
       Course course = courseRepository.findById(courseId)
               .orElseThrow(() -> new RuntimeException("Course not found for ID: " + courseId));       
       return course.getStudents();
   }
   
   @Override
   public List<Course> getCoursesByFacultyId(Long facultyId) {
	    Faculty faculty = facultyRepository.findById(facultyId).orElseThrow(() -> new RuntimeException("Faculty not found"));
	    return faculty.getCourses();
	}
   
   @Override
   public List<Student> getAllStudents() {
      return studentRepository.findAll();
   }
   
   @Override
   public List<Attendance> getAttendanceByCourseAndDate(Long courseId, String date) {
       return attendanceRepository.findByCourseIdAndDate(courseId, date);
   }
   
   @Override
   public void saveAttendance(List<Attendance> attendanceList) {
       attendanceRepository.saveAll(attendanceList);
   }

}
