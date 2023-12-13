//
//  RequestTrackingMessage.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import Foundation

struct RequestTrackingMessage: HttpNetworkMessage {
    
    // MARK: - Properties

    let shipmentID: String

    init(for shipmentID: Int) {
        self.shipmentID = String(shipmentID)
    }
    
    // MARK: - Configure
    
    var endpoint: HttpEndPoint {
        return TrackingShipmentEndPoint.init()
    }
    
    var input: HttpInputMessage {
        let inputMessage = RequestTrackingInputMessage.init(
            query: shipmentID
        )
        return inputMessage
    }
    
}

struct TrackingShipmentEndPoint: HttpEndPoint {
    
    // MARK: - Configure
    
    var scheme: HttpScheme {
        return .https
    }
    
    var host: HttpEndPoints {
        return .baseURL
    }
    
    var path: HttpPath {
        return .shipments
    }
    
    var requestMethod: HttpRequestMethod {
        return .get
    }
    
    var headerField: [HttpHeaders: String] {
        return [
            HttpHeaders.acceptType:
            contentType.rawValue,
            HttpHeaders.contentType:
            contentType.rawValue
        ]
    }
    
    var contentType: HttpContentType {
        return .json
    }
    
}

struct RequestTrackingInputMessage: HttpInputMessage {
    
    // MARK: - Configure
    
    var inputType: InputMessagesTypes {
        return .bostaStyle
    }

    var query: String?

    var parameters: [URLQueryItem]? {
        return nil
    }
    
}

struct RequestTrackerOutputMessage: Codable {
    
    // MARK: - Structs
    
    struct CurrentStatus: Codable {
        let state: String
        let timestamp: String
    }
    
    struct TransitEvent: Codable {
        let state: String
        let timestamp: String
        let hub: String?
    }

    // MARK: - Properties
    
    let provider: String
    let currentStatus: CurrentStatus
    let trackingNumber: String
    let trackingURL: String
    let supportPhoneNumbers: [String]
    let transitEvents: [TransitEvent]
    let createDate: String
    let isEditableShipment: Bool

    // MARK: - Coding Keys

    enum CodingKeys: String, CodingKey {
        case provider
        case currentStatus = "CurrentStatus"
        case trackingNumber = "TrackingNumber"
        case trackingURL = "TrackingURL"
        case supportPhoneNumbers = "SupportPhoneNumbers"
        case transitEvents = "TransitEvents"
        case createDate = "CreateDate"
        case isEditableShipment
    }
}

struct TrackerViewModel {
    
    // MARK: - Enums
    
    enum ShipmentState: String {
        
        case delivered = "DELIVERED"
        case ticketCreated = "TICKET_CREATED"
        case inTransit = "IN_TRANSIT"
        case packageReceived = "PACKAGE_RECEIVED"
        case outForDelivery = "OUT_FOR_DELIVERY"
        case unrecognized = "Unrecognized"
        
        var description: String {
            
            switch(self) {
                
                case .delivered:
                    return "Delivered"
                case .ticketCreated:
                    return "Ticket created"
                case .inTransit:
                    return "In transit"
                case .packageReceived:
                    return "Package received"
                case .outForDelivery:
                    return "Out for delivery"
                case .unrecognized:
                    return "Unrecognized"
                }
            
        }
    }
    
    // MARK: - Properties

    let trackingNumber: String
    let currentState: ShipmentState
    let lastUpdate: String

    // MARK: - Initialization
    
    init(for trackerMessage: RequestTrackerOutputMessage) {
        
        self.trackingNumber = trackerMessage.trackingNumber
        
        self.currentState = ShipmentState.init(rawValue: trackerMessage.currentStatus.state) ?? ShipmentState.unrecognized
        
        self.lastUpdate = Date.daysAgoSince(for: trackerMessage.currentStatus.timestamp)
    }
}
