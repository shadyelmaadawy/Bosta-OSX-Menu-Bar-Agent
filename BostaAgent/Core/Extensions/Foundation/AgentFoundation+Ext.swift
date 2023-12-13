//
//  AgentFoundation+Ext.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 27/11/2023.
//

import AppKit
import Foundation

protocol AgentFoundation {}
extension AgentFoundation {
    
    var appDelegate: AppDelegate {
        return NSApp.delegate as! AppDelegate
    }
    
    /// A generic variable to get name of NsObject
    static var objectIdentifier: String {
        return String.init(describing: self)
    }
    
    /// Logger Instance
    static var logger: Logger {
        return Logger.instance
    }
}
