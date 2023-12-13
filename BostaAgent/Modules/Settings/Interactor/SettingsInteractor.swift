//
//  SettingsInteractor.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 07/12/2023.
//

import RxSwift
import Foundation

final class SettingsInteractor {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag.init()
    
    weak var presenter: SettingsInteractorOutputProtocol?
    
    private var storageManager: StorageManager

    // MARK: - Initialization

    init(storageManager: StorageManager = UserDefaultsStorage.instance) {
        self.storageManager = storageManager
    }
}

extension SettingsInteractor: SettingsInteractorInputProtocol {
 
    func getCurrentAppearancesSettings()  {
        
        let appearancesList = storageManager.currentAppearance.items
        let currentActiveAppearance = storageManager.currentAppearance.rawValue
        
        presenter?.fetchedCurrentAppearancesSuccessfully.accept((available: appearancesList, active: currentActiveAppearance))
    }
        
    func setNewAppearance(_ appearanceIndex: Int) {
        storageManager.currentAppearance = .init(rawValue: appearanceIndex)!
        
        presenter?.settingsUpdatedSuccessfully.accept(())
    }
}
