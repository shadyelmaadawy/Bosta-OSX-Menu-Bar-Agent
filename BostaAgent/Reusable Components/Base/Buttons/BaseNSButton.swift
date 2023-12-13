//
//  BaseNSButton.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 28/11/2023.
//

import AppKit

class BaseNSButton: NSButton {
    
    // MARK: - Properties
    
    var padding: CGFloat {
        return 14.00
    }
    
    override var intrinsicContentSize: NSSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += padding
        contentSize.height += padding
        return contentSize
    }

    // MARK: - Initialization
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Configure

extension BaseNSButton {
    
    @objc func configure() {
        
        self.disableAutoResizingMask()

    }
}

// MARK: - Operations

extension BaseNSButton {
    
    func setTitle(_ title: String) {
        self.title = title
    }
    /// Generic function to set image symbol to button
    func setImage(_ systemImageSymbol: NSImage.BaseSystemImageSymbols, withColor tintColor: NSColor = .labelColor, size: CGFloat = 16.00) {
        self.image = .createSystemImage(systemImageSymbol, withColor: tintColor, size: size)
    }

}
