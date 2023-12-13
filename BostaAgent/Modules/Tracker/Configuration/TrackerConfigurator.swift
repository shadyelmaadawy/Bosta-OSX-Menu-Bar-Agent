//
//  TrackerConfigurator.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import Foundation

final class TrackerConfigurator {
    
    /// Create Home View Controller
    /// - Returns: created viewController
    class func assemble(for shipmentNumber: Int, viewModel: TrackerViewModel) -> BaseNSViewController {
        
        let viewController = TrackerViewController.init()
        let viewRouter = TrackerRouter.init(viewController: viewController)
    
        let viewInteractor = TrackerInteractor.init()
        let viewPresenter = TrackerPresenter.init(
            router: viewRouter,
            inputInteractor: viewInteractor, 
            for: shipmentNumber,
            trackerVM: viewModel
        )
        
        viewInteractor.presenter = viewPresenter
        viewController.presenter = viewPresenter
        return viewController
        
    }
}

