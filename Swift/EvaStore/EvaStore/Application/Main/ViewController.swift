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

protocol CollectionUpdater: AnyObject {
    
    func reloadCollection()
    
}

// UI
class ViewController: NSViewController {
    
    // MARK: - Stored Properties
    
    var model = MainModel()
    
    // MARK: Outlets
    
    @IBOutlet weak var booksCollectionView: NSCollectionView!
    
    // Single Responsibility Principle
    // Action handling
    @IBAction func userDidClickDeleteButton(_ sender: NSButton) {
        let selectedIndexes = booksCollectionView.selectionIndexes
        let singleSelectedIndex = selectedIndexes.first
        
        guard let singleSelectedIndex else { return }
        
        model.userWantsToDeleteBook(position: singleSelectedIndex)
        print("Delete a book from table \(Book.bookTableId)")
    }
    
    // Operational

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        booksCollectionView.register(BookCell.self,
                                     forItemWithIdentifier: .init("bookCell"))
        booksCollectionView.dataSource = self
        booksCollectionView.isSelectable = true
        
        model.collectionUpdater = self
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    // Implementacion de DataSource
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return model.books.count
    }
    
    enum BookColumn {
        static let title: NSUserInterfaceItemIdentifier = .init("title")
        static let author = NSUserInterfaceItemIdentifier("author")
//        case publicationDate
//        case genre
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
        return model.books.count
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
        let book = model.books[indexPath.item]
        
        // 3. Configurar
        bookCell.setBook(book)
        
        return bookCell
    }
    
}

extension ViewController: CollectionUpdater {
    
    func reloadCollection() {
        booksCollectionView.reloadData()
    }
    
}
