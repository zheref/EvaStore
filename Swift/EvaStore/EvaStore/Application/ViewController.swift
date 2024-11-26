//
//  ViewController.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/18/24.
//

import AppKit

// mac
// Cocoa (Obj-C)
// iPhone
// Cocoa Touch (Obj-C)
// Evolution ------
// AppKit (Moderno para macOS con Obj-C) -> Swift
// UIKit (Moderno para iOS con Obj-C) -> Swift
// SwiftUI (macOS y iOS)

class ViewController: NSViewController {
    
    var books: [Book] = [
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
    
    // MARK: Outlets
    
    @IBOutlet weak var booksCollectionView: NSCollectionView!
    
    // Single Responsibility Principle
    // Action handling
    @IBAction func userDidClickDeleteButton(_ sender: NSButton) {
        //deleteBook(position: booksTableView.selectedRow)
        
        print("Delete a book from table \(Book.bookTableId)")
    }
    
    // Operational
    func deleteBook(position: Int) {
        books.remove(at: position)
        //booksTableView?.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        booksCollectionView.register(BookCell.self,
                                     forItemWithIdentifier: .init("bookCell"))
        booksCollectionView.dataSource = self
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

extension ViewController: NSCollectionViewDataSource {
    
    // Implementamos metodo que establece la cantidad de secciones a tener la coleccion
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    // Implementamos metodo que establezca cantidad de items por seccion
    func collectionView(_ collectionView: NSCollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    // Implementamos metodo que construye cada celda a presentar
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        // 1. Construimos o reciclamos item
        let item = collectionView.makeItem(
            withIdentifier: .init(rawValue: "bookCell"),
            for: indexPath
        )
        
        // 2. Intentamos castear
        guard let bookCell = item as? BookCell else {
            return item
        }
        
        // 2.5 Buscamos libro a configurar
        let book = books[indexPath.item]
        
        // 3. Configurar
        bookCell.setBook(book)
        
        return bookCell
    }
    
}
