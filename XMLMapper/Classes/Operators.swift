//
//  Operators.swift
//  Pods
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

import Foundation

// MARK:- Objects with Basic types

/// Object of Basic type
func <= <T>(left: inout T, right: XMLMap) {
    switch right.mappingType {
    case .fromXML:
        left = right.value()
    case .toXML:
        break
    //        left >>> right
    default: ()
    }
}


/// Optional object of basic type
func <= <T>(left: inout T?, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.optionalBasicType(&left, object: right.value())
    case .toJSON:
        left >>> right
    default: ()
    }
}


/// Implicitly unwrapped optional object of basic type
func <= <T>(left: inout T!, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.optionalBasicType(&left, object: right.value())
    case .toJSON:
        left >>> right
    default: ()
    }
}

// MARK:- Mappable Objects - <T: XMLMappable>

/// Object conforming to Mappable
func <= <T: XMLMappable>(left: inout T, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON:
        FromJSON.object(&left, map: right)
    case .toJSON:
        left >>> right
    }
}


/// Optional Mappable objects
func <= <T: XMLMappable>(left: inout T?, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.optionalObject(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}


/// Implicitly unwrapped optional Mappable objects
func <= <T: XMLMappable>(left: inout T!, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.optionalObject(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}

// MARK:- Dictionary of Mappable objects - Dictionary<String, T: XMLMappable>

/// Dictionary of Mappable objects <String, T: Mappable>
func <= <T: XMLMappable>(left: inout Dictionary<String, T>, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.objectDictionary(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}


/// Optional Dictionary of Mappable object <String, T: Mappable>
func <= <T: XMLMappable>(left: inout Dictionary<String, T>?, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.optionalObjectDictionary(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}


/// Implicitly unwrapped Optional Dictionary of Mappable object <String, T: Mappable>
func <= <T: XMLMappable>(left: inout Dictionary<String, T>!, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.optionalObjectDictionary(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}

/// Dictionary of Mappable objects <String, T: Mappable>
func <= <T: XMLMappable>(left: inout Dictionary<String, [T]>, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.objectDictionaryOfArrays(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}

/// Optional Dictionary of Mappable object <String, T: Mappable>
func <= <T: XMLMappable>(left: inout Dictionary<String, [T]>?, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.optionalObjectDictionaryOfArrays(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}


/// Implicitly unwrapped Optional Dictionary of Mappable object <String, T: Mappable>
func <= <T: XMLMappable>(left: inout Dictionary<String, [T]>!, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.optionalObjectDictionaryOfArrays(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}

// MARK:- Array of Mappable objects - Array<T: XMLMappable>

/// Array of Mappable objects
func <= <T: XMLMappable>(left: inout Array<T>, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.objectArray(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}

/// Optional array of Mappable objects
func <= <T: XMLMappable>(left: inout Array<T>?, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.optionalObjectArray(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}


/// Implicitly unwrapped Optional array of Mappable objects
func <= <T: XMLMappable>(left: inout Array<T>!, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.optionalObjectArray(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}

// MARK:- Array of Array of Mappable objects - Array<Array<T: XMLMappable>>

/// Array of Array Mappable objects
func <= <T: XMLMappable>(left: inout Array<Array<T>>, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.twoDimensionalObjectArray(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}


/// Optional array of Mappable objects
func <= <T: XMLMappable>(left:inout Array<Array<T>>?, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.optionalTwoDimensionalObjectArray(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}


/// Implicitly unwrapped Optional array of Mappable objects
func <= <T: XMLMappable>(left: inout Array<Array<T>>!, right: XMLMap) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.optionalTwoDimensionalObjectArray(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}

// MARK:- Set of Mappable objects - Set<T: XMLMappable where T: Hashable>

/// Set of Mappable objects
func <= <T: XMLMappable>(left: inout Set<T>, right: Map) where T: Hashable {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.objectSet(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}


/// Optional Set of Mappable objects
func <= <T: XMLMappable>(left: inout Set<T>?, right: Map) where T: Hashable, T: Hashable {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.optionalObjectSet(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}


/// Implicitly unwrapped Optional Set of Mappable objects
func <= <T: XMLMappable>(left: inout Set<T>!, right: Map) where T: Hashable {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        FromJSON.optionalObjectSet(&left, map: right)
    case .toJSON:
        left >>> right
    default: ()
    }
}



