//
//  BaseNSComboBox.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 03/12/2023.
//

import AppKit

final class BaseNSComboBox: NSComboBox {
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: NSRect.zero)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - Configure

extension BaseNSComboBox {
    
    private func configure() {
        
        self.disableAutoResizingMask()
        
        self.isSelectable = false
        
    }
    
}

// MARK: - Operations

extension BaseNSComboBox {
    
    override func addItems(withObjectValues objects: [Any]) {
        super.addItems(withObjectValues: objects)
        
        guard objects.isEmpty == false else {
            return
        }
        self.selectItem(at: 0)
    }
    
}
