//
//  TransparentNSButton.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 28/11/2023.
//

import AppKit

final class TransparentNSButton: BaseNSButton {
    
    // MARK: - Initialization
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure

extension TransparentNSButton {
    
    override func configure() {
        super.configure()
        
        self.isBordered = false
    }
    
}
