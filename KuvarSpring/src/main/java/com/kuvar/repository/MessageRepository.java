package com.kuvar.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import model.Message;
import model.User;

public interface MessageRepository extends JpaRepository<Message, Integer>{
	@Query("select m from Message m where (m.user2.idUser =:u1 and m.user1.idUser =:u2) or (m.user1.idUser =:u1 and m.user2.idUser =:u2)")
	List<Message> getAllMessagesForUsers(@Param("u1")int user1, @Param("u2") int user2);
}
