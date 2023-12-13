//
//  JsonEngine.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import Foundation

protocol JsonEngine {
    
    /// Parse data buffer to json type
    /// - Parameters:
    ///   - dataBuffer: the data that comes from network
    ///   - outputMessageType: the type of object
    /// - Returns: codable type
    func parse<T: Codable>(from dataBuffer: Data, as outputMessageType: T.Type) throws -> T
    
}

