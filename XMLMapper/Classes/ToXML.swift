//
//  ToXML.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

import Foundation

import Foundation

private func setValue(_ value: Any, map: XMLMap) {
    setValue(value, key: map.currentKey!, checkForNestedKeys: map.keyIsNested, delimiter: map.nestedKeyDelimiter, dictionary: &map.XML)
}

private func setValue(_ value: Any, key: String, checkForNestedKeys: Bool, delimiter: String, dictionary: inout [String : Any]) {
    if checkForNestedKeys {
        let keyComponents = ArraySlice(key.components(separatedBy: delimiter).filter { !$0.isEmpty })
        setValue(value, forKeyPathComponents: keyComponents, dictionary: &dictionary)
    } else {
        dictionary[key] = value
    }
}

private func setValue(_ value: Any, forKeyPathComponents components: ArraySlice<String>, dictionary: inout [String : Any]) {
    guard let head = components.first else {
        return
    }
    
    if components.count == 1 {
        dictionary[head] = value
    } else {
        var child = dictionary[head] as? [String : Any] ?? [:]
        
        let tail = components.dropFirst()
        setValue(value, forKeyPathComponents: tail, dictionary: &child)
        
        dictionary[head] = child
    }
}

internal final class ToXML {
    
    class func basicType<N>(_ field: N, map: XMLMap) {
        if let x = field as Any? , false
            || x is NSNumber // Basic types
            || x is Bool
            || x is Int
            || x is Double
            || x is Float
            || x is String
            || x is NSNull
            || x is Array<NSNumber> // Arrays
            || x is Array<Bool>
            || x is Array<Int>
            || x is Array<Double>
            || x is Array<Float>
            || x is Array<String>
            || x is Array<Any>
            || x is Array<Dictionary<String, Any>>
            || x is Dictionary<String, NSNumber> // Dictionaries
            || x is Dictionary<String, Bool>
            || x is Dictionary<String, Int>
            || x is Dictionary<String, Double>
            || x is Dictionary<String, Float>
            || x is Dictionary<String, String>
            || x is Dictionary<String, Any>
        {
            setValue(x, map: map)
        }
    }
    
    class func optionalBasicType<N>(_ field: N?, map: XMLMap) {
        if let field = field {
            basicType(field, map: map)
        }
    }
    
    class func object<N: XMLBaseMappable>(_ field: N, map: XMLMap) {
        if let result = XMLMapper().toXML(field) as Any? {
            setValue(result, map: map)
        }
    }
    
    class func optionalObject<N: XMLBaseMappable>(_ field: N?, map: XMLMap) {
        if let field = field {
            object(field, map: map)
        }
    }
    
    class func objectArray<N: XMLBaseMappable>(_ field: Array<N>, map: XMLMap) {
        let XMLObjects = XMLMapper().toXMLArray(field)
        
        setValue(XMLObjects, map: map)
    }
    
    class func optionalObjectArray<N: XMLBaseMappable>(_ field: Array<N>?, map: XMLMap) {
        if let field = field {
            objectArray(field, map: map)
        }
    }
    
    class func twoDimensionalObjectArray<N: XMLBaseMappable>(_ field: Array<Array<N>>, map: XMLMap) {
        var array = [[[String: Any]]]()
        for innerArray in field {
            let XMLObjects = XMLMapper().toXMLArray(innerArray)
            array.append(XMLObjects)
        }
        setValue(array, map: map)
    }
    
    class func optionalTwoDimensionalObjectArray<N: XMLBaseMappable>(_ field: Array<Array<N>>?, map: XMLMap) {
        if let field = field {
            twoDimensionalObjectArray(field, map: map)
        }
    }
    
    class func objectSet<N: XMLBaseMappable>(_ field: Set<N>, map: XMLMap) {
        let XMLObjects = XMLMapper().toXMLSet(field)
        
        setValue(XMLObjects, map: map)
    }
    
    class func optionalObjectSet<N: XMLBaseMappable>(_ field: Set<N>?, map: XMLMap) {
        if let field = field {
            objectSet(field, map: map)
        }
    }
    
    class func objectDictionary<N: XMLBaseMappable>(_ field: Dictionary<String, N>, map: XMLMap) {
        let XMLObjects = XMLMapper().toXMLDictionary(field)
        
        setValue(XMLObjects, map: map)
    }
    
    class func optionalObjectDictionary<N: XMLBaseMappable>(_ field: Dictionary<String, N>?, map: XMLMap) {
        if let field = field {
            objectDictionary(field, map: map)
        }
    }
    
    class func objectDictionaryOfArrays<N: XMLBaseMappable>(_ field: Dictionary<String, [N]>, map: XMLMap) {
        let XMLObjects = XMLMapper().toXMLDictionaryOfArrays(field)
        
        setValue(XMLObjects, map: map)
    }
    
    class func optionalObjectDictionaryOfArrays<N: XMLBaseMappable>(_ field: Dictionary<String, [N]>?, map: XMLMap) {
        if let field = field {
            objectDictionaryOfArrays(field, map: map)
        }
    }
}
