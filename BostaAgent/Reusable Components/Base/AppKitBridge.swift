//
//  AppKitBridge.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 28/11/2023.
//

import AppKit
import SwiftUI

final class AppKitBridge<T:View>: NSHostingView<T> {
    
    // MARK: - Initialization

    required init(rootView: T) {
        super.init(rootView: rootView)
        self.configure()
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure

extension AppKitBridge {
    
    func configure() {
        
        self.disableAutoResizingMask()
        
    }
    
}
