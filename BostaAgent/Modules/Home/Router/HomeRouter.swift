//
//  HomeRouter.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import AppKit

final class HomeRouter: HomeRouterProtocol {
    
    // MARK: - Properties

    unowned var viewController: BaseNSViewController?
    
    // MARK: - Initialization

    init(viewController: BaseNSViewController) {
        self.viewController = viewController
    }
    
}

// MARK: - Operations

extension HomeRouter {
    
    func router(to direction: HomeRouterDirection) {
        
        switch(direction) {
            
            case .tracker(let shipmentNumber, let viewModel):
            
                let viewController = TrackerConfigurator.assemble(
                    for: shipmentNumber,
                    viewModel: viewModel
                )
                self.viewController?.navigationController?.pushViewController(viewController)
            
            case .settings:
            
                self.viewController?.navigationController?.pushViewController(SettingsConfigurator.assemble())
            
        case .dialogEvent(let event, let killApp):
            
                guard let windowController = viewController?.navigationController as? WindowController else {
                        return
                    }

                switch(event) {
                    
                    case .showLoading:
                        windowController.showLoading()
                    case .hideLoading:
                        windowController.hideLoading()
                    case .showDialog(let question, let message):
                    
                    windowController.showDialog(question: question, message: message, buttons: killApp ? .yesNo : .ok, handler: { dialogResult in

                            guard dialogResult == true else {
                                return
                            }
                        if(killApp) { windowController.terminate() }
                    })
                }
        }
        
    }
    

}
