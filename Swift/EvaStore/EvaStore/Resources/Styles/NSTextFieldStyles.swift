//
//  NSTextFieldStyles.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/29/24.
//

import AppKit

extension NSTextField {
    
    // Estilo Original
    func switchToOriginalStyle() {
        textColor = .textColor
        setOutlineColor(NSColor.separatorColor, borderWidth: 1)
        placeholderString = ""
    }
    
    // Primer Estilo: Estilo de Informacion Faltante
    func swithToMissingInfoStyle(_ text: String?) {
        textColor = .red
        setOutlineColor(.red, borderWidth: 2)
        placeholderString = text ?? "Error"
    }
    
}
