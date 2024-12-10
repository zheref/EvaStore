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
        let mockWindowCloser = MockedWindowCloser()
        newBookFormModel.windowCloserDelegate = mockWindowCloser
        
        // When
        newBookFormModel.userWantsToCancelBookCreation()
        
        // Then (expectativas)
        XCTAssertTrue(mockWindowCloser.didCloseCalledSpy)
    }
    
    func testUserWantsToConfirmBookCreation() {
        
    }

}
