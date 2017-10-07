//
//  XMLEnumTransform.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 15/09/2017.
//
//

import Foundation

open class XMLEnumTransform<T: RawRepresentable>: XMLTransformType {
    public typealias Object = T
    public typealias XML = T.RawValue
    
    public init() {}
    
    open func transformFromXML(_ value: Any?) -> Object? {
        if let raw = value as? T.RawValue {
            return T(rawValue: raw)
        }
        return nil
    }
    
    open func transformToXML(_ value: T?) -> XML? {
        if let obj = value {
            return obj.rawValue
        }
        return nil
    }
}
