//
//  MainInteractor.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/26/24.
//

extension MainModel {
    
    mutating func userWantsToDeleteBook(position: Int) {
        books.remove(at: position)
    }
    
}
