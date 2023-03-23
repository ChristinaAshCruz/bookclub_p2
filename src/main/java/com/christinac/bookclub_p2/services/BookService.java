package com.christinac.bookclub_p2.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.christinac.bookclub_p2.models.Book;
import com.christinac.bookclub_p2.models.User;
import com.christinac.bookclub_p2.repositories.BookRepository;

@Service
public class BookService {

		@Autowired
		private BookRepository bookRepo;
		@Autowired
		private UserService userServ;
	
		public List<Book> findAll(){
			return bookRepo.findAll();
		}
		
		public Book findById(Long id) {
			Optional<Book> optionalBook = bookRepo.findById(id);
			if(optionalBook.isPresent()) {
				return optionalBook.get();
			}
			return null;
		}
		
		public Book createBook(Book b) {
			return bookRepo.save(b);
		}
		
		public Book updateBook(Book b) {
			return bookRepo.save(b);
		}
		
		public void deleteBookById(Long id) {
			bookRepo.deleteById(id);
		}
		
		public void borrowBook(Long id, Long userId) {
			Book book = findById(id);
			User user = userServ.findById(userId);
			List<Book> booksBorrowed = user.getBooksBorrowed();
			book.setBookBorrower(user);
			booksBorrowed.add(book);
			updateBook(book);
		}
		
		public void returnBook(Long id) {
			Book book = findById(id);
			book.setBookBorrower(null);
			updateBook(book);
		}
		
}
