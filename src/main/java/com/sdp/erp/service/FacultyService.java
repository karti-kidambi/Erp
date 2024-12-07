package com.sdp.erp.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import com.sdp.erp.model.Attendance;
import com.sdp.erp.model.Course;
import com.sdp.erp.model.Faculty;
import com.sdp.erp.model.GradePoints;
import com.sdp.erp.model.Student;

public interface FacultyService {
	   Faculty login(String username, String password);
	   List<Student> getAllStudents();
	Faculty addFaculty(Faculty faculty);
	List<Faculty> getAllFaculties();
	boolean updateFaculty(Long id, Faculty updatedFaculty);
	Optional<Faculty> getFacultyById(Long id);
	boolean deleteFaculty(Long id);
	List<Course> getCoursesByFacultyId(Long facultyId);
	List<Student> getStudentsByCourseId(Long courseId);
	List<Attendance> getAttendanceByCourseAndDate(Long courseId, String date);
	void saveAttendance(List<Attendance> attendanceList);

	}
