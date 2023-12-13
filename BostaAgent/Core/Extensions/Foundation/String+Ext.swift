//
//  String+Ext.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import Foundation

extension String {
    
    /// casting string to valid number, in case of fails, return -1
    var numeric: Int {
        guard let numberCasting = Int(self),
            self.count > 0 else {
            return -1
        }
        return numberCasting
    }
    
    /// Check if the string is valid number
    var isValidNumeric: Bool {
        guard let isValidNumeric = Int(self),
              isValidNumeric > 0,
              isValidNumeric <= 999_999_999 else {
            return false
        }
        return true
    }
    
}
