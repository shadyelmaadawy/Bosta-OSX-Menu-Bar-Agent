//
//  BaseNSProgressIndicator.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 07/12/2023.
//

import AppKit

final class BaseNSProgressIndicator: NSProgressIndicator {
    
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

extension BaseNSProgressIndicator {
    
    private func configure() {

        self.disableAutoResizingMask()

        self.style = .spinning
        self.startAnimation(nil)

    }
}
