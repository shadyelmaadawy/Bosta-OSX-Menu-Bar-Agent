//
//  NSFont+Ext.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 28/11/2023.
//

import AppKit

extension NSFont {
    
    /// Raw Text Style Sizes Dictionary
    private static let textStyleSizesDictionary: [NSFont.TextStyle: CGFloat] = [
        .largeTitle: 34, .title1: 26, .title2: 22,
        .title3: 20, .headline: 17, .body: 17,
        .callout: 16, .subheadline: 15, .footnote: 13,
        .caption1: 12, .caption2: 11
    ]

    /// Supported weights for custom font
    enum FontsWeights: String {
        
        case regular = "Regular"
        case regularItalic = "RegularItalic"

        case bold = "Bold"
        case semiBold = "SemiBold"
        
        case boldItalic = "BoldItalic"
        case semiBoldItalic = "SemiBoldItalic"
    }
    
    static var familyName: String {
        return "Poppins"
    }

    /// Get custom font and apply text style.
    /// - Parameters:
    ///   - fontWeight: Required weight for custom font, example bold regular ..etc.
    ///   - textStyle: Text style that will be applied to the font
    /// - Returns: Required font
    class func getFont(_ fontWeight: FontsWeights, textStyle: NSFont.TextStyle) -> NSFont {
     
        let resourcesName: String = "\(familyName)-\(fontWeight.rawValue)"
        guard let fontSize = textStyleSizesDictionary[textStyle],
              let baseFont = NSFont(name: resourcesName, size: fontSize) else {
            return NSFont.init()
        }
        return baseFont
    }

}

