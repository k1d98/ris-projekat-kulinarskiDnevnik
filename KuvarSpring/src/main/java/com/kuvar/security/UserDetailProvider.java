package com.kuvar.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kuvar.repository.UserRepository;

import model.User;

@Service
public class UserDetailProvider implements UserDetailsService {
	@Autowired
	UserRepository ur;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User u = ur.findByUsername(username);
		if (u == null) throw new UsernameNotFoundException("doesn't exist");
		UserDetails ud = new UserDetailsImpl(u);
		return ud;
	}
}
