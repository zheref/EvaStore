//
//  NewBookFormController.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/27/24.
//

import Cocoa

extension NSButton {
    // TODO: How to do this?
    func change(color: NSColor) {
        // .color = color
    }
}

extension NSTextField {
    
    /// Setea el color del borde exterior del campo de texto
    /// - Parameters:
    ///     - color: El color a configurar
    func setOutlineColor(_ color: NSColor, borderWidth: CGFloat) {
        // self.backgroundColor = color
        self.layer?.borderColor = color.cgColor
        self.layer?.borderWidth = borderWidth
    }
    
}

class NewBookFormController: NSViewController {
    
    // MARK: - Stored Properties
    
    // MARK: Model
    
    var model: NewBookFormModel
    
    // MARK: - Outlets
    
    @IBOutlet weak var cancelButton: NSButton!
    
    // Label
    @IBOutlet weak var headingLabel: NSTextField!
    
    // Campos
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var authorTextField: NSTextField!
    @IBOutlet weak var coverImageURLTextField: NSTextField!
    
    // Initializer
    
    init(model: NewBookFormModel) {
        self.model = model
        super.init(nibName: "NewBookFormController",
                   bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        titleTextField.delegate = self
        authorTextField.delegate = self
        coverImageURLTextField.delegate = self
        
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.title = "New Book"
        
        cancelButton.contentTintColor = .red
        
        // TODO: Research how to change button title color
        cancelButton.change(color: .red)
        
        model.windowCloser = self
        
        if let book = model.book {
            apply(book: book)
        }
    }
    
    // MARK: IBActions
    
    @IBAction func userDidClickCancelButton(_ sender: NSButton) {
        model.userWantsToCancelBookCreation()
    }
    
    @IBAction func userDidClickDoneButton(_ sender: NSButton) {
        if let missingField = validateForm() {
            missingField.swithToMissingInfoStyle("Required text here")
            return
        }
        
        model
            .userWantsToConfirmBookCreation(
                title: titleTextField.stringValue,
                authorName: authorTextField.stringValue,
                coverURLString: coverImageURLTextField.stringValue
            )
    }
    
    private func apply(book: Book) {
        view.window?.title = "Edit Book: \(book.title)"
        headingLabel.stringValue = "Edit Book"
        titleTextField.stringValue = book.title
        authorTextField.stringValue = book.author.name
        coverImageURLTextField.stringValue
            = book.coverPicture?.absoluteString ?? ""
    }
    
    /// Encuentra el primer campo al cual le falte informacion en
    /// el formulario y lo retorna.
    /// - Returns: El primer campo encontrado sin texto o nil si todos tienen texto
    private func validateForm() -> NSTextField? {
        let fieldsToEvaluate: [NSTextField] = [
            titleTextField,
            authorTextField,
            coverImageURLTextField
        ]
        
        return fieldsToEvaluate.first(where: { $0.stringValue.isEmpty })
    }
    
}

extension NewBookFormController: WindowCloser {
    
    func close() {
        view.window?.close()
    }
    
}

extension NewBookFormController: NSTextFieldDelegate {
    
    func controlTextDidChange(_ notification: Notification) {
        let textField = notification.object as! NSTextField
        if textField.stringValue.isEmpty == false {
            textField.switchToOriginalStyle()
        }
    }
    
}
