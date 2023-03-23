package com.christinac.bookclub_p2.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.christinac.bookclub_p2.models.Book;
import com.christinac.bookclub_p2.models.LoginUser;
import com.christinac.bookclub_p2.models.User;
import com.christinac.bookclub_p2.services.BookService;
import com.christinac.bookclub_p2.services.UserService;

@Controller
public class HomeController {
	
	@Autowired
	private UserService userServ;
	@Autowired
	private BookService bookServ;
	
	
	@GetMapping("/")
	public String index(Model model, HttpSession session) {
		session.setAttribute("userId", null);
		model.addAttribute("newUser", new User());
		model.addAttribute("loginUser", new LoginUser());
		return "index.jsp";
	}
	
	// register
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model, HttpSession session) {
		User user = userServ.register(newUser, result);
		if(user == null) {
			model.addAttribute("loginUser", new LoginUser());
			return "index.jsp";
		} else { 
			session.setAttribute("userId", user.getId());
			return "redirect:/dashboard";
		}
	}
	
	
	//login
	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("loginUser") LoginUser loginUser, BindingResult result, Model model, HttpSession session) {
		User user = userServ.login(loginUser, result);
		if(user == null) {
			model.addAttribute("newUser", new User());
			return "index.jsp";
		} else {
			session.setAttribute("userId", user.getId());
			return "redirect:/dashboard";
		}
	}
	
	@GetMapping("/dashboard")
	public String dashboard(Model model, HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		} else {
			Long userId = (Long) session.getAttribute("userId");
			User user = userServ.findById(userId);
			model.addAttribute("user", user);
			List<Book> allBooks = bookServ.findAll();
			model.addAttribute("allBooks", allBooks);
			return "dashboard.jsp";
		}
	}
	
	
	@GetMapping("/bookmarket")
	public String bookmarket(Model model, HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/";
		} else {
			Long userId = (Long) session.getAttribute("userId");
			User user = userServ.findById(userId);
			model.addAttribute("user", user);
			List<Book> allBooks = bookServ.findAll();
			model.addAttribute("allBooks", allBooks);
			return "bookMarket.jsp";
		}
	}
	
	@GetMapping("/logout")
	public String bookmarket() {
		return "redirect:/";
	}
}
