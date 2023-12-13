//
//  BaseNSLabel.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 28/11/2023.
//

import AppKit

final class BaseNSLabel: NSTextField {
    
    // MARK: - Enums

    enum ColorScheme {
        
        case accentColor
        case primary
        case secondary
        case tertiary
        
        var textColor: NSColor {
            switch(self) {
                case .accentColor:
                    return NSColor.controlAccentColor
                case .primary:
                    return NSColor.labelColor
                case .secondary:
                    return NSColor.secondaryLabelColor
            case .tertiary:
                    return NSColor.tertiaryLabelColor
            }
        }
    }
    
    // MARK: - Initialization

    init(_ colorScheme: ColorScheme) {
        super.init(frame: NSRect.zero)
        self.configure(colorScheme)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Configure

extension BaseNSLabel {
    
    /// Generic function to configure UI component
    private func configure(_ colorScheme: ColorScheme) {
        
        self.disableAutoResizingMask()
        
        self.drawsBackground = false
        self.isEditable = false
        self.isBezeled = false
        self.isSelectable = false
        self.isBordered = false
        
        self.textColor = colorScheme.textColor
    }
    
}

// MARK: - Operations

extension BaseNSLabel {
    
    /// Set Label Text
    func setText(_ textString: String) {
        self.stringValue = textString
        self.sizeToFit()
    }


}
