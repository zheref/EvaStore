//
//  NewBookFormModel.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/28/24.
//

import Foundation

struct NewBookFormModel {
    
    // State
    
    var book: Book?
    
    // Delegate
    weak var windowCloserDelegate: WindowCloser?
    
    // Event
    var onAddBook: (Book) -> Void = { book in print(book) }
    var onEditBook: (Book) -> Void = { book in print(book) }
    
    // Interactor
    
    /// Ordena al responsable de las ventanas
    /// que se cierre la ventana actual al
    /// usuario querer cancelar la operacion de creacion/modificacion.
    func userWantsToCancelBookCreation() {
        windowCloserDelegate?.close()
    }
    
    func userWantsToConfirmBookCreation(
        title: String,
        authorName: String,
        coverURLString: String
    ) {
        if var book = book {
            let somethingChanged = book.title != title || book.author.name != authorName || book.coverPicture?.absoluteString != coverURLString
            
            if !somethingChanged {
                windowCloserDelegate?.close()
                return
            }
            
            book.title = title
            book.author.name = authorName
            book.coverPicture = URL(string: coverURLString)
            
            // We trigger the book update
            onEditBook(book)
            
            // Then:
            windowCloserDelegate?.close()
        } else {
            // We create the book
            let book = Book(
                title: title,
                coverPicture: URL(string: coverURLString),
                author: .init(
                    name: authorName,
                    nationality: nil,
                    birthDate: Date(),
                    genres: []
                ),
                publicationDate: Date(),
                genre: .unknown
            )
            
            // We add the book
            onAddBook(book)
            
            // Then:
            windowCloserDelegate?.close()
        }
    }
    
}
