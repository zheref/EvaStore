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
        collectionUpdaterDelegate?.reloadCollection()
    }
    
    mutating func userWantsToAddPlaceholder() {
        let placeholderBook = Book.narnia
        books.append(placeholderBook)
        
        collectionUpdaterDelegate?.reloadCollection()
    }
    
    /// 1. Ordena a la UI a abrir una nueva ventana para crear un nuevo libro.
    func userWantsToCreateNewBook() {
        windowOpenerDelegate?.openNewBookWindow()
    }
    
    func userWantsToEditBook(position: Int) {
        let book = books[position]
        windowOpenerDelegate?.openEditBookWindow(book: book)
    }
    
    // MARK: - System Events
    
    func viewIsReadyForData() {
        // TODO: Load data
        // 1. Local: DB, File, UserDefaults, Device (Camera, GPS, Galeria...)
        // 2. Remote: API (SOAP, REST, GraphQL), SDK (Firebase, ...)
    }
    
    /// 1. Agrega el libro pasado como parametro a la coleccion de libros en memoria.
    /// 2. Ordena al delegado de UI a recargarse para reflejar los cambios.
    /// - Parameters:
    ///     - book: El libro ya creado a ser agregado y mostrado en la UI.
    mutating func newBookWasCreated(book: Book) {
        books.append(book)
        collectionUpdaterDelegate?.reloadCollection()
    }
    
    mutating func bookWasEdited(book: Book) {
        let index = books.firstIndex(where: {
            $0.id == book.id
        })
        
        // Precondicionales
        guard let index else {
            // TODO: Display error on UI
            return
        }
        
        books[index] = book
        collectionUpdaterDelegate?.reloadCollection()
    }
    
    //
    mutating func bookWasEdited2(book: Book) {
        let index = books.firstIndex(where: {
            $0.id == book.id
        })
        
        if let index {
            books[index] = book
            collectionUpdaterDelegate?.reloadCollection()
        }
        
        // TODO: Display error on UI
        // No es necesario retornar
    }
    
}
