//
//  BaseNSViewController.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 28/11/2023.
//

import AppKit
import RxSwift
import RxRelay

class BaseNSViewController: NSViewController,  AgentFoundation {

    // MARK: - Properties
    
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    lazy var safeArea: NSLayoutGuide = {
        return self.view.safeAreaLayoutGuide
    }()
    
    weak var navigationController: NavigationController?

    // MARK: - User Interface Events
    
    /// Override this function to use a programmatic UI, Otherwise, a 'could not load the nibName in bundle NSBundle' exception will be thrown.
    override func loadView() {
        self.view = BaseNSView.init()
    }
        
    // MARK: - Object Life Cycle;

    deinit {
        Self.logger.log(event: .objectLifeCycle, from: Self.self, data: "Deinitialization")
    }
}
