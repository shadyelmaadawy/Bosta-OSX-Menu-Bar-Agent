//
//  JsonDecoderEngine.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import Foundation

struct JsonDecoderEngine: JsonEngine {

    // MARK: - Properties
    
    private let decoder: JSONDecoder

    // MARK: - Initialization
    
    init(_ jsonDecoder: JSONDecoder = .init()) {
        self.decoder = jsonDecoder
    }

}

// MARK: - Operations

extension JsonDecoderEngine {
    
    func parse<T: Codable>(from dataBuffer: Data, as outputMessageType: T.Type) throws -> T {
        return try decoder.decode(outputMessageType, from: dataBuffer)
    }
    
}
