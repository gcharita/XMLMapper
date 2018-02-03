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
        // save key and value associated to it
        return self[key, delimiter: ".", ignoreNil: false]
    }
    
    public subscript(key: String, delimiter delimiter: String) -> XMLMap {
        let nested = key.contains(delimiter)
        return self[key, nested: nested, delimiter: delimiter, ignoreNil: false]
    }
    
    public subscript(key: String, nested nested: Bool) -> XMLMap {
        return self[key, nested: nested, delimiter: ".", ignoreNil: false]
    }
    
    public subscript(key: String, nested nested: Bool, delimiter delimiter: String) -> XMLMap {
        return self[key, nested: nested, delimiter: delimiter, ignoreNil: false]
    }
    
    public subscript(key: String, ignoreNil ignoreNil: Bool) -> XMLMap {
        return self[key, delimiter: ".", ignoreNil: ignoreNil]
    }
    
    public subscript(key: String, delimiter delimiter: String, ignoreNil ignoreNil: Bool) -> XMLMap {
        let nested = key.contains(delimiter)
        return self[key, nested: nested, delimiter: delimiter, ignoreNil: ignoreNil]
    }
    
    public subscript(key: String, nested nested: Bool, ignoreNil ignoreNil: Bool) -> XMLMap {
        return self[key, nested: nested, delimiter: ".", ignoreNil: ignoreNil]
    }
    
    public subscript(key: String, nested nested: Bool, delimiter delimiter: String, ignoreNil ignoreNil: Bool) -> XMLMap {
        // save key and value associated to it
        currentKey = key
        keyIsNested = nested
        nestedKeyDelimiter = delimiter
        
        if isAttribute {
            currentKey = "_\(key)"
            keyIsNested = false
            isAttribute = false
        }
        
        if mappingType == .fromXML {
            // check if a value exists for the current key
            // do this pre-check for performance reasons
            if let currentKey = currentKey, !keyIsNested {
                let object = XML[currentKey]
                let isNSNull = object is NSNull
                isKeyPresent = isNSNull ? true : object != nil
                currentValue = isNSNull ? nil : object
            } else {
                // break down the components of the key that are separated by .
                (isKeyPresent, currentValue) = valueFor(ArraySlice(key.components(separatedBy: delimiter)), dictionary: XML)
            }
            
            // update isKeyPresent if ignoreNil is true
            if ignoreNil && currentValue == nil {
                isKeyPresent = false
            }
        }
        
        return self
    }
    
    public func value<T>() -> T? {
        return currentValue as? T
    }
    
    public var attributes: XMLMap {
        isAttribute = true
        return self
    }
    
    public var innerText: XMLMap {
        return self[XMLParserConstant.Key.text]
    }
}

/// Fetch value from XML dictionary, loop through keyPathComponents until we reach the desired object
private func valueFor(_ keyPathComponents: ArraySlice<String>, dictionary: [String: Any]) -> (Bool, Any?) {
    // Implement it as a tail recursive function.
    if keyPathComponents.isEmpty {
        return (false, nil)
    }
    
    if let keyPath = keyPathComponents.first {
        let object = dictionary[keyPath]
        if object is NSNull {
            return (true, nil)
        } else if keyPathComponents.count > 1, let dict = object as? [String: Any] {
            let tail = keyPathComponents.dropFirst()
            return valueFor(tail, dictionary: dict)
        } else if keyPathComponents.count > 1, let array = object as? [Any] {
            let tail = keyPathComponents.dropFirst()
            return valueFor(tail, array: array)
        } else {
            return (object != nil, object)
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
        
        let object = array[index]
        
        if object is NSNull {
            return (true, nil)
        } else if keyPathComponents.count > 1, let array = object as? [Any]  {
            let tail = keyPathComponents.dropFirst()
            return valueFor(tail, array: array)
        } else if  keyPathComponents.count > 1, let dict = object as? [String: Any] {
            let tail = keyPathComponents.dropFirst()
            return valueFor(tail, dictionary: dict)
        } else {
            return (true, object)
        }
    }
    
    return (false, nil)
}
