//
//  EnginesErrorCodes.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import Foundation

enum HttpClientErrorCodes: LocalizedError {
    
    case timeout
    case invalidRequest
    case invalidURL
    case invalidData
    case invalidResponse
    
    var errorDescription: String? {
        
        switch(self) {
            case .timeout:
                return "Connection timeout."
            case .invalidURL:
                return "This url is not valid."
            case .invalidData:
                return "Data is not valid."
            case .invalidResponse:
                return "Response of network request is not equal to 200."
            case .invalidRequest:
                return "An error has been occurred while processing your request."
        }
    }
}

enum JsonEngineErrorCodes: LocalizedError {
    
    case invalidJson
    case invalidCodable
    
    var errorDescription: String? {
        switch(self) {
            case .invalidJson:
                return "Json is not valid."
            case .invalidCodable:
                return "Codable type is not valid."
        }
    }

}
