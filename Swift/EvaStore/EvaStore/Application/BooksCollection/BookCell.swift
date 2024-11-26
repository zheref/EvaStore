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
        if let coverUrl = book.coverPicture {
            fetchCoverImage(coverUrl)
        }
    }
    
    /// Descarga una imagen de una URL dada y la configura en el
    /// imageView de la celda
    /// - Parameters:
    ///  - url: La URL de la imagen a ser descargada y presentada
    func fetchCoverImage(_ url: URL) {
        print("Intentando descargar portada de libro \(book?.title ?? "Sin titulo") con URL: \(url.absoluteString)")
        setBookCover(image: nil)
        
        let task = URLSession.shared.dataTask(with: url) { [unowned self] data, _, error in
            // Truquito para desenvolver (unwrap) con el mismo nombre
            if let error {
                // Hubo error
                self.setBookCover(image: nil)
                print(error.localizedDescription)
            }
            
            // No hubo error
            if let data {
                if let image = NSImage(data: data) {
                    // Si habia una imagen
                    print(
                        "Descargamos satisfactoriamente portada de libro \(self.book?.title)"
                    )
                    self.setBookCover(image: image)
                } else {
                    // No es una imagen
                    self.setBookCover(image: nil)
                }
            } else {
                // No hay datos (0 bytes)
                self.setBookCover(image: nil)
            }
        }
        
        task.resume()
    }
    
    private func setBookCover(image: NSImage?) {
        DispatchQueue.main.async {
            self.coverImageView.image = image
        }
    }
    
}
