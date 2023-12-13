//
//  HomeProtocols.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import RxRelay

protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol! { get set }
}

protocol HomePresenterProtocol: AnyObject {
    var searchButtonClicked: PublishRelay<Void> { get }
    var settingsButtonClicked: PublishRelay<Void> { get }
    var exitButtonClicked: PublishRelay<Void> { get }
    var shipmentNumber: BehaviorRelay<Int?> { get }
}

typealias HomeInteractorInputProtocol = TrackerInteractorInputProtocol
typealias HomeInteractorOutputProtocol = TrackerInteractorOutputProtocol

enum HomeRouterDirection {
    case tracker(shipmentNumber: Int, viewModel: TrackerViewModel)
    case settings
    case dialogEvent(event: BaseNavigationContainer.DialogViewEvents,  killApp: Bool)
}

protocol HomeRouterProtocol: AnyObject {
    var viewController: BaseNSViewController? { get set }
    func router(to direction: HomeRouterDirection)
}

