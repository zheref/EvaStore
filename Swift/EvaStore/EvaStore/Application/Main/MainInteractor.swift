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
        let placeholderBook = Book(
            title: "Chronicles of Narnia",
            coverPicture: URL(string: "https://images.cdn3.buscalibre.com/fit-in/360x360/78/1a/781ac6423eee238c27e6c70a9b6a3a0c.jpg"),
            author: .init(
                name: "C.S. Lewis",
                nationality: "English",
                birthDate: Date(),
                genres: [.fantasy]
            ),
            publicationDate: Date(),
            genre: .fantasy
        )
        
        books.append(placeholderBook)
        
        collectionUpdater?.reloadCollection()
    }
    
    // MARK: - System Events
    
}
