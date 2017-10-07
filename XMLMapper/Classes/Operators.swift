//
//  Operators.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

/// Operator used for defining mappings to and from XML
infix operator <-

/// Operator used to define mappings to XML
infix operator >>>

// MARK:- Objects with Basic types

/// Object of Basic type
public func <- <T>(left: inout T, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.basicType(&left, object: right.value())
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <T>(left: T, right: XMLMap) {
    if right.mappingType == .toXML {
        ToXML.basicType(left, map: right)
    }
}


/// Optional object of basic type
public func <- <T>(left: inout T?, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.optionalBasicType(&left, object: right.value())
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <T>(left: T?, right: XMLMap) {
    if right.mappingType == .toXML {
        ToXML.optionalBasicType(left, map: right)
    }
}


/// Implicitly unwrapped optional object of basic type
public func <- <T>(left: inout T!, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.optionalBasicType(&left, object: right.value())
    case .toXML:
        left >>> right
    default: ()
    }
}

// MARK:- Mappable Objects - <T: XMLBaseMappable>

/// Object conforming to Mappable
public func <- <T: XMLBaseMappable>(left: inout T, right: XMLMap) {
    switch right.mappingType {
    case .fromXML:
        FromXML.object(&left, map: right)
    case .toXML:
        left >>> right
    }
}

public func >>> <T: XMLBaseMappable>(left: T, right: XMLMap) {
    if right.mappingType == .toXML {
        ToXML.object(left, map: right)
    }
}


/// Optional Mappable objects
public func <- <T: XMLBaseMappable>(left: inout T?, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.optionalObject(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <T: XMLBaseMappable>(left: T?, right: XMLMap) {
    if right.mappingType == .toXML {
        ToXML.optionalObject(left, map: right)
    }
}


/// Implicitly unwrapped optional Mappable objects
public func <- <T: XMLBaseMappable>(left: inout T!, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.optionalObject(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

// MARK:- Dictionary of Mappable objects - Dictionary<String, T: XMLBaseMappable>

/// Dictionary of Mappable objects <String, T: Mappable>
public func <- <T: XMLBaseMappable>(left: inout Dictionary<String, T>, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.objectDictionary(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <T: XMLBaseMappable>(left: Dictionary<String, T>, right: XMLMap) {
    if right.mappingType == .toXML {
        ToXML.objectDictionary(left, map: right)
    }
}


/// Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: XMLBaseMappable>(left: inout Dictionary<String, T>?, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.optionalObjectDictionary(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <T: XMLBaseMappable>(left: Dictionary<String, T>?, right: XMLMap) {
    if right.mappingType == .toXML {
        ToXML.optionalObjectDictionary(left, map: right)
    }
}


/// Implicitly unwrapped Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: XMLBaseMappable>(left: inout Dictionary<String, T>!, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.optionalObjectDictionary(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

/// Dictionary of Mappable objects <String, T: Mappable>
public func <- <T: XMLBaseMappable>(left: inout Dictionary<String, [T]>, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.objectDictionaryOfArrays(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <T: XMLBaseMappable>(left: Dictionary<String, [T]>, right: XMLMap) {
    if right.mappingType == .toXML {
        ToXML.objectDictionaryOfArrays(left, map: right)
    }
}

/// Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: XMLBaseMappable>(left: inout Dictionary<String, [T]>?, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.optionalObjectDictionaryOfArrays(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <T: XMLBaseMappable>(left: Dictionary<String, [T]>?, right: XMLMap) {
    if right.mappingType == .toXML {
        ToXML.optionalObjectDictionaryOfArrays(left, map: right)
    }
}


/// Implicitly unwrapped Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: XMLBaseMappable>(left: inout Dictionary<String, [T]>!, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.optionalObjectDictionaryOfArrays(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

// MARK:- Array of Mappable objects - Array<T: XMLBaseMappable>

/// Array of Mappable objects
public func <- <T: XMLBaseMappable>(left: inout Array<T>, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.objectArray(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <T: XMLBaseMappable>(left: Array<T>, right: XMLMap) {
    if right.mappingType == .toXML {
        ToXML.objectArray(left, map: right)
    }
}

/// Optional array of Mappable objects
public func <- <T: XMLBaseMappable>(left: inout Array<T>?, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.optionalObjectArray(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <T: XMLBaseMappable>(left: Array<T>?, right: XMLMap) {
    if right.mappingType == .toXML {
        ToXML.optionalObjectArray(left, map: right)
    }
}


/// Implicitly unwrapped Optional array of Mappable objects
public func <- <T: XMLBaseMappable>(left: inout Array<T>!, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.optionalObjectArray(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

// MARK:- Array of Array of Mappable objects - Array<Array<T: XMLBaseMappable>>

/// Array of Array Mappable objects
public func <- <T: XMLBaseMappable>(left: inout Array<Array<T>>, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.twoDimensionalObjectArray(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <T: XMLBaseMappable>(left: Array<Array<T>>, right: XMLMap) {
    if right.mappingType == .toXML {
        ToXML.twoDimensionalObjectArray(left, map: right)
    }
}


/// Optional array of Mappable objects
public func <- <T: XMLBaseMappable>(left:inout Array<Array<T>>?, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.optionalTwoDimensionalObjectArray(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <T: XMLBaseMappable>(left: Array<Array<T>>?, right: XMLMap) {
    if right.mappingType == .toXML {
        ToXML.optionalTwoDimensionalObjectArray(left, map: right)
    }
}


/// Implicitly unwrapped Optional array of Mappable objects
public func <- <T: XMLBaseMappable>(left: inout Array<Array<T>>!, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.optionalTwoDimensionalObjectArray(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

// MARK:- Set of Mappable objects - Set<T: XMLBaseMappable>

/// Set of Mappable objects
public func <- <T: XMLBaseMappable>(left: inout Set<T>, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.objectSet(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <T: XMLBaseMappable>(left: Set<T>, right: XMLMap) {
    if right.mappingType == .toXML {
        ToXML.objectSet(left, map: right)
    }
}


/// Optional Set of Mappable objects
public func <- <T: XMLBaseMappable>(left: inout Set<T>?, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.optionalObjectSet(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <T: XMLBaseMappable>(left: Set<T>?, right: XMLMap) {
    if right.mappingType == .toXML {
        ToXML.optionalObjectSet(left, map: right)
    }
}


/// Implicitly unwrapped Optional Set of Mappable objects
public func <- <T: XMLBaseMappable>(left: inout Set<T>!, right: XMLMap) {
    switch right.mappingType {
    case .fromXML where right.isKeyPresent:
        FromXML.optionalObjectSet(&left, map: right)
    case .toXML:
        left >>> right
    default: ()
    }
}
