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
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.title = "New Book"
        
        cancelButton.contentTintColor = .red
        
        // TODO: Research how to change button title color
        cancelButton.change(color: .red)
        
        model.windowCloser = self
    }
    
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