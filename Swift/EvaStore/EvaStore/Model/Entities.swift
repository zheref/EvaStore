//
//  Entities.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/18/24.
//

import Foundation

/// Representa una de las opciones de genero literario disponible
/// para libros en la base de datos.
enum Genre: String {
    case fiction
    case romance
    case selfHelp
    case history
    case fantasy
    case thriller
    case unknown
}

/// Representa los datos mas basicos del autor de uno o mas libros.
struct Author {
    let name: String
    let nationality: String?
    let birthDate: Date?
    let genres: [Genre]
}

/// Representa un libro de la base de datos con su informacion
/// mas esencial.
struct Book {
    static let bookTableId = "bookTable"
    
    let title: String
    let coverPicture: URL?
    let author: Author
    let publicationDate: Date
    let genre: Genre
    
    func daysSincePublication() -> Int {
        let now = Date()
        return Int(now.timeIntervalSince(self.publicationDate) / 86400)
    }
    
    static func calculateDaysSincePublication(from book: Book) -> Int {
        let now = Date()
        return Int(now.timeIntervalSince(book.publicationDate) / 86400)
    }
}

extension Book {
    
    static let narnia: Book = Book(
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
    
}
