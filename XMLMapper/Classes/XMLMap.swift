//
//  XMLMap.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//
import Foundation

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
    var keyIsNested = false
    public internal(set) var nestedKeyDelimiter: String = "."
    private var isAttribute = false
    
    public let toObject: Bool // indicates whether the mapping is being applied to an existing object
    
    public init(mappingType: XMLMappingType, XML: [String: Any], toObject: Bool = false) {
        self.mappingType = mappingType
        self.XML = XML
        self.toObject = toObject
    }
    
    /// Sets the current mapper value and key.
    /// The Key paramater can be a period separated string (ex. "distance.value") to access sub objects.
    public subscript(key: String) -> XMLMap {
        return self.subscript(key: key)
    }
    
    public subscript(key: String, delimiter delimiter: String) -> XMLMap {
        return self.subscript(key: key, delimiter: delimiter)
    }
    
    public subscript(key: String, nested nested: Bool) -> XMLMap {
        return self.subscript(key: key, nested: nested)
    }
    
    public subscript(key: String, nested nested: Bool, delimiter delimiter: String) -> XMLMap {
        return self.subscript(key: key, nested: nested, delimiter: delimiter)
    }
    
    public subscript(key: String, ignoreNil ignoreNil: Bool) -> XMLMap {
        return self.subscript(key: key, ignoreNil: ignoreNil)
    }
    
    public subscript(key: String, delimiter delimiter: String, ignoreNil ignoreNil: Bool) -> XMLMap {
        return self.subscript(key: key, delimiter: delimiter, ignoreNil: ignoreNil)
    }
    
    public subscript(key: String, nested nested: Bool, ignoreNil ignoreNil: Bool) -> XMLMap {
        return self.subscript(key: key, nested: nested, ignoreNil: ignoreNil)
    }
    
    public subscript(key: String, nested nested: Bool?, delimiter delimiter: String, ignoreNil ignoreNil: Bool) -> XMLMap {
        return self.subscript(key: key, nested: nested, delimiter: delimiter, ignoreNil: ignoreNil)
    }
    
    private func `subscript`(key: String, nested: Bool? = nil, delimiter: String = ".", ignoreNil: Bool = false) -> XMLMap {
        // save key and value associated to it
        currentKey = key
        keyIsNested = nested ?? key.contains(delimiter)
        nestedKeyDelimiter = delimiter
        
        if isAttribute {
            isAttribute = false
            currentKey = "\(XMLParserConstant.attributePrefix)\(key)"
            if keyIsNested {
                var keyPathComponents = key.components(separatedBy: delimiter)
                if !keyPathComponents.isEmpty {
                    let tail = keyPathComponents.removeLast()
                    keyPathComponents.append("\(XMLParserConstant.attributePrefix)\(tail)")
                    currentKey = keyPathComponents.joined(separator: delimiter)
                }
            }
        }
        
        if mappingType == .fromXML, let currentKey = currentKey {
            // check if a value exists for the current key
            // do this pre-check for performance reasons
            if keyIsNested {
                // break down the components of the key that are separated by .
                (isKeyPresent, currentValue) = valueFor(ArraySlice(currentKey.components(separatedBy: delimiter)), dictionary: XML)
            } else {
                let object = XML[currentKey]
                let isNSNull = object is NSNull
                isKeyPresent = isNSNull ? true : object != nil
                currentValue = isNSNull ? nil : object
            }
            
            // update isKeyPresent if ignoreNil is true
            if ignoreNil && currentValue == nil {
                isKeyPresent = false
            }
        }
        
        return self
    }
    
    public func value<T>() -> T? {
        if let _ = T.self as? Array<Any>.Type, currentValue as? T == nil {
            return [currentValue] as? T
        } else if let _ = T.self as? Dictionary<String, [Any]>.Type, currentValue as? T == nil {
            return (currentValue as? [String: Any])?.mapValues({ [$0] }) as? T
        }
        return currentValue as? T
    }
    
    public var attributes: XMLMap {
        isAttribute = true
        return self
    }
    
    public var innerText: XMLMap {
        return self[XMLParserConstant.Key.text]
    }
    
    public var nodesOrder: XMLMap {
        return self[XMLParserConstant.Key.nodesOrder]
    }
}

/// Fetch value from XML dictionary, loop through keyPathComponents until we reach the desired object
private func valueFor(_ keyPathComponents: ArraySlice<String>, dictionary: [String: Any]) -> (Bool, Any?) {
    // Implement it as a tail recursive function.
    if keyPathComponents.isEmpty {
        return (false, nil)
    }
    
    if let keyPath = keyPathComponents.first {
        let isTail = keyPathComponents.count == 1
        let object = dictionary[keyPath]
        if object is NSNull {
            return (isTail, nil)
        } else if keyPathComponents.count > 1, let dict = object as? [String: Any] {
            let tail = keyPathComponents.dropFirst()
            return valueFor(tail, dictionary: dict)
        } else if keyPathComponents.count > 1, let array = object as? [Any] {
            let tail = keyPathComponents.dropFirst()
            return valueFor(tail, array: array)
        } else {
            return (isTail && object != nil, object)
        }
    }
    
    return (false, nil)
}

/// Fetch value from XML Array, loop through keyPathComponents them until we reach the desired object
private func valueFor(_ keyPathComponents: ArraySlice<String>, array: [Any]) -> (Bool, Any?) {
    // Implement it as a tail recursive function.
    
    if keyPathComponents.isEmpty {
        return (false, nil)
    }
    
    //Try to convert keypath to Int as index
    if let keyPath = keyPathComponents.first,
        let index = Int(keyPath) , index >= 0 && index < array.count {
        
        let isTail = keyPathComponents.count == 1
        let object = array[index]
        
        if object is NSNull {
            return (isTail, nil)
        } else if keyPathComponents.count > 1, let array = object as? [Any]  {
            let tail = keyPathComponents.dropFirst()
            return valueFor(tail, array: array)
        } else if  keyPathComponents.count > 1, let dict = object as? [String: Any] {
            let tail = keyPathComponents.dropFirst()
            return valueFor(tail, dictionary: dict)
        } else {
            return (isTail, object)
        }
    }
    
    return (false, nil)
}
