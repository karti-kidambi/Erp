package com.sdp.erp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import com.sdp.erp.model.Admin;
import com.sdp.erp.model.Course;
import com.sdp.erp.model.Faculty;
import com.sdp.erp.model.Student;
import com.sdp.erp.model.Attendance;
import com.sdp.erp.model.GradePoints;
import com.sdp.erp.repository.AdminRepository;
import com.sdp.erp.repository.CourseRepository;
import com.sdp.erp.repository.FacultyRepository;
import com.sdp.erp.repository.StudentRepository;
import com.sdp.erp.repository.AttendanceRepository;
import com.sdp.erp.repository.GradePointsRepository;

import java.util.ArrayList;
import java.util.List;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private AdminRepository adminRepository;

    @Autowired
    private FacultyRepository facultyRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private AttendanceRepository attendanceRepository;

    @Autowired
    private GradePointsRepository gradePointsRepository;

    @Override
    public void run(String... args) throws Exception {
        // 1. Seed Admin
        if (adminRepository.count() == 0) {
            Admin admin = new Admin();
            admin.setUsername("admin");
            admin.setPassword("admin");
            adminRepository.save(admin);
        }

        // 2. Seed Faculty
        Faculty faculty1 = null;
        Faculty faculty2 = null;
        if (facultyRepository.count() == 0) {
            faculty1 = new Faculty();
            faculty1.setUsername("DR.Srinivas");
            faculty1.setEmail("srinivas@donk.edu.in");
            faculty1.setPassword("faculty");
            faculty1.setDepartment("Computer Science");
            faculty1 = facultyRepository.save(faculty1);

            faculty2 = new Faculty();
            faculty2.setUsername("Prof. Sunita Sharma");
            faculty2.setEmail("sunita@donk.edu.in");
            faculty2.setPassword("faculty");
            faculty2.setDepartment("Electronics");
            faculty2 = facultyRepository.save(faculty2);
        } else {
            faculty1 = facultyRepository.findAll().get(0);
            faculty2 = facultyRepository.findAll().get(0);
        }

        // 3. Seed Courses
        Course course1 = null;
        Course course2 = null;
        Course course3 = null;
        if (courseRepository.count() == 0) {
            course1 = new Course();
            course1.setCourseName("Data Structures & Algorithms");
            course1.setDepartment("Computer Science");
            course1.setCredits(4);
            course1.getFaculties().add(faculty1);
            course1 = courseRepository.save(course1);

            course2 = new Course();
            course2.setCourseName("Database Management Systems");
            course2.setDepartment("Computer Science");
            course2.setCredits(4);
            course2.getFaculties().add(faculty1);
            course2 = courseRepository.save(course2);

            course3 = new Course();
            course3.setCourseName("Digital System Design");
            course3.setDepartment("Electronics");
            course3.setCredits(3);
            course3.getFaculties().add(faculty2);
            course3 = courseRepository.save(course3);
            
            // Link courses back to faculty
            faculty1.getCourses().add(course1);
            faculty1.getCourses().add(course2);
            facultyRepository.save(faculty1);
            
            faculty2.getCourses().add(course3);
            facultyRepository.save(faculty2);
        } else {
            List<Course> courses = courseRepository.findAll();
            course1 = courses.get(0);
            if (courses.size() > 1) course2 = courses.get(1);
            if (courses.size() > 2) course3 = courses.get(2);
        }

        // 4. Seed Students
        Student student1 = null;
        Student student2 = null;
        if (studentRepository.count() == 0) {
            student1 = new Student();
            student1.setName("K. Kartik");
            student1.setEmail("kartik@student.donk.edu.in");
            student1.setPassword("student");
            student1.setRollNumber("2200030797");
            student1.setSemester(6);
            student1.setDepartment("Computer Science");
            student1.setSection("A");
            student1.setGradepoint(0);
            student1.getCourses().add(course1);
            student1.getCourses().add(course2);
            student1 = studentRepository.save(student1);

            student2 = new Student();
            student2.setName("Sneha Reddy");
            student2.setEmail("sneha@student.donk.edu.in");
            student2.setPassword("student");
            student2.setRollNumber("DONK2026EC204");
            student2.setSemester(4);
            student2.setDepartment("Electronics");
            student2.setSection("B");
            student2.setGradepoint(0);
            student2.getCourses().add(course3);
            student2 = studentRepository.save(student2);
        } else {
            List<Student> students = studentRepository.findAll();
            student1 = students.get(0);
            if (students.size() > 1) student2 = students.get(1);
        }

        // 5. Seed Attendance
        if (attendanceRepository.count() == 0 && student1 != null && course1 != null && course2 != null) {
            // CS301 (Data Structures) Attendance: 4 Present, 1 Absent (80% - Safe)
            saveAttendanceRecord(course1.getCourseId(), student1.getStudentId(), "2026-06-10", "Present");
            saveAttendanceRecord(course1.getCourseId(), student1.getStudentId(), "2026-06-11", "Present");
            saveAttendanceRecord(course1.getCourseId(), student1.getStudentId(), "2026-06-12", "Present");
            saveAttendanceRecord(course1.getCourseId(), student1.getStudentId(), "2026-06-13", "Absent");
            saveAttendanceRecord(course1.getCourseId(), student1.getStudentId(), "2026-06-14", "Present");

            // CS302 (DBMS) Attendance: 3 Present, 2 Absent (60% - Shortage Warning!)
            saveAttendanceRecord(course2.getCourseId(), student1.getStudentId(), "2026-06-10", "Present");
            saveAttendanceRecord(course2.getCourseId(), student1.getStudentId(), "2026-06-11", "Absent");
            saveAttendanceRecord(course2.getCourseId(), student1.getStudentId(), "2026-06-12", "Present");
            saveAttendanceRecord(course2.getCourseId(), student1.getStudentId(), "2026-06-13", "Absent");
            saveAttendanceRecord(course2.getCourseId(), student1.getStudentId(), "2026-06-14", "Present");
            
            // EC201 Attendance for Student 2: 5 Present (100% - Safe)
            if (student2 != null && course3 != null) {
                saveAttendanceRecord(course3.getCourseId(), student2.getStudentId(), "2026-06-10", "Present");
                saveAttendanceRecord(course3.getCourseId(), student2.getStudentId(), "2026-06-11", "Present");
                saveAttendanceRecord(course3.getCourseId(), student2.getStudentId(), "2026-06-12", "Present");
                saveAttendanceRecord(course3.getCourseId(), student2.getStudentId(), "2026-06-13", "Present");
                saveAttendanceRecord(course3.getCourseId(), student2.getStudentId(), "2026-06-14", "Present");
            }
        }

        // 6. Seed Grade/Marks
        if (gradePointsRepository.count() == 0 && student1 != null && course1 != null && course2 != null) {
            // CS301 Marks: Internal=25, External=55 -> Total=80, Grade=A+, Point=9
            saveGradeRecord(student1.getStudentId(), course1.getCourseId(), course1.getCourseName(), 25.0f, 55.0f);
            
            // CS302 Marks: Internal=20, External=45 -> Total=65, Grade=B+, Point=7
            saveGradeRecord(student1.getStudentId(), course2.getCourseId(), course2.getCourseName(), 20.0f, 45.0f);
            
            // EC201 Marks for Student 2: Internal=28, External=64 -> Total=92, Grade=O, Point=10
            if (student2 != null && course3 != null) {
                saveGradeRecord(student2.getStudentId(), course3.getCourseId(), course3.getCourseName(), 28.0f, 64.0f);
            }
        }
    }

    private void saveAttendanceRecord(Long courseId, Long studentId, String date, String status) {
        Attendance att = new Attendance();
        att.setCourseId(courseId);
        att.setStudentId(studentId);
        att.setDate(date);
        att.setStatus(status);
        attendanceRepository.save(att);
    }

    private void saveGradeRecord(Long studentId, Long courseId, String subjectName, float internal, float external) {
        GradePoints gp = new GradePoints();
        gp.setStudentId(studentId);
        gp.setCourseId(courseId);
        gp.setSubject(subjectName);
        gp.setInternalMarks(internal);
        gp.setExternalMarks(external);
        gp.calculateGrade();
        gradePointsRepository.save(gp);
    }
}
