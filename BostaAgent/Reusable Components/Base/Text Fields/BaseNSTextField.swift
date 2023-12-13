//
//  BaseNSTextField.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 28/11/2023.
//

import AppKit

class BaseNSTextField: NSTextField {
    
    // MARK: - Initialization
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layout() {
        super.layout()
        
        self.setRadius(8.00)
    }
}

// MARK: - Configure

extension BaseNSTextField {
    
    @objc func configure() {
                
        self.disableAutoResizingMask()
        
        self.isBordered = false
        self.isBezeled = false
        
        self.drawsBackground = false
        self.focusRingType = .none
        
        self.alignment = .center
        self.font = .getFont(.regular, textStyle: .callout)
    }
    
}

// MARK: - Operations

extension BaseNSTextField {
    
    ///  A Generic function to set place holder of text field.
    func setPlaceHolder(_ placeHolder: String) {
        self.placeholderString = placeHolder
    }

}
