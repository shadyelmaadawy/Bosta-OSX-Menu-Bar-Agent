//
//  ErrorHandlerEngine.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import Foundation

protocol ErrorHandlerEngine {
    /// Parse network request to detect error
    /// - Parameters:
    ///   - networkError: optional network error that comes from network
    ///   - networkResponse: optional network response that comes from
    ///   - networkData: optional network data as buffer
    /// - Returns: unwrapped network data buffer
    func parseNetworkRequest(
        networkError: Error?,
        networkResponse: URLResponse?,
        networkData: Data?
    ) throws -> Data
}

