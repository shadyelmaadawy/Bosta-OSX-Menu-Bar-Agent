//
//  BaseNavigationContainer.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 03/12/2023.
//

import AppKit
import RxRelay

final class BaseNavigationContainer: BaseNSViewController {

    // MARK: Enums
    
    enum DialogViewEvents {
        case showLoading
        case hideLoading
        case showDialog(question: String, message: String)
    }

    enum NavigationOperations {
        case pop
        case push
        case initialization
    }
    
    
    // MARK: - Properties
    
    weak var parentPopOver: BaseNSPopover?
    
    // MARK: - UI Components
    
    private lazy var navigationView: BaseNSView = {
        let baseView = BaseNSView.init()
        baseView.disableAutoResizingMask()
        return baseView
    }()
    
    private lazy var appBarLabel: BaseNSLabel = {
        let baseLabel = BaseNSLabel.init(.primary)
        baseLabel.alignment = .center
        baseLabel.setText("Bosta Tracker")
        baseLabel.font = .getFont(.regular, textStyle: .subheadline)
        return baseLabel
    }()

    private lazy var appBarBackButton: TransparentNSButton = {
        let baseButton = TransparentNSButton.init()
        baseButton.isHidden = true
        baseButton.target = parentPopOver
        baseButton.action = #selector(parentPopOver?.backButtonClicked(_:))
        baseButton.setImage(.back, withColor: .accent)
        return baseButton
    }()
    
    private lazy var appBarDivider: AppKitBridge = {
        return AppKitBridge.init(rootView: SwiftUIDivider.init())
    }()

    private lazy var loadingView: BaseLoadingView = {
        let baseView = BaseLoadingView.init()
        return baseView
    }()
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        self.view = navigationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubViews()
    }
}

// MARK: - Configure

extension BaseNavigationContainer {
    
    func configureViewController(_ operation: NavigationOperations) {

        switch(operation) {
            case .initialization:
                return
            case .pop:
                self.appBarBackButton.isHidden = true
            case .push:
                self.appBarBackButton.isHidden = false
        }

        self.view.subviews.last?.removeFromSuperview()
    }
}

// MARK: - Operations

extension BaseNavigationContainer {
  
    func addSubViewController(_ subViewController: BaseNSViewController?, operation: NavigationOperations) {

        let originalXPoint = self.view.frame.origin.x
        let pointsPerMove = self.view.frame.width * 2
        
        NSAnimationContext.runAnimationGroup({ context in
            
            context.duration = 0.1
            context.allowsImplicitAnimation = true

            guard let subViewController = subViewController else {
                return
            }
            self.configureViewController(operation)
            
            if(operation == .push) {
                self.view.frame.origin.x += pointsPerMove
            } else if(operation == .pop){
                self.view.frame.origin.x -= pointsPerMove
            }

            self.view.addSubview(subViewController.view)
            let subViewConstraints = [
                subViewController.view.topAnchor.constraint(equalTo: appBarDivider.bottomAnchor),
                subViewController.view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
                subViewController.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                subViewController.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            ]
            NSLayoutConstraint.activate(subViewConstraints)
    
        }) {
            
            NSAnimationContext.runAnimationGroup({ context in
                
                context.duration = 0.15
                context.allowsImplicitAnimation = true
                
                self.view.frame.origin.x = originalXPoint
            })
            
        }
        

    }
    
}

// MARK: - Operations

extension BaseNavigationContainer {

    enum DialogButtons {
        case yesNo
        case ok
    }

    func showDialog(_ question: String = "", _ message: String = "", buttons: DialogButtons, _ handler: ((Bool) -> ())? = nil) {

        let nativeAlert = NSAlert.init()
        
        nativeAlert.messageText = question
        nativeAlert.informativeText = message
        
        nativeAlert.alertStyle = .warning
        if(buttons == .ok) {
            nativeAlert.addButton(withTitle: "OK")
        } else {
            nativeAlert.addButton(withTitle: "Yes")
            nativeAlert.addButton(withTitle: "No")
        }
        let resultOfDialog = nativeAlert.runModal() == .alertFirstButtonReturn
        handler?(resultOfDialog)
    }
    
    func showLoadingView()  {
        
        self.navigationView.userInteractionEnabled = false
        self.view.addSubview(loadingView)
            
        let loadingViewViewConstraints = [
            loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(loadingViewViewConstraints)

    }

    func hideLoadingView() {
        
        self.loadingView.removeFromSuperview()
        self.navigationView.userInteractionEnabled = true

    }

}

// MARK: - Layout SubViews

extension BaseNavigationContainer {
    
    private func layoutSubViews() {
        
        layoutAppBarBackButton()
        layoutAppBarLabel()
        layoutAppBarDivider()
        
    }
    
    private func layoutAppBarBackButton() {
        
        self.view.addSubview(appBarBackButton)

        let appBarBackButton = [
            appBarBackButton.topAnchor.constraint(greaterThanOrEqualTo: safeArea.topAnchor, constant: 6),
            appBarBackButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
        ]
        NSLayoutConstraint.activate(appBarBackButton)
    }
    
    private func layoutAppBarLabel() {
        
        self.view.addSubview(appBarLabel)
        
        let appBarLabelConstraints = [
            appBarLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            appBarBackButton.centerYAnchor.constraint(equalTo: appBarLabel.centerYAnchor),
            appBarLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            appBarLabel.leadingAnchor.constraint(greaterThanOrEqualTo: appBarBackButton.trailingAnchor, constant: 64),
            appBarLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor, constant: -96)
        ]
        NSLayoutConstraint.activate(appBarLabelConstraints)
        
    }

    private func layoutAppBarDivider() {
        
        self.view.addSubview(appBarDivider)
        
        let appBarDividerConstraints = [
            appBarDivider.topAnchor.constraint(equalTo: appBarLabel.bottomAnchor, constant: 8),
            appBarDivider.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            appBarDivider.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
        ]
        NSLayoutConstraint.activate(appBarDividerConstraints)
        
    }
    
}
