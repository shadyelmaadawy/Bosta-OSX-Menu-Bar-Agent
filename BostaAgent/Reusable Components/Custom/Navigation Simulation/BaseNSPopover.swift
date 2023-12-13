//
//  BaseNSPopover.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 27/11/2023.
//

import AppKit

enum ViewAppearance {
    
    case system
    case light
    case dark
    
    var items: [String] {
        return [
            "System",
            "Light",
            "Dark",
        ]
    }
    
    var nsAppearanceInstance: NSAppearance? {
        
        switch(self) {
            case .system:
                return nil
            case .light:
                return NSAppearance.init(named: NSAppearance.Name.vibrantLight)
            case .dark:
                return NSAppearance.init(named: NSAppearance.Name.vibrantDark)

        }
    }
}

protocol NavigationController: AnyObject {
    var viewControllers: Stack<BaseNSViewController> { get }
    func pushViewController(_ viewController: BaseNSViewController)
    func popViewController()
}

protocol WindowController: AnyObject {
    var windowIsShown: Bool { get }
    func showWindow()
    func hideWindow()
    func showLoading()
    func hideLoading()
    func terminate()
    func setNewAppearance(viewAppearance: ViewAppearances)
    func showDialog(question: String, message: String, buttons:  BaseNavigationContainer.DialogButtons, handler: ((Bool) -> ())?)
    func makeKeyAndVisible()
    func setTarget(_ target: AnyObject, selector: Selector)
    func setWindowImage(_ imageBaseName: NSImage.BaseSystemImageSymbols)
    func setWindowTitle(_ windowTitle: String)
}



final class BaseNSPopover: NSPopover, WindowController, NavigationController, AgentFoundation {

    // MARK: - UI Components

    private let statusItem = NSStatusBar.system.statusItem(
          withLength: NSStatusItem.variableLength
    )
      
    private lazy var containerViewController: BaseNavigationContainer = {
        let baseViewController = BaseNavigationContainer.init()
        baseViewController.parentPopOver = self
        return baseViewController
    }()
    
    // MARK: - Properties
    
    var viewControllers: Stack<BaseNSViewController> = .init()
    
    private var statusMenuButton: NSStatusBarButton {
        guard let statusButton = statusItem.button else {
            fatalError("Cannot find status bar button")
        }
        return statusButton
    }
    
    var windowIsShown: Bool {
        return self.isShown
    }

    // MARK: - Initialization

    init(rootViewController: BaseNSViewController) {
        super.init()
        self.configure(rootViewController)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Object Life Cycle;

    deinit {
        print("Deinitialization: \(Self.objectIdentifier)")
    }

}

// MARK: - Configure

extension BaseNSPopover {
    
    private func configure(_ rootViewController: BaseNSViewController) {
        
        self.animates = true
        self.behavior = .transient

        /// Private API ( Variable )  to hide arrow.
        self.setValue(true, forKey: "shouldHideAnchor")

        self.pushViewController(rootViewController)
    }
    
    func setNewAppearance(viewAppearance: ViewAppearances) {
        NSAnimationContext.runAnimationGroup({ context in
            
            context.duration = 0.15
            context.allowsImplicitAnimation = true
            
            switch(viewAppearance) {
                case .system:
                    self.appearance = nil
                case .light:
                    self.appearance = NSAppearance(named: NSAppearance.Name.vibrantLight)
                case .dark:
                    self.appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)

            }
        })
    }
    


}

// MARK: - Navigation Controller Operations

extension BaseNSPopover {
 
    func pushViewController(_ viewController: BaseNSViewController) {

        let isEmpty = self.viewControllers.isEmpty()
        
        viewController.navigationController = self
        self.viewControllers.push(viewController)
        
        self.containerViewController.addSubViewController(viewController, operation: isEmpty ? .initialization : .push
        )

    }
    
    func popViewController() {
        
        self.viewControllers.pop()
        self.containerViewController.addSubViewController(self.viewControllers.peek(), operation: .pop)

    }
    
    @objc func backButtonClicked(_ sender: BaseNSButton) {
        self.popViewController()
    }

}
// MARK: - Window Controller Operations

extension BaseNSPopover {
    
    func terminate() {
        NSApp.terminate(nil)
    }
    
   func makeKeyAndVisible() {
        self.contentViewController = containerViewController
    }
    
    func setWindowImage(_ imageBaseName: NSImage.BaseSystemImageSymbols) {
        statusMenuButton.image = .createSystemImage(imageBaseName)
    }
    
    func setWindowTitle(_ windowTitle: String) {
        statusMenuButton.title =  windowTitle
    }
    
    func setTarget(_ target: AnyObject, selector: Selector) {
        statusMenuButton.target = target
        statusMenuButton.action = selector
    }
    
    func showWindow() {
        
        self.show(
            relativeTo: statusMenuButton.bounds,
            of: statusMenuButton,
            preferredEdge: NSRectEdge.minY
        )
        self.contentViewController?.view.window?.makeKey()
        
    }
    
    func hideWindow() {
        self.performClose(nil)

    }
    
    func showLoading() {
        self.containerViewController.showLoadingView()
    }
    
    func hideLoading() {
        self.containerViewController.hideLoadingView()
    }
    
    func showDialog(question: String, message: String, buttons:  BaseNavigationContainer.DialogButtons, handler: ((Bool) -> ())? = nil) {
        self.containerViewController.showDialog(question, message, buttons: buttons, handler)
    }
    
  


}

