//
//  NSImage+Ext.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 28/11/2023.
//

import AppKit

extension NSImage {
    
    // MARK: - Enums
    
    enum BaseSystemImageSymbols: String {
        
        case appBar = "square.stack.3d.forward.dottedline.fill"
        
        case search = "magnifyingglass"
        case settings = "gear"
        case copyRight = "c.circle"
        case exit = "door.left.hand.open"
        
        case refresh = "arrow.clockwise.circle"
        case back = "arrow.backward"
        
    }
    
    /// Create Ns Image from system images
    /// - Parameters:
    ///   - baseName: name of the symbol
    ///   - tintColor: color will be applied to symbol
    /// - Returns:In case of success, it will return the required symbol,  Otherwise, it will return an empty NS Image..
    class func createSystemImage(
            _ baseName: BaseSystemImageSymbols,
            withColor tintColor: NSColor = .labelColor,
            size: CGFloat = 16.00) -> NSImage {
        
            guard let baseImage = NSImage(systemSymbolName: baseName.rawValue, accessibilityDescription: nil) else {
                return NSImage.init()
            }
            
            var symbolConfiguration = NSImage.SymbolConfiguration(
                pointSize: size, weight: .regular, scale: .medium
            )
            symbolConfiguration = symbolConfiguration.applying(.init(paletteColors: [tintColor]))
            
            return baseImage.withSymbolConfiguration(symbolConfiguration)!
    }

}
