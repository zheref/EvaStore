//
//  MainState.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/26/24.
//

import Foundation

struct MainModel {
    
    // Weak solo funciona con tipos referencia
    weak var collectionUpdater: CollectionUpdater?
    
    var books: [Book] = [
        .init(title: "The Alchemist",
              coverPicture: URL(string: "https://clubmagichour.com/cdn/shop/products/the-alchemist-by-paulo-coelho-magic-hour-282883.png?v=1707767532&width=1024"),
              author: .init(name: "Paulo Coelho",
                            nationality: "Brazilian",
                            birthDate: nil,
                            genres: [.fiction, .fantasy]),
              publicationDate: Date(),
              genre: .fiction),
        
        Book(title: "The Great Gatsby",
             coverPicture: URL(string: "https://m.media-amazon.com/images/I/81QuEGw8VPL._SY425_.jpg"),
             author: .init(name: "F. Scott Fitzgerald",
                           nationality: "American",
                           birthDate: nil,
                           genres: [.fiction, .fantasy]),
             publicationDate: Date(),
             genre: .fiction),
        
        .init(title: "The Da Vinci Code",
              coverPicture: URL(string: "https://m.media-amazon.com/images/I/41nJiN9TSDL._SY445_SX342_.jpg"),
              author: .init(name: "Dan Brown",
                            nationality: "American",
                            birthDate: nil,
                            genres: [.fiction, .thriller]),
              publicationDate: Date(),
              genre: .fiction),
    ]
    
}
