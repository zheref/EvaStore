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
    
    // MARK: - Outlets
    
    @IBOutlet weak var cancelButton: NSButton!
    
    // Campos
    @IBOutlet weak var titleTextField: NSTextField!
    
    @IBOutlet weak var authorTextField: NSTextField!
    
    @IBOutlet weak var coverImageURLTextField: NSTextField!

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
    }
    
    
    
}
