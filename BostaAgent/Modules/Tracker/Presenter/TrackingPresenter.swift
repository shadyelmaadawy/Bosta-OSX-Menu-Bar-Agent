//
//  TrackingPresenter.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//
import RxSwift
import RxRelay
import Foundation

final class TrackerPresenter: TrackerPresenterProtocol, AgentFoundation {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag.init()

    private let router: TrackerRouterProtocol
    private let inputInteractor: TrackerInteractorInputProtocol

    private let shipmentNumber: Int
    private let trackerVM: TrackerViewModel
    
    // MARK: - Button Clicks Biding
    
    let refreshButtonClicked = PublishRelay<Void>()

    // MARK: - Data Biding

    let viewIsLoaded = PublishRelay<Void>()
    
    let trackingNumberBuffer = PublishRelay<String>()
    let trackStatusBuffer = PublishRelay<String>()
    let lastUpdateBuffer = PublishRelay<String>()
    
    let trackerMessageFetchedSuccessfully = PublishRelay<RequestTrackerOutputMessage>()
    let trackerMessageFetchedFailed = PublishRelay<Error>()

    // MARK: - Initialization
    
    init(router: TrackerRouterProtocol, inputInteractor: TrackerInteractorInputProtocol, for shipmentNumber: Int, trackerVM: TrackerViewModel) {
        
        self.router = router
        self.inputInteractor = inputInteractor
        
        self.shipmentNumber = shipmentNumber
        self.trackerVM = trackerVM
        
        self.bindSubjects()

    }
    
    // MARK: - Object Life Cycle;

    deinit {
        Self.logger.log(event: .objectLifeCycle, from: Self.self, data: "Deinitialization: \(Self.objectIdentifier)")
    }

}

// MARK: - Operations

extension TrackerPresenter {
    
    private func configureView(_ trackerViewModel: TrackerViewModel) {
        
        self.trackingNumberBuffer.accept(
            "Tracking No. \(trackerViewModel.trackingNumber)"
        )
        self.trackStatusBuffer.accept(trackerViewModel.currentState.description)

        self.lastUpdateBuffer.accept(
            "(Last update since \(trackerViewModel.lastUpdate) day ago.)"
        )

    }
    
}

// MARK: - Binding Operations

extension TrackerPresenter {
    
    private func bindSubjects() {
        
        bindViewIsLoadedEvent()
        bindRefreshButtonClick()

        bindTrackerMessageFetchedSuccessfully()
        bindTrackerMessageFetchedFailed()
    }
    
    private func bindViewIsLoadedEvent() {
        
        viewIsLoaded
        .subscribe { [weak self] _ in
            
            guard let self = self else { return }
            
            Self.logger.log(event: .userInterface, from: Self.self, data: "View Is Loaded event raised.")

            self.configureView(trackerVM)

        }
        .disposed(by: disposeBag)
        
    }

    private func bindRefreshButtonClick() {
        
        refreshButtonClicked
        .subscribe { [weak self] _ in
                
            guard let self = self else {
                    return
            }
            self.router.router(to: .dialogEvent(event: .showLoading))
            
            Self.logger.log(event: .userInterface, from: Self.self, data: "Refresh Button Clicked")

            self.inputInteractor.requestTrackingMessage(for: shipmentNumber)
        }
        .disposed(by: disposeBag)
        
    }
}

extension TrackerPresenter: TrackerInteractorOutputProtocol {
    
    private func bindTrackerMessageFetchedSuccessfully() {
        self.trackerMessageFetchedSuccessfully
        .subscribe(onNext: { [weak self] trackerMessage in
            
            guard let self = self else {
                return
            }
            self.router.router(to: .dialogEvent(event: .hideLoading))
            
            let trackerViewModel = TrackerViewModel.init(for: trackerMessage)
            
            self.configureView(trackerViewModel)

        })
        .disposed(by: disposeBag)
    }
    
    private func bindTrackerMessageFetchedFailed() {
        
        self.trackerMessageFetchedFailed
        .subscribe(onNext: { [weak self] networkError in
            
            guard let self = self else {
                return
            }
            
            self.router.router(to: .dialogEvent(event: .hideLoading))

            self.router.router(to: .dialogEvent(event: .showDialog(question: "Error", message: (networkError.localizedDescription))))
            
        })
        .disposed(by: disposeBag)
        
    }

}
