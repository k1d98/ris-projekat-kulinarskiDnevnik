package com.kuvar.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Category;

public interface CategoryRepository extends JpaRepository<Category, Integer>{

	Category findByName(String name);
	
}
