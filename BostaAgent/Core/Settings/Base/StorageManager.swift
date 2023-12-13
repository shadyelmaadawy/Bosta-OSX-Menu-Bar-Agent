//
//  StorageManager.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 07/12/2023.
//

import Foundation

// MARK: - Enums

enum StorageKeys: String {
    case appearance = "Appearance"
}

enum ViewAppearances: Int {
 
    case system
    case light
    case dark
    
    var items: [String] {
        return [
            "System",
            "Light",
            "Dark"
        ]
    }
}

protocol StorageManager {
    var currentAppearance: ViewAppearances { get set }
}

