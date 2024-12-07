package com.sdp.erp.repository;

import com.sdp.erp.model.Admin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface AdminRepository extends JpaRepository<Admin, String> {

	public Admin findByUsernameAndPassword(String username, String password);
}
