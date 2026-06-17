package com.sdp.erp.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.sdp.erp.model.GradePoints;

@Repository
public interface GradePointsRepository extends JpaRepository<GradePoints, Long> {
    List<GradePoints> findByStudentId(Long studentId);
    Optional<GradePoints> findByStudentIdAndCourseId(Long studentId, Long courseId);
}
