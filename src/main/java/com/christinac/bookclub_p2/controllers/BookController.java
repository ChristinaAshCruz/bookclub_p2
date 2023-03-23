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
		List<Book> userBooks = user.getBooksOwned();
		userBooks.add(newBook);
		newBook.setOwnedBy(user);
		newBook.setBookBorrower(null);
		bookServ.createBook(newBook);
		return "redirect:/dashboard";
	}
	
	//edit entry
		@GetMapping("/{id}/edit")
		public String editBook(@PathVariable("id") Long id, Model model) {
			model.addAttribute("book", bookServ.findById(id));
			Book bookDetails = bookServ.findById(id);
			model.addAttribute("bookDetails", bookDetails);
			Long bookBorrowerId = bookDetails.getId();
			return "editBook.jsp";
		}
		
		@PutMapping("/{id}/edit")
		public String updateBook(@Valid @ModelAttribute("book") Book book, BindingResult result, @PathVariable("id") Long id, HttpSession session, Model model) {
			if (result.hasErrors()) {
				Book bookDetails = bookServ.findById(id);
				model.addAttribute("bookDetails", bookDetails);
				Long bookBorrowerId = bookDetails.getId();
				return "editBook.jsp";
			} else {
				// keep owner the same
				Long userId = (Long) session.getAttribute("userId");
				User user = userServ.findById(userId);
				book.setOwnedBy(user);
				// keep borrower the same
				Book bookDetails = bookServ.findById(id);
				User bookBorrower = bookDetails.getBookBorrower();
				book.setBookBorrower(bookBorrower);
				// update book
				bookServ.updateBook(book);
				return "redirect:/book";
			}
		}
		
		
	@GetMapping("/{bookId}/view")
	public String viewBook(@PathVariable("bookId") Long bookId, Model model) {
		Book book = bookServ.findById(bookId);
		model.addAttribute("book", book);
		return "viewBook.jsp";
	}
	
	@GetMapping("/{id}/borrow")
	public String borrowBook(@PathVariable("id") Long id, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		bookServ.borrowBook(id, userId);
		return "redirect:/dashboard";
	}
		
	@GetMapping("/{id}/return")
	public String returnBook(@PathVariable("id") Long id, HttpSession session) {
		bookServ.returnBook(id);
		return "redirect:/dashboard";
	}
	
	
	@GetMapping("/{bookId}/delete")
	public String deleteBook(@PathVariable("bookId") Long bookId) {
		bookServ.deleteBookById(bookId);
		return "redirect:/dashboard";
	}

	
}
