//
//  ShipmentTrackerRepositoryProtocol.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import RxSwift
import Foundation

protocol ShipmentTrackerRepositoryProtocol {
    
    /// Request from data layer a to perform a request  to get shipment details
    /// - Parameter shipmentID: Shipment ID Number of message
    /// - Returns: Single Instance With Output Message
    func requestShipmentMessage(for shipmentID: Int) -> Single<RequestTrackerOutputMessage>
}

final class ShipmentTrackerRepositoryImplementation {
    
    // MARK: - Properties

    private let networkService: NetworkEngineService
    
    // MARK: - Initialization
    
    init(networkService: NetworkEngineService = NetworkEngine()) {
        self.networkService = networkService
    }
    
}

// MARK: - Operations

extension ShipmentTrackerRepositoryImplementation: ShipmentTrackerRepositoryProtocol {
    
    func requestShipmentMessage(for shipmentID: Int) -> Single<RequestTrackerOutputMessage> {
        
        let networkMessage = RequestTrackingMessage.init(for: shipmentID)
        let networkRequest = networkService.get(
            from: networkMessage
        ) as Single<RequestTrackerOutputMessage>
        
        return networkRequest
    }
    

}
