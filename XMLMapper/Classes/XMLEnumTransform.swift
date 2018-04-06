//
//  XMLEnumTransform.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 15/09/2017.
//
//

import Foundation

open class XMLEnumTransform<T: RawRepresentable>: XMLTransformType where T.RawValue: LosslessStringConvertible {
    public typealias Object = T
    public typealias XML = String
    
    public init() {}
    
    open func transformFromXML(_ value: Any?) -> Object? {
        if let stringValue = value as? XML, let raw = T.RawValue(stringValue) {
            return T(rawValue: raw)
        }
        return nil
    }
    
    open func transformToXML(_ value: T?) -> XML? {
        return value?.rawValue.description
    }
}
