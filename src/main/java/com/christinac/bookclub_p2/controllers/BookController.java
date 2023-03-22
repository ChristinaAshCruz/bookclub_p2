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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.christinac.bookclub_p2.models.Book;
import com.christinac.bookclub_p2.models.User;
import com.christinac.bookclub_p2.services.BookService;
import com.christinac.bookclub_p2.services.UserService;

@Controller
@RequestMapping("/book")
public class BookController {
	
	@Autowired
	private BookService bookServ;
	@Autowired
	private UserService userServ;
	
	@GetMapping("/new")
	public String newBook(@ModelAttribute("book") Book newBook) {
		return "createBook.jsp";
	}
	
	@PostMapping("/new")
	public String createBook(@Valid @ModelAttribute("book") Book newBook, BindingResult result, HttpSession session) {
		if (result.hasErrors()) {
			return "createBook.jsp";
		}
		Long userId = (Long) session.getAttribute("userId");
		User user = userServ.findById(userId);
		List<Book> userBooks = user.getUserThoughts();
		userBooks.add(newBook);
		newBook.setSubmittedBy(user);
		bookServ.createBook(newBook);
		return "redirect:/dashboard";
	}
	
	@GetMapping("/{bookId}/edit")
	public String editBook(@PathVariable("bookId") Long bookId, Model model) {
		Book book = bookServ.findById(bookId);
		model.addAttribute("book", book);
		return "editBook.jsp";
	}
	
	@PutMapping("/{bookId}/edit")
	public String updateBook(@Valid @ModelAttribute("book") Book book, BindingResult result, Model model, @PathVariable("bookId") Long bookId) {
		if(result.hasErrors()) {
			return "editBook.jsp";
		}
		bookServ.updateBook(book);
		return "redirect:/dashboard";
	}
	
	@GetMapping("/{bookId}/view")
	public String viewBook(@PathVariable("bookId") Long bookId, Model model) {
		Book book = bookServ.findById(bookId);
		model.addAttribute("book", book);
		return "viewBook.jsp";
	}
	
	@GetMapping("/{bookId}/delete")
	public String deleteBook(@PathVariable("bookId") Long bookId) {
		bookServ.deleteBookById(bookId);
		return "redirect:/dashboard";
	}
	
}
