//
//  SettingsConfigurator.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 07/12/2023.
//

import AppKit

final class SettingsConfigurator {
    
    /// Create Settings View Controller
    /// - Returns: created viewController
    class func assemble() -> BaseNSViewController {
        let viewController = SettingsViewController.init()
        let viewRouter = SettingsRouter.init(viewController: viewController)
    
        let viewInteractor = SettingsInteractor.init()
        let viewPresenter = SettingsPresenter.init(
            router: viewRouter,
            inputInteractor: viewInteractor
        )
        
        viewInteractor.presenter = viewPresenter
        viewController.presenter = viewPresenter
        return viewController
}
}
