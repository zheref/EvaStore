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
        model
            .userWantsToConfirmBookCreation(
                title: titleTextField.stringValue,
                authorName: authorTextField.stringValue,
                coverURLString: coverImageURLTextField.stringValue
            )
    }
    
}

extension NewBookFormController: WindowCloser {
    
    func close() {
        view.window?.close()
    }
    
}
