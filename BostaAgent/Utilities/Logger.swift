//
//  Logger.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 04/12/2023.
//

import Foundation

struct Logger {
        
    // MARK: - Enums
    
    enum BuildConfiguration: String {
        case debug = "DEBUG"
        case release = "RELEASE"
    }
    
    enum Events: String {
        case system = "System"
        case network = "Network"
        case userInterface = "User Interface"
        case objectLifeCycle = "Object Life Cycle"
    }
    
    // MARK: - Properties
    
    static let instance = Logger.init()
    
    // MARK: - Initialization

    private init () {}
    
}

// MARK: - Operations

extension Logger {
    
    func log(event: Events, from objectInstance: AgentFoundation.Type, printIn mode: BuildConfiguration = .release, data: Any) {
        
        if(mode == .debug) {
            #if DEBUG
                print(Date(), " | " , event.rawValue, " | ", "Is Main Thread: \(Thread.isMainThread)", " | " , objectInstance.objectIdentifier, "--->", data)
            #endif
        } else {
            
            print(Date(), " | " , event.rawValue, " | " , "Is Main Thread: \(Thread.isMainThread)", " | ", objectInstance.objectIdentifier, "--->", data)

        }
    }

}
