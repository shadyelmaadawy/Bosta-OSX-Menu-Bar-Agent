//
//  NumericNSTextField.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 28/11/2023.
//

import AppKit

final class NumericNSTextField: BaseNSTextField {
    
    // MARK: - Properties
    
    private var numberFormatter: NumberFormatter {
        let baseFormatter = NumberFormatter.init()
        baseFormatter.minimum = 1
        baseFormatter.maximum = 999_999_999
        baseFormatter.numberStyle = .none
        return baseFormatter
    }
    
    
    // MARK: - Initialization
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure

extension NumericNSTextField {
    
    override func configure() {
        
        super.configure()
        
        self.formatter = numberFormatter

    }
    
}
