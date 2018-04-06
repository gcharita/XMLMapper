//
//  XMLHexColorTransform.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 15/09/2017.
//
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif

#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
open class XMLHexColorTransform: XMLTransformType {
    
    #if os(iOS) || os(tvOS) || os(watchOS)
    public typealias Object = UIColor
    #else
    public typealias Object = NSColor
    #endif
    
    public typealias XML = String
    
    var prefix: Bool = false
    
    var alpha: Bool = false
    
    public init(prefixToXML: Bool = false, alphaToXML: Bool = false) {
        alpha = alphaToXML
        prefix = prefixToXML
    }
    
    open func transformFromXML(_ value: Any?) -> Object? {
        if let rgba = value as? String {
            if rgba.hasPrefix("#") {
                let index = rgba.index(rgba.startIndex, offsetBy: 1)
                #if swift(>=3.2)
                    let hex = String(rgba[index...])
                #else
                    let hex = rgba.substring(from: index)
                #endif
                return getColor(hex: hex)
            } else {
                return getColor(hex: rgba)
            }
        }
        return nil
    }
    
    open func transformToXML(_ value: Object?) -> XML? {
        if let value = value {
            return hexString(color: value)
        }
        return nil
    }
    
    private func hexString(color: Object) -> String {
        let comps = color.cgColor.components!
        let compsCount = color.cgColor.numberOfComponents
        let r: Int
        let g: Int
        var b: Int
        let a = Int(comps[compsCount - 1] * 255)
        if compsCount == 4 { // RGBA
            r = Int(comps[0] * 255)
            g = Int(comps[1] * 255)
            b = Int(comps[2] * 255)
        } else { // Grayscale
            r = Int(comps[0] * 255)
            g = Int(comps[0] * 255)
            b = Int(comps[0] * 255)
        }
        var hexString: String = ""
        if prefix {
            hexString = "#"
        }
        hexString += String(format: "%02X%02X%02X", r, g, b)
        
        if alpha {
            hexString += String(format: "%02X", a)
        }
        return hexString
    }
    
    private func getColor(hex: String) -> Object? {
        var red: CGFloat   = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat  = 0.0
        var alpha: CGFloat = 1.0
        
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            #if swift(>=3.2)
                let hexCharactersCount = hex.count
            #else
                let hexCharactersCount = hex.characters.count
            #endif
            switch (hexCharactersCount) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                // Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8
                return nil
            }
        } else {
            // "Scan hex error
            return nil
        }
        #if os(iOS) || os(tvOS) || os(watchOS)
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        #else
            return NSColor(red: red, green: green, blue: blue, alpha: alpha)
        #endif
    }
}
#endif
