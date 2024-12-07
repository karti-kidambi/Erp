package com.sdp.erp.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.sdp.erp.model.Course;

@Repository
public interface CourseRepository extends JpaRepository<Course, Long> {
	
	
}
