//
//  PrimaryNSButton.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 28/11/2023.
//

import AppKit

final class PrimaryNSButton: BaseNSButton {
  
    // MARK: - Initialization
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - User Interface Events

extension PrimaryNSButton {
    
    override func layout() {
        super.layout()
        
        self.setRadius(4.00)
        self.setShadow(self.currentBackgroundColor)
    }
    
}

// MARK: - Configure

extension PrimaryNSButton {
    
    override func configure() {
        super.configure()
        
        self.isBordered = false
        self.setBackgroundColor(.controlAccentColor)
    }
    
}
