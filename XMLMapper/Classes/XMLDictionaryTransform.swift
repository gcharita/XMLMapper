//
//  XMLDictionaryTransform.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 15/09/2017.
//
//

import Foundation

///Transforms [String: AnyObject] <-> [Key: Value] where Key is RawRepresentable as String, Value is XMLMappable
public struct XMLDictionaryTransform<Key, Value>: XMLTransformType where Key: Hashable, Key: RawRepresentable, Key.RawValue == String, Value: XMLMappable {
    
    public init() {
        
    }
    
    public func transformFromXML(_ value: Any?) -> [Key: Value]? {
        
        guard let XML = value as? [String: Any] else {
            
            return nil
        }
        
        let result = XML.reduce([:]) { (result, element) -> [Key: Value] in
            
            guard
                let key = Key(rawValue: element.0),
                let valueXML = element.1 as? [String: Any],
                let value = Value(XML: valueXML)
                else {
                    
                    return result
            }
            
            var result = result
            result[key] = value
            return result
        }
        
        return result
    }
    
    public func transformToXML(_ value: [Key: Value]?) -> Any? {
        
        let result = value?.reduce([:]) { (result, element) -> [String: Any] in
            
            let key = element.0.rawValue
            let value = element.1.toXML()
            
            var result = result
            result[key] = value
            return result
        }
        
        return result
    }
}
