//
//  UserDefaultsStorage.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 07/12/2023.
//

import Foundation

struct UserDefaultsStorage: StorageManager, AgentFoundation {
    
    // MARK: - Properties
    
    private let userDefaults = UserDefaults.standard
    
    static let instance = UserDefaultsStorage.init()
    
    var currentAppearance: ViewAppearances {
        get {
            let rawValue = userDefaults.integer(
                forKey: StorageKeys.appearance.rawValue)
            return ViewAppearances.init(rawValue: rawValue)!
        } set {
            userDefaults.set(newValue.rawValue,
                             forKey: StorageKeys.appearance.rawValue)
            self.configure()
        }
    }
    
    // MARK: - Initialization
    
    private init () { }

}

// MARK: - Configure

extension UserDefaultsStorage {
    
    func configure() {
        updateAppearance()
    }
}

// MARK: - Operations

extension UserDefaultsStorage {
    
    private func updateAppearance() {
        self.appDelegate.window!.setNewAppearance(viewAppearance: currentAppearance)
    }
    
}
