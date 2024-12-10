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
    
    /// Dados, un titulo de libro, un nombre de autor y una URL de
    /// una imagen para la portada.
    /// Si, estamos editando un libro:
    /// 1. Reportamos que hemos editado un libro a quien corresponda
    /// 2. Emitimos orden para cerrar la ventana de edicion.
    /// De lo contrario (creacion de nuevo libro):
    /// 1. Reportamos que queremos agregar un nuevo libro ya creado
    /// 2. Emitimos orden para cerrar la ventana de creacion.
    /// - Parameters:
    ///     - title: El titulo del libro a crear o actualizado
    ///     - authorName: El nombre del autor del libro a crear o actualizado
    ///     - coverURLString: String con la URL de la imagen del libro a crear o actualizado.
    func userWantsToConfirmBook(
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
