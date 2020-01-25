package com.kuvar.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import model.User;

public interface UserRepository extends JpaRepository<User, Integer>{

	User findByUsername(String username);
	
	@Query("select u from User u where u.idUser <> :idU and (u not in (select if.user1 from IsFriend if where if.user2.idUser=:idU) or u not in (select if.user2 from IsFriend if where if.user1.idUser =: idU))")
	List<User> findAllNotFriends(@Param("idU")int idUser);
	

}
