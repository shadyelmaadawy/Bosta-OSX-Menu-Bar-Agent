//
//  HomeConfigurator.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import AppKit

final class HomeConfigurator {
    
    /// Create Home View Controller
    /// - Returns: created viewController
    class func assemble() -> BaseNSViewController {
        
        let viewController = HomeViewController.init()
        let viewRouter = HomeRouter.init(viewController: viewController)
    
        let viewInteractor = TrackerInteractor.init()
        let viewPresenter = HomePresenter.init(
            router: viewRouter, 
            inputInteractor: viewInteractor
        )
        
        viewInteractor.presenter = viewPresenter
        viewController.presenter = viewPresenter
        return viewController
        
    }
}

