//
//  URLSessionErrorHandlerEngine.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import Foundation

struct URLSessionErrorHandlerEngine: ErrorHandlerEngine {
    
    func parseNetworkRequest(
        networkError: Error?,
        networkResponse: URLResponse?,
        networkData: Data?
    ) throws -> Data {
        
        
        if let networkError = networkError {
            throw networkError
        }
        
        guard let networkData = networkData else {
            throw HttpClientErrorCodes.invalidData
        }
        
        guard let networkResponse = networkResponse as? HTTPURLResponse, 
              networkResponse.statusCode == 200 else {
            throw HttpClientErrorCodes.invalidResponse
        }
        
        return networkData
    }
    
}

