package com.christinac.bookclub_p2.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.christinac.bookclub_p2.models.User;

@Repository
public interface UserRepository extends CrudRepository<User, Long>{

	@Override
	public List<User> findAll();
	
	public Optional<User> findByEmail(String email);
}