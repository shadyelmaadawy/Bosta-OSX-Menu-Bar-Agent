//
//  SettingsProtocols.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 07/12/2023.
//

import RxRelay
import Foundation

protocol SettingsViewProtocol: AnyObject {
    var presenter: SettingsPresenterProtocol! { get set }
}

protocol SettingsPresenterProtocol: AnyObject {
    var viewIsLoaded: PublishRelay<Void> { get }
    var updateButtonIsClicked: PublishRelay<Int> { get }
    var appearancesItemsReady: PublishRelay<(available: [String], active: Int)> { get }
}

protocol SettingsInteractorInputProtocol: AnyObject {
    var presenter: SettingsInteractorOutputProtocol? { get set }
    func getCurrentAppearancesSettings()
    func setNewAppearance(_ appearanceIndex: Int)
}

protocol SettingsInteractorOutputProtocol: AnyObject {
    
    var fetchedCurrentAppearancesSuccessfully: PublishRelay<(available: [String], active: Int)> { get }
    
    var settingsUpdatedSuccessfully: PublishRelay<Void> { get }
    var settingsErrorRaised: PublishRelay<Error> { get }
}

enum SettingsRouterDirection {
    case dialogEvent(event: BaseNavigationContainer.DialogViewEvents)
}

protocol SettingsRouterProtocol: AnyObject {
    var viewController: BaseNSViewController? { get set }
    func router(to direction : SettingsRouterDirection)
}
