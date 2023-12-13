//
//  HttpEngine.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 04/12/2023.
//

import RxSwift
import Foundation

protocol HttpEngine {
    /// An error handler of  Http Engine
    var errorHandler: ErrorHandlerEngine { get }
    /// Execute Http request
    /// - Parameter networkMessage: required endpoint
    /// - Returns: Single instance In user Initiated queue
    func executeRequest(_ networkMessage: HttpNetworkMessage) -> Single<Data>
}

extension HttpEngine {
    
    /// Create url request instance, it can throw an error
    /// - Parameter networkMessage: Http required message
    /// - Returns: created url request instance
    func createURLRequest(_ networkMessage: HttpNetworkMessage) throws -> URLRequest {
        
        var urlComponent                     = URLComponents.init()
        
        urlComponent.scheme                  = networkMessage.endpoint.scheme.rawValue
        urlComponent.host                    = networkMessage.endpoint.host.rawValue
        urlComponent.path                    = networkMessage.endpoint.path.rawValue
        
        switch(networkMessage.input.inputType) {
            
            case .bostaStyle:
                if let query = networkMessage.input.query {
                    urlComponent.path         = networkMessage.endpoint.path.rawValue + query
                }
            case .query:
                urlComponent.query            = networkMessage.input.query
            case .parameters:
                urlComponent.queryItems       = networkMessage.input.parameters
        }

        guard let baseURL = urlComponent.url else {
            throw HttpClientErrorCodes.invalidURL
        }
        
        var urlRequest                         = URLRequest(url: baseURL)
        urlRequest.httpMethod                  = networkMessage.endpoint.requestMethod.rawValue
        urlRequest.cachePolicy                 = .reloadIgnoringLocalAndRemoteCacheData

        for (headerKey, headerValue) in networkMessage.endpoint.headerField {
            urlRequest.setValue(headerValue, forHTTPHeaderField: headerKey.rawValue)
        }
        return urlRequest

    }
 
}
