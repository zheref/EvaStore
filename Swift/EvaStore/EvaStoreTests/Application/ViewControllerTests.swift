//
//  ViewControllerTests.swift
//  EvaStoreTests
//
//  Created by Sergio Daniel on 11/20/24.
//

import XCTest
@testable import EvaStore

final class ViewControllerTests: XCTestCase {
    
    func testDeleteBook() {
        // Dado:
        let vc = ViewController()
        let initialCount = vc.books.count
        
        // Cuando:
        vc.deleteBook(position: 0)
        
        // Entonces:
        XCTAssert(vc.books.count == initialCount - 1)
    }
    
}
