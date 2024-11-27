//
//  MainInteractor.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/26/24.
//

import Foundation

extension MainModel {
    
    // MARK: - User Actions
    
    mutating func userWantsToDeleteBook(position: Int) {
        // Elimina el libro
        books.remove(at: position)
        // Manda a actualizar la UI
        collectionUpdater?.reloadCollection()
    }
    
    mutating func userWantsToAddPlaceholder() {
        let placeholderBook = Book.narnia
        books.append(placeholderBook)
        
        collectionUpdater?.reloadCollection()
    }
    
    // MARK: - System Events
    
}
