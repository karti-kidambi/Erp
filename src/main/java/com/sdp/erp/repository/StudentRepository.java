package com.sdp.erp.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sdp.erp.model.Course;
import com.sdp.erp.model.Student;


public interface StudentRepository extends JpaRepository<Student, Long> {
	public Student findByEmailAndPassword(String email, String Password);
	public Student findByEmail(String email);
	
	@Query("SELECT s.courses FROM Student s where s.studentId=?1")
    List<Course> findAllCourses(long sid);
	
	    @Query("SELECT s FROM Student s LEFT JOIN FETCH s.courses WHERE s.id = :id")
	    Optional<Student> findByIdWithCourses(@Param("id") Long id);
}
