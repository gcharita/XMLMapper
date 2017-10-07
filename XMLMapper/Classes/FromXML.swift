//
//  FromXML.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

import Foundation

internal final class FromXML {
    
    /// Basic type
    class func basicType<FieldType>(_ field: inout FieldType, object: FieldType?) {
        if let value = object {
            field = value
        }
    }
    
    /// optional basic type
    class func optionalBasicType<FieldType>(_ field: inout FieldType?, object: FieldType?) {
        field = object
    }
    
    /// Implicitly unwrapped optional basic type
    class func optionalBasicType<FieldType>(_ field: inout FieldType!, object: FieldType?) {
        field = object
    }
    
    /// Mappable object
    class func object<N: XMLBaseMappable>(_ field: inout N, map: XMLMap) {
        if map.toObject {
            field = XMLMapper().map(XMLObject: map.currentValue, toObject: field)
        } else if let value: N = XMLMapper().map(XMLObject: map.currentValue) {
            field = value
        }
    }
    
    /// Optional Mappable Object
    
    class func optionalObject<N: XMLBaseMappable>(_ field: inout N?, map: XMLMap) {
        if let f = field , map.toObject && map.currentValue != nil {
            field = XMLMapper().map(XMLObject: map.currentValue, toObject: f)
        } else {
            field = XMLMapper().map(XMLObject: map.currentValue)
        }
    }
    
    /// Implicitly unwrapped Optional Mappable Object
    class func optionalObject<N: XMLBaseMappable>(_ field: inout N!, map: XMLMap) {
        if let f = field , map.toObject && map.currentValue != nil {
            field = XMLMapper().map(XMLObject: map.currentValue, toObject: f)
        } else {
            field = XMLMapper().map(XMLObject: map.currentValue)
        }
    }
    
    /// mappable object array
    class func objectArray<N: XMLBaseMappable>(_ field: inout Array<N>, map: XMLMap) {
        if let objects = XMLMapper<N>().mapArray(XMLObject: map.currentValue) {
            field = objects
        }
    }
    
    /// optional mappable object array
    
    class func optionalObjectArray<N: XMLBaseMappable>(_ field: inout Array<N>?, map: XMLMap) {
        if let objects: Array<N> = XMLMapper().mapArray(XMLObject: map.currentValue) {
            field = objects
        } else {
            field = nil
        }
    }
    
    /// Implicitly unwrapped optional mappable object array
    class func optionalObjectArray<N: XMLBaseMappable>(_ field: inout Array<N>!, map: XMLMap) {
        if let objects: Array<N> = XMLMapper().mapArray(XMLObject: map.currentValue) {
            field = objects
        } else {
            field = nil
        }
    }
    
    /// mappable object array
    class func twoDimensionalObjectArray<N: XMLBaseMappable>(_ field: inout Array<Array<N>>, map: XMLMap) {
        if let objects = XMLMapper<N>().mapArrayOfArrays(XMLObject: map.currentValue) {
            field = objects
        }
    }
    
    /// optional mappable 2 dimentional object array
    class func optionalTwoDimensionalObjectArray<N: XMLBaseMappable>(_ field: inout Array<Array<N>>?, map: XMLMap) {
        field = XMLMapper().mapArrayOfArrays(XMLObject: map.currentValue)
    }
    
    /// Implicitly unwrapped optional 2 dimentional mappable object array
    class func optionalTwoDimensionalObjectArray<N: XMLBaseMappable>(_ field: inout Array<Array<N>>!, map: XMLMap) {
        field = XMLMapper().mapArrayOfArrays(XMLObject: map.currentValue)
    }
    
    /// Dctionary containing Mappable objects
    class func objectDictionary<N: XMLBaseMappable>(_ field: inout Dictionary<String, N>, map: XMLMap) {
        if map.toObject {
            field = XMLMapper<N>().mapDictionary(XMLObject: map.currentValue, toDictionary: field)
        } else {
            if let objects = XMLMapper<N>().mapDictionary(XMLObject: map.currentValue) {
                field = objects
            }
        }
    }
    
    /// Optional dictionary containing Mappable objects
    class func optionalObjectDictionary<N: XMLBaseMappable>(_ field: inout Dictionary<String, N>?, map: XMLMap) {
        if let f = field , map.toObject && map.currentValue != nil {
            field = XMLMapper().mapDictionary(XMLObject: map.currentValue, toDictionary: f)
        } else {
            field = XMLMapper().mapDictionary(XMLObject: map.currentValue)
        }
    }
    
    /// Implicitly unwrapped Dictionary containing Mappable objects
    class func optionalObjectDictionary<N: XMLBaseMappable>(_ field: inout Dictionary<String, N>!, map: XMLMap) {
        if let f = field , map.toObject && map.currentValue != nil {
            field = XMLMapper().mapDictionary(XMLObject: map.currentValue, toDictionary: f)
        } else {
            field = XMLMapper().mapDictionary(XMLObject: map.currentValue)
        }
    }
    
    /// Dictionary containing Array of Mappable objects
    class func objectDictionaryOfArrays<N: XMLBaseMappable>(_ field: inout Dictionary<String, [N]>, map: XMLMap) {
        if let objects = XMLMapper<N>().mapDictionaryOfArrays(XMLObject: map.currentValue) {
            field = objects
        }
    }
    
    /// Optional Dictionary containing Array of Mappable objects
    class func optionalObjectDictionaryOfArrays<N: XMLBaseMappable>(_ field: inout Dictionary<String, [N]>?, map: XMLMap) {
        field = XMLMapper<N>().mapDictionaryOfArrays(XMLObject: map.currentValue)
    }
    
    /// Implicitly unwrapped Dictionary containing Array of Mappable objects
    class func optionalObjectDictionaryOfArrays<N: XMLBaseMappable>(_ field: inout Dictionary<String, [N]>!, map: XMLMap) {
        field = XMLMapper<N>().mapDictionaryOfArrays(XMLObject: map.currentValue)
    }
    
    /// mappable object Set
    class func objectSet<N: XMLBaseMappable>(_ field: inout Set<N>, map: XMLMap) {
        if let objects = XMLMapper<N>().mapSet(XMLObject: map.currentValue) {
            field = objects
        }
    }
    
    /// optional mappable object array
    class func optionalObjectSet<N: XMLBaseMappable>(_ field: inout Set<N>?, map: XMLMap) {
        field = XMLMapper().mapSet(XMLObject: map.currentValue)
    }
    
    /// Implicitly unwrapped optional mappable object array
    class func optionalObjectSet<N: XMLBaseMappable>(_ field: inout Set<N>!, map: XMLMap) {
        field = XMLMapper().mapSet(XMLObject: map.currentValue)
    }	
}
