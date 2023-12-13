//
//  BaseNSView.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 28/11/2023.
//

import AppKit

class BaseNSView: NSView {
    
    // MARK: - Properties
        
    var userInteractionEnabled: Bool = true
    
    // MARK: - View Life Cycle
    
    override func hitTest(_ point: NSPoint) -> NSView? {
        return userInteractionEnabled ? super.hitTest(point) : nil
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

extension BaseNSView {
    
    @objc func configure() {
        
        self.disableAutoResizingMask()
        
    }
    
}

