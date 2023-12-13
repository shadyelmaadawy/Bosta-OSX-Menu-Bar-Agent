//
//  SettingsPresenter.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 07/12/2023.
//

import RxSwift
import RxRelay
import Foundation

final class SettingsPresenter: SettingsPresenterProtocol, AgentFoundation {

    // MARK: - Properties
    
    private let disposeBag = DisposeBag.init()

    private let router: SettingsRouterProtocol
    private let inputInteractor: SettingsInteractorInputProtocol
    
    // MARK: - Button Clicks Biding

    let updateButtonIsClicked = PublishRelay<Int>()
    
    // MARK: - Data Biding
    
    let viewIsLoaded = PublishRelay<Void>()
    let appearancesItemsReady = PublishRelay<(available: [String], active: Int)>()
    let fetchedCurrentAppearancesSuccessfully = PublishRelay<(available: [String], active: Int)>()
    
    let settingsUpdatedSuccessfully = PublishRelay<Void>()
    let settingsErrorRaised = PublishRelay<Error>()

    // MARK: - Initialization

    init(router: SettingsRouterProtocol, inputInteractor: SettingsInteractorInputProtocol) {
        
        self.router = router
        self.inputInteractor = inputInteractor
        
        self.bindSubjects()
    }
    
    // MARK: - Object Life Cycle;

    deinit {
        Self.logger.log(event: .objectLifeCycle, from: Self.self, data: "Deinitialization: \(Self.objectIdentifier)")
    }

}

// MARK: - Binding Operations

extension SettingsPresenter {
    
    private func bindSubjects() {
        
        bindViewIsLoadedEvent()
        bindFetchCurrentAppearances()
        
        bindUpdateButton()
        bindSettingSettingsUpdatedSuccessfully()
        bindSettingsErrorRaised()
    }
        
    private func bindViewIsLoadedEvent() {
        
        viewIsLoaded
            .subscribe { [weak self] _ in
                
                guard let self = self else { return }
                Self.logger.log(event: .userInterface, from: Self.self, data: "View Is Loaded event raised.")
                
                self.inputInteractor.getCurrentAppearancesSettings()
            }
            .disposed(by: disposeBag)
        
    }
    
    private func bindUpdateButton() {
        
        updateButtonIsClicked
            .subscribe { [weak self] index in
                guard let self = self, let index = index.element else {
                    return
                }
                Self.logger.log(event: .userInterface, from: Self.self, data: "Update Button Clicked")
                
                self.router.router(to: .dialogEvent(event: .showLoading))
                self.inputInteractor.setNewAppearance(index)
            }
            .disposed(by: disposeBag)
        
    }
    
}

extension SettingsPresenter: SettingsInteractorOutputProtocol {
    
    
    private func bindFetchCurrentAppearances() {
        
        fetchedCurrentAppearancesSuccessfully.subscribe(onNext: { [ weak self] fetchResult in
            
            guard let self = self else {
                return
            }
            
            self.appearancesItemsReady.accept(fetchResult)
            
        }).disposed(by: disposeBag)
        
    }
    
    private func bindSettingSettingsUpdatedSuccessfully() {
        
        settingsUpdatedSuccessfully.subscribe(onNext: {[weak self] _ in
            
            guard let self = self else {
                return
            }
            self.router.router(to: .dialogEvent(event: .hideLoading))
        }).disposed(by: disposeBag)
    }
    
    private func bindSettingsErrorRaised() {
        
        settingsErrorRaised.subscribe(onNext: { [weak self] updateError in
            
            guard let self = self else {
                return
            }
            self.router.router(to: .dialogEvent(event: .showDialog(question: "Error", message: updateError.localizedDescription)))

        }).disposed(by: disposeBag)

    }

}
