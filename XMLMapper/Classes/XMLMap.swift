//
//  XMLMapper.swift
//  Pods
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

public enum XMLMappingType {
    case fromXML
    case toXML
}

public final class XMLMap {
    public internal(set) var XML: [String: Any] = [:]
    public let mappingType: XMLMappingType
    public internal(set) var isKeyPresent = false
    public internal(set) var currentValue: Any?
    public internal(set) var currentKey: String?
    
    public let toObject: Bool // indicates whether the mapping is being applied to an existing object
    
    public init(mappingType: XMLMappingType, XML: [String: Any], toObject: Bool = false) {
        self.mappingType = mappingType
        self.XML = XML
        self.toObject = toObject
    }
    
    public subscript(key: String) -> XMLMap {
        
        currentKey = key
        let object = XML[key]
        let isNSNull = object is NSNull
        isKeyPresent = isNSNull ? true : object != nil
        currentValue = isNSNull ? nil : object
        
        return self
    }
    
    public func value<T>() -> T? {
        return currentValue as? T
    }
}
