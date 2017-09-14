//
//  XMLMapper.swift
//  Pods
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

enum XMLMappingType {
    case fromXML
    case toXML
}

class XMLMap {
    private var XML: [String: Any] = [:]
    public let mappingType: XMLMappingType
    public internal(set) var currentValue: Any?
    public internal(set) var currentKey: String?
    
    public init(mappingType: XMLMappingType, XML: [String: Any]) {
        self.XML = XML
        self.mappingType = mappingType
    }
    
    public subscript(key: String) -> XMLMap {
        currentKey = key
        currentValue = XML[key]
        return self
    }
    
    public func value<T>() -> T? {
        return currentValue as? T
    }
}
