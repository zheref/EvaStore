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
