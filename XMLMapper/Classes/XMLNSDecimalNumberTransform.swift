//
//  XMLNSDecimalNumberTransform.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

import Foundation

open class NSDecimalNumberTransform: XMLTransformType {
    public typealias Object = NSDecimalNumber
    public typealias XML = String
    
    public init() {}
    
    open func transformFromXML(_ value: Any?) -> Object? {
        if let string = value as? String {
            return NSDecimalNumber(string: string)
        } else if let number = value as? NSNumber {
            return NSDecimalNumber(decimal: number.decimalValue)
        } else if let double = value as? Double {
            return NSDecimalNumber(floatLiteral: double)
        }
        return nil
    }
    
    open func transformToXML(_ value: NSDecimalNumber?) -> XML? {
        guard let value = value else { return nil }
        return value.description
    }
}
