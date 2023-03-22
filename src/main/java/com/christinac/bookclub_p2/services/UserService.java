package com.christinac.bookclub_p2.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.christinac.bookclub_p2.models.LoginUser;
import com.christinac.bookclub_p2.models.User;
import com.christinac.bookclub_p2.repositories.UserRepository;

@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepo;
	
	// find all
	public List<User> findAll(){
		return userRepo.findAll();
	}
	// find by Id
	public User findById(Long id) {
		Optional<User> optionalUser = userRepo.findById(id);
		if(optionalUser.isPresent()) {			
			return optionalUser.get();
		} else {
			return null;
		}
	}
	// register 
	public User register(User u, BindingResult result) {
		Optional<User> optionalUser = userRepo.findByEmail(u.getEmail());
		if(optionalUser.isPresent()) {
			result.rejectValue("email", null, "Your email is already taken!");
		}
		if(!u.getConfirmPass().equals(u.getPassword())) {
			result.rejectValue("confirmPass", null, "Passwords do not match!");
		}
		if (result.hasErrors()) {
			return null;
		}
		String hashPW = BCrypt.hashpw(u.getPassword(), BCrypt.gensalt());
		u.setPassword(hashPW);
		return userRepo.save(u);
	}
	
	
	//login
	public User login(LoginUser l, BindingResult result) {
		Optional<User> optionalUser = userRepo.findByEmail(l.getEmail());
		if (optionalUser.isEmpty() || !BCrypt.checkpw(l.getPassword(), optionalUser.get().getPassword())){
			result.rejectValue("password", null, "Incorrect email or password!");
			return null;
		} else {
			return optionalUser.get();
		}
		
	}
	
	// update
	public User update(User u) {
		return userRepo.save(u);
	}
	
	// delete
	public void delete(User u) {
		userRepo.delete(u);
	}
	
	
}