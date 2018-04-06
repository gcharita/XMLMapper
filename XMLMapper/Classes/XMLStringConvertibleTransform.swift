//
//  XMLStringConvertibleTransform.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 27/09/2017.
//

import Foundation

open class XMLStringConvertibleTransform<T: LosslessStringConvertible>: XMLTransformType {
    public typealias Object = T
    public typealias XML = String
    
    public init() {}
    
    open func transformFromXML(_ value: Any?) -> Object? {
        if let stringValue = value as? XML {
            return T(stringValue)
        }
        return nil
    }
    
    open func transformToXML(_ value: T?) -> XML? {
        if let obj = value {
            return obj.description
        }
        return nil
    }
}
