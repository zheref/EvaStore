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

// Interfaces
protocol BookWindowOpener: AnyObject {
    
    func openNewBookWindow()
    
    func openEditBookWindow(book: Book)
}

// UI
class MainViewController: NSViewController {
    
    // MARK: - Stored Properties
    
    var lastSelectedIndexPath: IndexPath?
    
    var model = MainModel()
    
    // MARK: Outlets
    
    @IBOutlet weak var booksScrollView: NSScrollView!
    
    @IBOutlet weak var booksClipView: NSClipView!
    @IBOutlet weak var booksCollectionView: EvaCollectionView!
    
    // MARK: - Actions
    
    @IBAction func userDidClickAddPlaceholderButton(_ sender: Any) {
        model.userWantsToAddPlaceholder()
    }
    
    @IBAction func userDidClickAddNewButton(_ sender: NSButton) {
        model.userWantsToCreateNewBook()
    }
    
    // Operational

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        booksCollectionView.register(BookCell.self,
                                     forItemWithIdentifier: .init("bookCell"))
        booksCollectionView.dataSource = self
        booksCollectionView.evaDelegate = self
        booksCollectionView.isSelectable = true
        
        booksScrollView.scrollerInsets = .init(top: 50, left: 10, bottom: 10, right: 10)
        booksClipView.contentInsets = .init(top: 50, left: 10, bottom: 10, right: 10)
        // TODO: Research how to provide some padding (insets) for collection view content (items)
        
        model.collectionUpdaterDelegate = self
        model.windowOpenerDelegate = self
        
        model.viewIsReadyForData()
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

extension MainViewController: NSCollectionViewDataSource {
    
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

extension MainViewController: NSCollectionViewDelegate {
}

extension MainViewController: CollectionUpdater {
    
    func reloadCollection() {
        booksCollectionView.reloadData()
    }
    
}

extension MainViewController: BookWindowOpener {
    
    func openNewBookWindow() {
        // Creamos el modelo para la nueva pantalla
        let newBookModel = NewBookFormModel(onAddBook: { newBook in
            self.model.newBookWasCreated(book: newBook)
        })
        
        // Instaciamos la pantallita que ya creamos con el XIB
        let newBookViewController = NewBookFormController(
            model: newBookModel
        )
        // Instanciamos una ventana para nuestra pantallita
        let window = NSWindow(contentViewController: newBookViewController)
        // Instanciamos un controlador para nuestra ventanita
        let windowController = NSWindowController(window: window)
        // Presentamos nuestro controlador de ventanita
        windowController.showWindow(nil)
    }
    
    func openEditBookWindow(book: Book) {
        // Creamos el modelo para la nueva pantalla
        let newBookModel = NewBookFormModel(
            book: book,
            onEditBook: { editedBook in
                self.model.bookWasEdited(book: editedBook)
            }
        )
        
        // Instaciamos la pantallita que ya creamos con el XIB
        let newBookViewController = NewBookFormController(
            model: newBookModel
        )
        // Instanciamos una ventana para nuestra pantallita
        let window = NSWindow(contentViewController: newBookViewController)
        // Instanciamos un controlador para nuestra ventanita
        let windowController = NSWindowController(window: window)
        // Presentamos nuestro controlador de ventanita
        windowController.showWindow(nil)
    }
    
    func openQuickAndDirtyWindow() {
//        NSWindowController(window: .init(contentViewController: NewBookFormController())).showWindow(nil)
    }
    
}

extension MainViewController: EvaCollectionViewDelegate {
    
    func collectionView(_ collectionView:NSCollectionView, menu:NSMenu?, at indexPath: IndexPath?) -> NSMenu? {
        lastSelectedIndexPath = indexPath
        let menu = NSMenu()
        menu
            .addItem(
                withTitle: "Edit",
                action: #selector(userDidClickEditOnContextualMenu),
                keyEquivalent: "e"
            )
        
        menu
            .addItem(
                withTitle: "Delete",
                action: #selector(userDidClickDeleteOnContextualMenu),
                keyEquivalent: "d"
            )
        
        return menu
    }
    
    @objc private func userDidClickEditOnContextualMenu() {
        guard let lastSelectedIndexPath else { return }
        
        model.userWantsToEditBook(position: lastSelectedIndexPath.item)
    }
    
    @objc private func userDidClickDeleteOnContextualMenu() {
        guard let lastSelectedIndexPath else { return }
        
        model.userWantsToDeleteBook(position: lastSelectedIndexPath.item)
    }
    
}
