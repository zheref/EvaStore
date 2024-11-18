//
//  ViewController.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/18/24.
//

import Cocoa

class ViewController: NSViewController {
    
    let books: [Book] = [
        .init(title: "The Alchemist",
              coverPicture: nil,
              author: .init(name: "Paulo Coelho",
                            nationality: "Brazilian",
                            birthDate: nil,
                            genres: [.fiction, .fantasy]),
              publicationDate: Date(),
              genre: .fiction),
        
        Book(title: "The Great Gatsby",
             coverPicture: nil,
             author: .init(name: "F. Scott Fitzgerald",
                           nationality: "American",
                           birthDate: nil,
                           genres: [.fiction, .fantasy]),
             publicationDate: Date(),
             genre: .fiction),
        
        .init(title: "The Da Vinci Code",
              coverPicture: nil,
              author: .init(name: "Dan Brown",
                            nationality: "American",
                            birthDate: nil,
                            genres: [.fiction, .thriller]),
              publicationDate: Date(),
              genre: .fiction),
    ]
    
    @IBOutlet weak var booksTableView: NSTableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

