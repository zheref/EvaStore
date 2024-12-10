//
//  NewBookFormModelTests.swift
//  EvaStoreTests
//
//  Created by Sergio Daniel on 12/10/24.
//

import XCTest
@testable import EvaStore

class FakeWindowCloser: WindowCloser {
    var didCloseCalledSpy: Bool = false
    
    func close() {
        didCloseCalledSpy = true
    }
}

final class NewBookFormModelTests: XCTestCase {

    // Spies with delegation
    func testUserWantsToCancelBookCreation() {
        // Given
        var newBookFormModel = NewBookFormModel()
        let fakeWindowCloser = FakeWindowCloser()
        newBookFormModel.windowCloserDelegate = fakeWindowCloser
        
        // When
        newBookFormModel.userWantsToCancelBookCreation()
        
        // Then
        XCTAssertTrue(fakeWindowCloser.didCloseCalledSpy)
    }

}
