//
//  HomePresenter.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import RxSwift
import RxRelay
import Foundation

final class HomePresenter: HomePresenterProtocol, AgentFoundation {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag.init()

    private let router: HomeRouterProtocol
    private let inputInteractor: HomeInteractorInputProtocol

    // MARK: - Button Clicks Binding
    
    let searchButtonClicked = PublishRelay<Void>()
    let settingsButtonClicked = PublishRelay<Void>()
    let exitButtonClicked = PublishRelay<Void>()

    // MARK: - Data Binding
    
    let shipmentNumber = BehaviorRelay<Int?>(
        value: nil
    )
    
    let trackerMessageFetchedSuccessfully = PublishRelay<RequestTrackerOutputMessage>()
    let trackerMessageFetchedFailed = PublishRelay<Error>()
    
    // MARK: - Initialization

    init(router: HomeRouterProtocol, inputInteractor: HomeInteractorInputProtocol) {
        
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

extension HomePresenter {
    
    private func bindSubjects() {
        
        bindSearchButtonClick()
        bindSettingsButtonClick()
        bindExitButtonClick()

        bindTrackerMessageFetchedSuccessfully()
        bindTrackerMessageFetchedFailed()
    }
    
    private func bindSearchButtonClick() {
        
        searchButtonClicked
        .subscribe({ [weak self] _ in
            
            guard let self = self,
                let shipmentNumber = self.shipmentNumber.value else { return
            }
            Self.logger.log(event: .userInterface, from: Self.self, data: "Search Button Clicked")

            self.router.router(to: .dialogEvent(event: .showLoading, killApp: false))
            inputInteractor.requestTrackingMessage(for: shipmentNumber)
        })
        .disposed(by: disposeBag)

    }
    
    private func bindSettingsButtonClick() {
        
        settingsButtonClicked
        .subscribe({ [weak self] _ in
        
            guard let self = self else {
                return
            }

            Self.logger.log(event: .userInterface, from: Self.self, data: "Settings Button Clicked")
            self.router.router(to: .settings)

        })
        .disposed(by: disposeBag)
        
    }
    
    private func bindExitButtonClick() {
        
        exitButtonClicked
        .subscribe({ [weak self] _ in
                        
            guard let self = self else {
                return
            }
            Self.logger.log(event: .userInterface, from: Self.self, data: "Exit Button Clicked")

            self.router.router(to: .dialogEvent(
                event: .showDialog(question:  "Warning", message: "Are you sure you want to exit?"), killApp: true
            ))
        })
        .disposed(by: disposeBag)
        
    }
    
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    private func bindTrackerMessageFetchedSuccessfully() {
     
        self.trackerMessageFetchedSuccessfully
        .subscribe(onNext: { [weak self] trackerMessage in
            
            guard let self = self else { 
                return
            }
            
            self.router.router(to: .dialogEvent(event: .hideLoading, killApp: false))
            Self.logger.log(event: .network, from: Self.self, printIn: .debug, data: "Tracking Object received: \(trackerMessage)")
            
            guard let shipmentNumber = self.shipmentNumber.value else {
                return
            }
            
            let trackerViewModel = TrackerViewModel(for: trackerMessage)
            
            self.router.router(to: .tracker(shipmentNumber: shipmentNumber, viewModel: trackerViewModel))

        })
        .disposed(by: disposeBag)
        
    }
    
    private func bindTrackerMessageFetchedFailed() {
        
        self.trackerMessageFetchedFailed
        .subscribe(onNext: { [weak self] networkError in
            
            guard let self = self else {
                return
            }
            
            self.router.router(to: .dialogEvent(event: .hideLoading, killApp: false))
            self.router.router(to: .dialogEvent(event: .showDialog(question: "Error", message: networkError.localizedDescription), killApp: false))

        })
        .disposed(by: disposeBag)
        
    }
}
