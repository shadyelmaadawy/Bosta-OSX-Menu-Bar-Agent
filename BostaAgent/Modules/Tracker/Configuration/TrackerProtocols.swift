//
//  TrackerProtocols.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 05/12/2023.
//

import RxRelay
import Foundation

protocol TrackerViewProtocol: AnyObject {
    var presenter: TrackerPresenterProtocol! { get set }
}

protocol TrackerPresenterProtocol: AnyObject {
    var viewIsLoaded: PublishRelay<Void> { get }
    var refreshButtonClicked: PublishRelay<Void> { get }
    var trackingNumberBuffer: PublishRelay<String> { get }
    var trackStatusBuffer: PublishRelay<String> { get }
    var lastUpdateBuffer: PublishRelay<String> { get }
}

protocol TrackerInteractorInputProtocol: AnyObject {
    var presenter: TrackerInteractorOutputProtocol? { get set }
    func requestTrackingMessage(for shipmentNumber: Int)
}

protocol TrackerInteractorOutputProtocol: AnyObject {
    var trackerMessageFetchedSuccessfully: PublishRelay<RequestTrackerOutputMessage> { get }
    var trackerMessageFetchedFailed: PublishRelay<Error> { get }
}

enum TrackerRouterDirection {
    case dismiss
    case dialogEvent(event: BaseNavigationContainer.DialogViewEvents)
}

protocol TrackerRouterProtocol: AnyObject {
    var viewController: BaseNSViewController? { get set }
    func router(to direction: TrackerRouterDirection)
}
