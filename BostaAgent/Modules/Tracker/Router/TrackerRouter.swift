//
//  TrackerRouter.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import Foundation

final class TrackerRouter: TrackerRouterProtocol {
    
    // MARK: - Properties

    unowned var viewController: BaseNSViewController?
    
    // MARK: - Initialization

    init(viewController: BaseNSViewController) {
        self.viewController = viewController
    }
    
}

// MARK: - Operations

extension TrackerRouter {
    
    func router(to direction: TrackerRouterDirection) {
        
        switch(direction) {
            
            case .dismiss:
                self.viewController?.navigationController?.popViewController()
            case .dialogEvent(let event):
            
                guard let windowController = viewController?.navigationController as? WindowController else {
                        return
                    }

                switch(event) {
                    case .showDialog(let question, let message):
                        windowController.showDialog(question: question, message: message, buttons: .ok, handler: nil)
                    case .showLoading:
                        windowController.showLoading()
                    case .hideLoading:
                        windowController.hideLoading()
                }
        }
        
    }
    

}
