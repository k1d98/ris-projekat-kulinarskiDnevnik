package com.kuvar.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Recipe;

public interface ReceiptRepository extends JpaRepository<Recipe, Integer>{

	List<Recipe> getByDate(Date date);
	
}
