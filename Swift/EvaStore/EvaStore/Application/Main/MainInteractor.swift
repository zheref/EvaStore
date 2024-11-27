//
//  MainInteractor.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/26/24.
//

extension MainModel {
    
    // MARK: - User Actions
    
    mutating func userWantsToDeleteBook(position: Int) {
        // Elimina el libro
        books.remove(at: position)
        // Manda a actualizar la UI
        collectionUpdater?.reloadCollection()
    }
    
    // MARK: - System Events
    
}
