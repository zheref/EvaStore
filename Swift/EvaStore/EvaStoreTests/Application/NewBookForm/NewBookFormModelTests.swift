//
//  NewBookFormModelTests.swift
//  EvaStoreTests
//
//  Created by Sergio Daniel on 12/10/24.
//

import XCTest
@testable import EvaStore

class MockedWindowCloser: WindowCloser {
    var didCloseCalledSpy: Bool = false
    
    func close() {
        didCloseCalledSpy = true
    }
}

final class NewBookFormModelTests: XCTestCase {

    // Spies with delegation
    func testUserWantsToCancelBookCreation() {
        // Mock: Creado convenientemente exclusivamente para esta prueba
        
        // Given (Dado)
        // Sujeto (Real, proveniente de la aplicacion misma)
        var newBookFormModel = NewBookFormModel()
        // Mocks (mockeamos tantas dependencias del sujeto como necesitemos)
        let mockWindowCloserDelegate = MockedWindowCloser()
        newBookFormModel.windowCloserDelegate = mockWindowCloserDelegate
        
        // When
        newBookFormModel.userWantsToCancelBookCreation()
        
        // Then (expectativas)
        XCTAssertTrue(mockWindowCloserDelegate.didCloseCalledSpy)
    }
    
    // Caso 1: Creacion
    func testUserWantsToConfirmBook_Creation() {
        // Dado (preparamos) -----------------------------------------
        
        // Sujeto (lo que estamos auditando)
        
        var sut = NewBookFormModel()
        
        // Mocks (conveniencia)
        
        let title = "Harry Potter: The Prisoner of Azkaban"
        let authorName = "J.K. Rowling"
        let coverURLString = "https://res.cloudinary.com/bloomsbury-atlas/image/upload/w_360,c_scale,dpr_1.5/jackets/9781408855676.jpg"
        
        var newBookToAdd: Book? = nil
        sut.onAddBook = { newBook in
            newBookToAdd = newBook
        }
        let windowCloserDelegate = MockedWindowCloser()
        sut.windowCloserDelegate = windowCloserDelegate
        
        // Cuando -----------------------------------------
        sut.userWantsToConfirmBook(
            title: title,
            authorName: authorName,
            coverURLString: coverURLString
        )
        
        // Entonces -----------------------------------------
        
        // 1. Reportamos que queremos agregar un nuevo libro ya creado
        XCTAssertNotNil(newBookToAdd)
        XCTAssertEqual(newBookToAdd?.title, title)
        XCTAssertEqual(newBookToAdd?.author.name, authorName)
        XCTAssertEqual(
            newBookToAdd?.coverPicture?.absoluteString,
            coverURLString
        )
        // 2. Emitimos orden para cerrar la ventana de creacion.
        XCTAssertTrue(windowCloserDelegate.didCloseCalledSpy)
        
    }

}
