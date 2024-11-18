//
//  ViewController.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/18/24.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
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
        booksTableView.dataSource = self
        booksTableView.delegate = self
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    // Implementacion de DataSource
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return books.count
    }
    
    enum BookColumn {
        static let title: NSUserInterfaceItemIdentifier = .init("title")
        static let author = NSUserInterfaceItemIdentifier("author")
//        case publicationDate
//        case genre
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let book = books[row]
        
        if tableColumn == tableView.tableColumns[0] {
            let titleCell = tableView.makeView(
                withIdentifier: BookColumn.title,
                owner: nil
            ) as! NSTableCellView
            titleCell.textField?.stringValue = book.title
            return titleCell
        } else if tableColumn == tableView.tableColumns[1] {
            let authorCell = tableView.makeView(
                withIdentifier: BookColumn.author,
                owner: nil
            ) as! NSTableCellView
            authorCell.textField?.stringValue = book.author.name
            return authorCell
        } else {
            return nil
        }
    }

}

