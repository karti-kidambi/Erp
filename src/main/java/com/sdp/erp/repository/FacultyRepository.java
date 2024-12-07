package com.sdp.erp.repository;

import com.sdp.erp.model.Faculty;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;


@Repository
public interface FacultyRepository extends JpaRepository<Faculty, Long> {
	public Faculty findByEmailAndPassword(String email, String password);
}
