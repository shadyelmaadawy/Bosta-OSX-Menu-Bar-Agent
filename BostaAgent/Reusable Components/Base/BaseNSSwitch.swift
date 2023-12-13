//
//  BaseNSSwitch.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 04/12/2023.
//

import AppKit

final class BaseNSSwitch: NSSwitch {
        
    // MARK: - Initialization

    init(currentState: NSSwitch.StateValue) {
        super.init(frame: NSRect.zero)
        self.configure(currentState)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure

extension BaseNSSwitch {
    
    private func configure(_ currentState: NSSwitch.StateValue) {
        
        self.disableAutoResizingMask()
        
        self.state = currentState
        
    }
    
}


