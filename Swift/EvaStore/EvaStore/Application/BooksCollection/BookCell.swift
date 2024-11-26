//
//  BookCell.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/25/24.
//

import Cocoa

class BookCell: NSCollectionViewItem {
    
    // MARK: - Stored Properties
    
    // MARK: Props
    
    /// El libro a presentar por esta celda
    var book: Book?
    
    // MARK: Outlets
    
    @IBOutlet weak var coverImageView: NSImageView!
    
    @IBOutlet weak var titleLabel: NSTextField!
    
    @IBOutlet weak var authorLabel: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.identifier = NSUserInterfaceItemIdentifier(rawValue: "bookCell")
    }
    
    /// Actualiza los datos presentados en la celda
    /// basado en la informacion del libro pasado como
    /// argumento.
    /// - Parameters:
    ///  - book: El libro a configurar y ser presentado en la celda
    func setBook(_ book: Book) {
        self.book = book
        
        titleLabel.stringValue = book.title
        authorLabel.stringValue = book.author.name
        
        // TODO: Update Cover Image
    }
    
}
