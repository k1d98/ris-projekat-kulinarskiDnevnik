package com.kuvar.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Ingredient;

public interface IngredientRepository extends JpaRepository<Ingredient, Integer>{

	Ingredient findByName(String search);
	
}
