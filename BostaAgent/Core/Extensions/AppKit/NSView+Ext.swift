//
//  NSView+Ext.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 27/11/2023.
//

import AppKit

extension NSView {
    
    /// A generic Variable to access background NSView Instance.
    var currentBackgroundColor: NSColor {
        
        guard let currentBackgroundColor = self.layer?.backgroundColor else {
            return NSColor.clear
        }
        
        return NSColor.init(
            cgColor: currentBackgroundColor
        )!
    }
    
    /// A generic function to enable auto resizing mask across NSView Instances
    func enableAutoResizingMask() {
        self.translatesAutoresizingMaskIntoConstraints = true
    }

    /// A generic function to disable auto resizing mask across NSView Instances
    func disableAutoResizingMask() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    /// A generic function to set background color across NSView Instances
    func setBackgroundColor(_ requiredColor: NSColor) {
        self.wantsLayer = true
        self.layer?.backgroundColor = requiredColor.cgColor
    }
    
    /// A generic function to set shadow color across NSView instance.
    /// - Parameter shadowColor: color of shadow
    func setShadow(_ shadowColor: NSColor = .controlAccentColor) {
      
        guard self.shadow == nil else {
            return
        }
        
        self.wantsLayer = true
        self.shadow = NSShadow.init()

        self.layer?.shadowOpacity = 0.5
        self.layer?.shadowRadius = 6.00
        
        self.layer?.shadowColor = shadowColor.cgColor
        self.layer?.shadowOffset = NSMakeSize(1/2, 1/2)

    }
    
    /// Set radius in
    /// - Parameters:
    ///   - radius: radius to use when drawing rounded corners for the layer’s background, default value is 8.00 pixel
    func setRadius(_ radius: CGFloat = 8.00) {
        
        self.layer?.masksToBounds = true
        self.layer?.cornerRadius = radius
        
    }
 
}
