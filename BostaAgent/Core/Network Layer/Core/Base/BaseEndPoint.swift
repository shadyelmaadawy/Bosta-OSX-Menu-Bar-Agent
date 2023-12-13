//
//  BaseEndPoint.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 04/12/2023.
//

import Foundation

protocol HttpEndPoint {
    var scheme: HttpScheme { get }
    var host: HttpEndPoints { get }
    var path: HttpPath { get }
    var requestMethod: HttpRequestMethod { get }
    var headerField: [HttpHeaders: String] { get }
}

enum InputMessagesTypes {
    case bostaStyle
    case query
    case parameters
}

protocol HttpInputMessage {
    var inputType: InputMessagesTypes { get }
    var query: String? { get }
    var parameters: [URLQueryItem]? { get }
}

protocol HttpNetworkMessage {
    var endpoint: HttpEndPoint { get }
    var input: HttpInputMessage { get }
}

enum HttpScheme: String {
    case https = "https"
}

enum HttpEndPoints: String {
    case baseURL = "tracking.bosta.co"
}

enum HttpPath: String {
    case shipments = "/shipments/track/"
}

enum HttpRequestMethod: String {
    case get = "GET"
}

enum HttpHeaders: String {
    case acceptType = "Accept"
    case contentType = "Content-Type"
}

enum HttpContentType: String {
    case json = "application/json"
}

