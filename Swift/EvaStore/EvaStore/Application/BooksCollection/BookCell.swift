//
//  BookCell.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/25/24.
//

import Cocoa

extension NSView {
    
    var backgroundColor: NSColor? {
        get {
            guard let color = layer?.backgroundColor else { return nil }
            return NSColor(cgColor: color)
        }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }
    
    func getRoundedCorners() {
        wantsLayer = true
        layer?.masksToBounds = true
        layer?.cornerRadius = 10
    }
    
}

class EvaImageView: NSImageView {
    
    override var image: NSImage? {
        get {
            return layer?.contents as? NSImage
        }
        set {
            layer = .init()
            layer?.contentsGravity = .resizeAspectFill
            layer?.contents = newValue
            wantsLayer = true
        }
    }
    
}

class BookCell: NSCollectionViewItem {
    
    // MARK: - Stored Properties
    
    // MARK: Props
    
    /// El libro a presentar por esta celda
    var book: Book?
    
    // MARK: Outlets
    
    @IBOutlet weak var coverImageView: EvaImageView!
    
    @IBOutlet weak var titleLabel: NSTextField!
    
    @IBOutlet weak var authorLabel: NSTextField!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                view.backgroundColor = .systemBlue
                titleLabel.textColor = .white
                authorLabel.textColor = .white
            } else {
                view.backgroundColor = .clear
                titleLabel.textColor = .textColor
                authorLabel.textColor = .textColor
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.identifier = NSUserInterfaceItemIdentifier(rawValue: "bookCell")
        view.getRoundedCorners()
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
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self else { return }
            
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
