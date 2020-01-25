package com.kuvar.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Picture;

public interface PictureRepository extends JpaRepository<Picture, Integer>{

}
