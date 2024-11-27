//
//  MainInteractorTests.swift
//  EvaStoreTests
//
//  Created by Sergio Daniel on 11/27/24.
//

import XCTest
@testable import EvaStore

final class MainInteractorTests: XCTestCase {

    func testUserWantsToDeleteBook() {
        // Dado
        var model = MainModel()
        model.books = [
            .init(title: "The Alchemist",
                  coverPicture: URL(string: "https://clubmagichour.com/cdn/shop/products/the-alchemist-by-paulo-coelho-magic-hour-282883.png?v=1707767532&width=1024"),
                  author: .init(name: "Paulo Coelho",
                                nationality: "Brazilian",
                                birthDate: nil,
                                genres: [.fiction, .fantasy]),
                  publicationDate: Date(),
                  genre: .fiction),
            
            Book(title: "The Great Gatsby",
                 coverPicture: URL(string: "https://m.media-amazon.com/images/I/81QuEGw8VPL._SY425_.jpg"),
                 author: .init(name: "F. Scott Fitzgerald",
                               nationality: "American",
                               birthDate: nil,
                               genres: [.fiction, .fantasy]),
                 publicationDate: Date(),
                 genre: .fiction),
            
            .init(title: "The Da Vinci Code",
                  coverPicture: URL(string: "https://m.media-amazon.com/images/I/41nJiN9TSDL._SY445_SX342_.jpg"),
                  author: .init(name: "Dan Brown",
                                nationality: "American",
                                birthDate: nil,
                                genres: [.fiction, .thriller]),
                  publicationDate: Date(),
                  genre: .fiction),
        ]
        let positionToDelete = 1
        let initialCount = model.books.count
        let bookToDelete = model.books[positionToDelete]
        
        // Cuando
        model.userWantsToDeleteBook(position: positionToDelete)
        
        // Entonces (expectativas)
        // 1. Esperamos que haya un elemento menos
        XCTAssertEqual(initialCount - 1, model.books.count)
        // 2. Esperamos que la lista ya no contenga el libro
        let containsBook = model.books.contains(where: {
            $0.title == bookToDelete.title
        })
        XCTAssertFalse(containsBook)
    }
    
    func testUserWantsToAddPlaceholder() {
        // Dado
        var model = MainModel()
        model.books = [
            .init(title: "The Alchemist",
                  coverPicture: URL(string: "https://clubmagichour.com/cdn/shop/products/the-alchemist-by-paulo-coelho-magic-hour-282883.png?v=1707767532&width=1024"),
                  author: .init(name: "Paulo Coelho",
                                nationality: "Brazilian",
                                birthDate: nil,
                                genres: [.fiction, .fantasy]),
                  publicationDate: Date(),
                  genre: .fiction),
            
            Book(title: "The Great Gatsby",
                 coverPicture: URL(string: "https://m.media-amazon.com/images/I/81QuEGw8VPL._SY425_.jpg"),
                 author: .init(name: "F. Scott Fitzgerald",
                               nationality: "American",
                               birthDate: nil,
                               genres: [.fiction, .fantasy]),
                 publicationDate: Date(),
                 genre: .fiction),
            
            .init(title: "The Da Vinci Code",
                  coverPicture: URL(string: "https://m.media-amazon.com/images/I/41nJiN9TSDL._SY445_SX342_.jpg"),
                  author: .init(name: "Dan Brown",
                                nationality: "American",
                                birthDate: nil,
                                genres: [.fiction, .thriller]),
                  publicationDate: Date(),
                  genre: .fiction),
        ]
        let initialCount = model.books.count
        let expectedNewBook = Book.narnia
        
        // Cuando
        model.userWantsToAddPlaceholder()
        
        // Entonces
        // esperamos que exista book.narnia dentro de model.books
        
        let containsPlaceholderBook = model.books.contains(where: {
            
            $0.title == expectedNewBook.title
            
        })
        
        XCTAssertTrue(containsPlaceholderBook)
        
        // esperamos que exista 1 elemento adicional
        
        XCTAssertEqual(model.books.count, initialCount + 1)
        
        
    }

}
