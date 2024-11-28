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
    
    func userWantsToCreateNewBook() {
        windowOpener?.openNewBookWindow()
    }
    
    // MARK: - System Events
    
    func viewIsReadyForData() {
        // TODO: Load data
        // 1. Local: DB, File, UserDefaults, Device (Camera, GPS, Galeria...)
        // 2. Remote: API (SOAP, REST, GraphQL), SDK (Firebase, ...)
    }
    
    mutating func newBookWasCreated(book: Book) {
        books.append(book)
        collectionUpdater?.reloadCollection()
    }
    
}
