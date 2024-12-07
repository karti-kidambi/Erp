package com.sdp.erp.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.sdp.erp.model.Attendance;

@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, Long> {
   List<Attendance> findByStudentId(Long studentId); 
   List<Attendance> findByCourseIdAndDate(Long courseId, String date);
}
