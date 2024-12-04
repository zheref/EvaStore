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
    
}
