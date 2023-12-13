//
//  AppDelegate.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 27/11/2023.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate, AgentFoundation {
    
    // MARK: - Properties

    var window: WindowController?
        
    // MARK: - Delegates Life Cycle

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        window = BaseNSPopover.init(
            rootViewController: HomeConfigurator.assemble()
        )
        
        window?.setTarget(self, selector: #selector(windowPopoverController(_:)))
        
        window?.setWindowTitle(
            "Bosta Tracker Agent"
        )
        window?.setWindowImage(.appBar)
        window?.makeKeyAndVisible()
        UserDefaultsStorage.instance.configure()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

}

// MARK: - Operations

extension AppDelegate {
    
    @objc private func windowPopoverController(_ sender: Any) {
        
        guard self.window?.windowIsShown == false else {
            self.window?.hideWindow()
            return
        }
        Self.logger.log(event: .system, from: Self.self, data: "Window Popover is clicked")

        self.window?.showWindow()

    }


}
