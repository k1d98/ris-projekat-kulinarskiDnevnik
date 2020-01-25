package com.kuvar.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Contain;

public interface ContainsRepository extends JpaRepository<Contain, Integer>{
	
}
