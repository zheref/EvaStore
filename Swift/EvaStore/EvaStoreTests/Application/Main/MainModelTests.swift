//
//  MainInteractorTests.swift
//  EvaStoreTests
//
//  Created by Sergio Daniel on 11/27/24.
//

import XCTest
@testable import EvaStore

class FakeWindowOpener: BookWindowOpener {
    var createWindowOpenedSpy = false
    var editWIndowOpenedSpy = false
    
    func openNewBookWindow() {
        createWindowOpenedSpy = true
    }
    
    func openEditBookWindow(book: EvaStore.Book) {
        createWindowOpenedSpy = true
    }
}

class FakeCollectionUpdater: CollectionUpdater {
    
    var collectionUpdatedSpy = false
    
    func reloadCollection() {
        collectionUpdatedSpy = true
    }
    
}

// A quien auditamos aqui?
// MainModel (el modelo)
final class MainModelTests: XCTestCase {
    
    // Let's test User Actions

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
    
    // Aprendimos acerca de los espias
    func testUserWantsToCreateNewBook() {
        // Dado (proveer condiciones ideales)
        var sujetoDePrueba = MainModel()
        
        // Lo preparamos para que pueda hacer su trabajo
        let windowOpenerDelegate = FakeWindowOpener()
        sujetoDePrueba.windowOpenerDelegate = windowOpenerDelegate
        XCTAssertFalse(windowOpenerDelegate.createWindowOpenedSpy)
        
        // Cuando
        sujetoDePrueba.userWantsToCreateNewBook()
        
        // Entonces
        XCTAssertTrue(windowOpenerDelegate.createWindowOpenedSpy)
    }
    
    // Let's test System Events
    
    func testNewBookWasCreated() {
        // Dado
        var sujetoDePrueba = MainModel()
        
        // Condiciones Ideales:
        let collectionUpdaterDelegate = FakeCollectionUpdater()
        sujetoDePrueba.collectionUpdaterDelegate = collectionUpdaterDelegate
        XCTAssertFalse(collectionUpdaterDelegate.collectionUpdatedSpy)
        let fakeBook = Book(
            title: "Fake Title",
            coverPicture: nil,
            author: .init(
                name: "Fake Author",
                nationality: "Fake Nationality",
                birthDate: Date(),
                genres: []
            ),
            publicationDate: Date(),
            genre: .fiction
        )
        
        // Cuando
        sujetoDePrueba.newBookWasCreated(book: fakeBook)
        
        // Entonces
        
        // Sin Equatable (Book no es Equatable)
        XCTAssertTrue(
            sujetoDePrueba.books
                .contains(where: { $0.title == fakeBook.title })
        )
        
        // Con Equatable (Book es Equatable)
        XCTAssertTrue(sujetoDePrueba.books.contains(fakeBook))
        XCTAssertTrue(collectionUpdaterDelegate.collectionUpdatedSpy)
    }

}
