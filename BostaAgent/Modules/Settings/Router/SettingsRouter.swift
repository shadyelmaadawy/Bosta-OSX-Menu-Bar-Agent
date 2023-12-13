//
//  SettingsRouter.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 07/12/2023.
//

import AppKit

final class SettingsRouter: SettingsRouterProtocol {
 
    // MARK: - Properties

    unowned var viewController: BaseNSViewController?
    
    // MARK: - Initialization

    init(viewController: BaseNSViewController) {
        self.viewController = viewController
    }
    
}
// MARK: - Operations

extension SettingsRouter { 
 
    func router(to direction: SettingsRouterDirection) {
        switch(direction) {
            
            case .dialogEvent(let event):
            
                guard let windowController = viewController?.navigationController as? WindowController else {
                        return
                }
                switch(event) {
                    case .showLoading:
                        windowController.showLoading()
                    case .hideLoading:
                        windowController.hideLoading()
                    case .showDialog(let question, let message):
                    windowController.showDialog(question: question, message: message, buttons: .ok, handler: nil)
            }
        }
    }
    
}
