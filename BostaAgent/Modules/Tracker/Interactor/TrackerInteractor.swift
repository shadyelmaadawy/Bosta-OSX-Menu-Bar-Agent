//
//  TrackerInteractor.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import RxSwift
import Foundation

final class TrackerInteractor {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag.init()
    
    weak var presenter: TrackerInteractorOutputProtocol?
    private let shipmentTrackerRepository: ShipmentTrackerRepositoryProtocol
    
    // MARK: - Initialization
    
    init(shipmentTrackingRepository: ShipmentTrackerRepositoryProtocol = ShipmentTrackerRepositoryImplementation.init()) {
        self.shipmentTrackerRepository = shipmentTrackingRepository
    }
    
}

// MARK: - Operations

extension TrackerInteractor: TrackerInteractorInputProtocol {
    
    func requestTrackingMessage(for shipmentNumber: Int) {
        
        shipmentTrackerRepository.requestShipmentMessage(for: shipmentNumber)
        .observe(on: MainScheduler.instance)
        .subscribe(onSuccess: { [weak presenter] trackerRequestMessage in
            
            guard let presenter = presenter else {
                return
            }
            presenter.trackerMessageFetchedSuccessfully.accept(trackerRequestMessage)
            
        }, onFailure: { [weak presenter] networkError in
            
            guard let presenter = presenter else {
                return
            }
            presenter.trackerMessageFetchedFailed.accept(networkError)
            
        })
        .disposed(by: disposeBag)

    }

}
