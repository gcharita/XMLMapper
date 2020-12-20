//
//  XMLTransformOperators.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 15/09/2017.
//
//

import Foundation

// MARK:- Transforms

/// Object of Basic type with Transform
public func <- <Transform: XMLTransformType>(left: inout Transform.Object, right: (XMLMap, Transform)) {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        let value = transform.transformFromXML(map.currentValue)
        FromXML.basicType(&left, object: value)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <Transform: XMLTransformType>(left: Transform.Object, right: (XMLMap, Transform)) {
    let (map, transform) = right
    if map.mappingType == .toXML {
        let value: Transform.XML? = transform.transformToXML(left)
        ToXML.optionalBasicType(value, map: map)
    }
}


/// Optional object of basic type with Transform
public func <- <Transform: XMLTransformType>(left: inout Transform.Object?, right: (XMLMap, Transform)) {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        let value = transform.transformFromXML(map.currentValue)
        FromXML.optionalBasicType(&left, object: value)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <Transform: XMLTransformType>(left: Transform.Object?, right: (XMLMap, Transform)) {
    let (map, transform) = right
    if map.mappingType == .toXML {
        let value: Transform.XML? = transform.transformToXML(left)
        ToXML.optionalBasicType(value, map: map)
    }
}


// Code targeting the Swift 4.1 compiler and below.
#if !(swift(>=4.1.50) || (swift(>=3.4) && !swift(>=4.0)))
/// Implicitly unwrapped optional object of basic type with Transform
public func <- <Transform: XMLTransformType>(left: inout Transform.Object!, right: (XMLMap, Transform)) {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        let value = transform.transformFromXML(map.currentValue)
        FromXML.optionalBasicType(&left, object: value)
    case .toXML:
        left >>> right
    default: ()
    }
}
#endif

/// Array of Basic type with Transform
public func <- <Transform: XMLTransformType>(left: inout [Transform.Object], right: (XMLMap, Transform)) {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        let values = fromXMLArrayWithTransform(map.currentValue, transform: transform)
        FromXML.basicType(&left, object: values)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <Transform: XMLTransformType>(left: [Transform.Object], right: (XMLMap, Transform)) {
    let (map, transform) = right
    if map.mappingType == .toXML{
        let values = toXMLArrayWithTransform(left, transform: transform)
        ToXML.optionalBasicType(values, map: map)
    }
}


/// Optional array of Basic type with Transform
public func <- <Transform: XMLTransformType>(left: inout [Transform.Object]?, right: (XMLMap, Transform)) {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        let values = fromXMLArrayWithTransform(map.currentValue, transform: transform)
        FromXML.optionalBasicType(&left, object: values)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <Transform: XMLTransformType>(left: [Transform.Object]?, right: (XMLMap, Transform)) {
    let (map, transform) = right
    if map.mappingType == .toXML {
        let values = toXMLArrayWithTransform(left, transform: transform)
        ToXML.optionalBasicType(values, map: map)
    }
}


// Code targeting the Swift 4.1 compiler and below.
#if !(swift(>=4.1.50) || (swift(>=3.4) && !swift(>=4.0)))
/// Implicitly unwrapped optional array of Basic type with Transform
public func <- <Transform: XMLTransformType>(left: inout [Transform.Object]!, right: (XMLMap, Transform)) {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        let values = fromXMLArrayWithTransform(map.currentValue, transform: transform)
        FromXML.optionalBasicType(&left, object: values)
    case .toXML:
        left >>> right
    default: ()
    }
}
#endif

/// Dictionary of Basic type with Transform
public func <- <Transform: XMLTransformType>(left: inout [String: Transform.Object], right: (XMLMap, Transform)) {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        let values = fromXMLDictionaryWithTransform(map.currentValue, transform: transform)
        FromXML.basicType(&left, object: values)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <Transform: XMLTransformType>(left: [String: Transform.Object], right: (XMLMap, Transform)) {
    let (map, transform) = right
    if map.mappingType == . toXML {
        let values = toXMLDictionaryWithTransform(left, transform: transform)
        ToXML.optionalBasicType(values, map: map)
    }
}


/// Optional dictionary of Basic type with Transform
public func <- <Transform: XMLTransformType>(left: inout [String: Transform.Object]?, right: (XMLMap, Transform)) {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        let values = fromXMLDictionaryWithTransform(map.currentValue, transform: transform)
        FromXML.optionalBasicType(&left, object: values)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <Transform: XMLTransformType>(left: [String: Transform.Object]?, right: (XMLMap, Transform)) {
    let (map, transform) = right
    if map.mappingType == .toXML {
        let values = toXMLDictionaryWithTransform(left, transform: transform)
        ToXML.optionalBasicType(values, map: map)
    }
}


// Code targeting the Swift 4.1 compiler and below.
#if !(swift(>=4.1.50) || (swift(>=3.4) && !swift(>=4.0)))
/// Implicitly unwrapped optional dictionary of Basic type with Transform
public func <- <Transform: XMLTransformType>(left: inout [String: Transform.Object]!, right: (XMLMap, Transform)) {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        let values = fromXMLDictionaryWithTransform(map.currentValue, transform: transform)
        FromXML.optionalBasicType(&left, object: values)
    case .toXML:
        left >>> right
    default: ()
    }
}
#endif

// MARK:- Transforms of Mappable Objects - <T: XMLBaseMappable>

/// Object conforming to Mappable that have transforms
public func <- <Transform: XMLTransformType>(left: inout Transform.Object, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        let value: Transform.Object? = transform.transformFromXML(map.currentValue)
        FromXML.basicType(&left, object: value)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <Transform: XMLTransformType>(left: Transform.Object, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    if map.mappingType == .toXML {
        let value: Transform.XML? = transform.transformToXML(left)
        ToXML.optionalBasicType(value, map: map)
    }
}


/// Optional Mappable objects that have transforms
public func <- <Transform: XMLTransformType>(left: inout Transform.Object?, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        let value: Transform.Object? = transform.transformFromXML(map.currentValue)
        FromXML.optionalBasicType(&left, object: value)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <Transform: XMLTransformType>(left: Transform.Object?, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    if map.mappingType == .toXML{
        let value: Transform.XML? = transform.transformToXML(left)
        ToXML.optionalBasicType(value, map: map)
    }
}


// Code targeting the Swift 4.1 compiler and below.
#if !(swift(>=4.1.50) || (swift(>=3.4) && !swift(>=4.0)))
/// Implicitly unwrapped optional Mappable objects that have transforms
public func <- <Transform: XMLTransformType>(left: inout Transform.Object!, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        let value: Transform.Object? = transform.transformFromXML(map.currentValue)
        FromXML.optionalBasicType(&left, object: value)
    case .toXML:
        left >>> right
    default: ()
    }
}
#endif


// MARK:- Dictionary of Mappable objects with a transform - Dictionary<String, T: XMLBaseMappable>

/// Dictionary of Mappable objects <String, T: XMLBaseMappable> with a transform
public func <- <Transform: XMLTransformType>(left: inout Dictionary<String, Transform.Object>, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    if map.mappingType == .fromXML && map.isKeyPresent,
        let object = map.currentValue as? [String: Any] {
        let value = fromXMLDictionaryWithTransform(object as Any?, transform: transform) ?? left
        FromXML.basicType(&left, object: value)
    } else if map.mappingType == .toXML {
        left >>> right
    }
}

public func >>> <Transform: XMLTransformType>(left: Dictionary<String, Transform.Object>, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    if map.mappingType == .toXML {
        let value = toXMLDictionaryWithTransform(left, transform: transform)
        ToXML.basicType(value, map: map)
    }
}


/// Optional Dictionary of Mappable object <String, T: XMLBaseMappable> with a transform
public func <- <Transform: XMLTransformType>(left: inout Dictionary<String, Transform.Object>?, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    if map.mappingType == .fromXML && map.isKeyPresent, let object = map.currentValue as? [String : Any]{
        let value = fromXMLDictionaryWithTransform(object as Any?, transform: transform) ?? left
        FromXML.optionalBasicType(&left, object: value)
    } else if map.mappingType == .toXML {
        left >>> right
    }
}

public func >>> <Transform: XMLTransformType>(left: Dictionary<String, Transform.Object>?, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    if map.mappingType == .toXML {
        let value = toXMLDictionaryWithTransform(left, transform: transform)
        ToXML.optionalBasicType(value, map: map)
    }
}


// Code targeting the Swift 4.1 compiler and below.
#if !(swift(>=4.1.50) || (swift(>=3.4) && !swift(>=4.0)))
/// Implicitly unwrapped Optional Dictionary of Mappable object <String, T: XMLBaseMappable> with a transform
public func <- <Transform: XMLTransformType>(left: inout Dictionary<String, Transform.Object>!, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    if map.mappingType == .fromXML && map.isKeyPresent, let dictionary = map.currentValue as? [String : Any]{
        let transformedDictionary = fromXMLDictionaryWithTransform(dictionary as Any?, transform: transform) ?? left
        FromXML.optionalBasicType(&left, object: transformedDictionary)
    } else if map.mappingType == .toXML {
        left >>> right
    }
}
#endif

/// Dictionary of Array of Mappable objects <String, [T: XMLBaseMappable]> with a transform
public func <- <Transform: XMLTransformType>(left: inout Dictionary<String, [Transform.Object]>, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    
    if let dictionary = map.currentValue as? [String : [Any]], map.mappingType == .fromXML && map.isKeyPresent {
        let transformedDictionary = dictionary.map { (arg: (key: String, values: [Any])) -> (String, [Transform.Object]) in
            let (key, values) = arg
            if let XMLArray = fromXMLArrayWithTransform(values, transform: transform) {
                return (key, XMLArray)
            }
            if let leftValue = left[key] {
                return (key, leftValue)
            }
            return (key, [])
        }
        
        FromXML.basicType(&left, object: transformedDictionary)
    } else if map.mappingType == .toXML {
        left >>> right
    }
}

public func >>> <Transform: XMLTransformType>(left: Dictionary<String, [Transform.Object]>, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    
    if map.mappingType == .toXML {
        let transformedDictionary = left.map { (arg: (key: String, value: [Transform.Object])) in
            return (arg.key, toXMLArrayWithTransform(arg.value, transform: transform) ?? [])
        }
        
        ToXML.basicType(transformedDictionary, map: map)
    }
}


/// Optional Dictionary of Array of Mappable object <String, [T: XMLBaseMappable]> with a transform
public func <- <Transform: XMLTransformType>(left: inout Dictionary<String, [Transform.Object]>?, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    
    if let dictionary = map.currentValue as? [String : [Any]], map.mappingType == .fromXML && map.isKeyPresent {
        
        let transformedDictionary = dictionary.map { (arg: (key: String, values: [Any])) -> (String, [Transform.Object]) in
            let (key, values) = arg
            if let XMLArray = fromXMLArrayWithTransform(values, transform: transform) {
                return (key, XMLArray)
            }
            if let leftValue = left?[key] {
                return (key, leftValue)
            }
            return (key, [])
        }
        
        FromXML.optionalBasicType(&left, object: transformedDictionary)
    } else if map.mappingType == .toXML {
        left >>> right
    }
}

public func >>> <Transform: XMLTransformType>(left: Dictionary<String, [Transform.Object]>?, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    
    if map.mappingType == .toXML {
        let transformedDictionary = left?.map { (arg: (key: String, values: [Transform.Object])) in
            return (arg.key, toXMLArrayWithTransform(arg.values, transform: transform) ?? [])
        }
        
        ToXML.optionalBasicType(transformedDictionary, map: map)
    }
}


// Code targeting the Swift 4.1 compiler and below.
#if !(swift(>=4.1.50) || (swift(>=3.4) && !swift(>=4.0)))
/// Implicitly unwrapped Optional Dictionary of Array of Mappable object <String, [T: XMLBaseMappable]> with a transform
public func <- <Transform: XMLTransformType>(left: inout Dictionary<String, [Transform.Object]>!, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right

    if let dictionary = map.currentValue as? [String : [Any]], map.mappingType == .fromXML && map.isKeyPresent {
        let transformedDictionary = dictionary.map { (arg: (key: String, values: [Any])) -> (String, [Transform.Object]) in
            let (key, values) = arg
            if let XMLArray = fromXMLArrayWithTransform(values, transform: transform) {
                return (key, XMLArray)
            }
            if let leftValue = left?[key] {
                return (key, leftValue)
            }
            return (key, [])
        }
        FromXML.optionalBasicType(&left, object: transformedDictionary)
    } else if map.mappingType == .toXML {
        left >>> right
    }
}
#endif

// MARK:- Array of Mappable objects with transforms - Array<T: XMLBaseMappable>

/// Array of Mappable objects
public func <- <Transform: XMLTransformType>(left: inout Array<Transform.Object>, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        if let transformedValues = fromXMLArrayWithTransform(map.currentValue, transform: transform) {
            FromXML.basicType(&left, object: transformedValues)
        }
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <Transform: XMLTransformType>(left: Array<Transform.Object>, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    if map.mappingType == .toXML {
        let transformedValues = toXMLArrayWithTransform(left, transform: transform)
        ToXML.optionalBasicType(transformedValues, map: map)
    }
}


/// Optional array of Mappable objects
public func <- <Transform: XMLTransformType>(left: inout Array<Transform.Object>?, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        let transformedValues = fromXMLArrayWithTransform(map.currentValue, transform: transform)
        FromXML.optionalBasicType(&left, object: transformedValues)
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <Transform: XMLTransformType>(left: Array<Transform.Object>?, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    if map.mappingType == .toXML {
        let transformedValues = toXMLArrayWithTransform(left, transform: transform)
        ToXML.optionalBasicType(transformedValues, map: map)
    }
}


// Code targeting the Swift 4.1 compiler and below.
#if !(swift(>=4.1.50) || (swift(>=3.4) && !swift(>=4.0)))
/// Implicitly unwrapped Optional array of Mappable objects
public func <- <Transform: XMLTransformType>(left: inout Array<Transform.Object>!, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        let transformedValues = fromXMLArrayWithTransform(map.currentValue, transform: transform)
        FromXML.optionalBasicType(&left, object: transformedValues)
    case .toXML:
        left >>> right
    default: ()
    }
}
#endif

// MARK:- Array of Array of objects - Array<Array<T>>> with transforms

/// Array of Array of objects with transform
public func <- <Transform: XMLTransformType>(left: inout [[Transform.Object]], right: (XMLMap, Transform)) {
    let (map, transform) = right
    switch map.mappingType {
    case .toXML:
        left >>> right
    case .fromXML where map.isKeyPresent:
        guard let original2DArray = map.currentValue as? [[Any]] else { break }
        let transformed2DArray = original2DArray.compactMap { values in
            fromXMLArrayWithTransform(values as Any?, transform: transform)
        }
        FromXML.basicType(&left, object: transformed2DArray)
    default:
        break
    }
}

public func >>> <Transform: XMLTransformType>(left: [[Transform.Object]], right: (XMLMap, Transform)) {
    let (map, transform) = right
    if map.mappingType == .toXML{
        let transformed2DArray = left.compactMap { values in
            toXMLArrayWithTransform(values, transform: transform)
        }
        ToXML.basicType(transformed2DArray, map: map)
    }
}

/// Optional array of array of objects with transform
public func <- <Transform: XMLTransformType>(left: inout [[Transform.Object]]?, right: (XMLMap, Transform)) {
    let (map, transform) = right
    switch map.mappingType {
    case .toXML:
        left >>> right
    case .fromXML where map.isKeyPresent:
        guard let original2DArray = map.currentValue as? [[Any]] else { break }
        let transformed2DArray = original2DArray.compactMap { values in
            fromXMLArrayWithTransform(values as Any?, transform: transform)
        }
        FromXML.optionalBasicType(&left, object: transformed2DArray)
    default:
        break
    }
}

public func >>> <Transform: XMLTransformType>(left: [[Transform.Object]]?, right: (XMLMap, Transform)) {
    let (map, transform) = right
    if map.mappingType == .toXML {
        let transformed2DArray = left?.compactMap { values in
            toXMLArrayWithTransform(values, transform: transform)
        }
        ToXML.optionalBasicType(transformed2DArray, map: map)
    }
}


// Code targeting the Swift 4.1 compiler and below.
#if !(swift(>=4.1.50) || (swift(>=3.4) && !swift(>=4.0)))
/// Implicitly unwrapped Optional array of array of objects with transform
public func <- <Transform: XMLTransformType>(left: inout [[Transform.Object]]!, right: (XMLMap, Transform)) {
    let (map, transform) = right
    switch map.mappingType {
    case .toXML:
        left >>> right
    case .fromXML where map.isKeyPresent:
        guard let original2DArray = map.currentValue as? [[Any]] else { break }
        let transformed2DArray = original2DArray.compactMap { values in
            fromXMLArrayWithTransform(values as Any?, transform: transform)
        }
        FromXML.optionalBasicType(&left, object: transformed2DArray)
    default:
        break
    }
}
#endif

// MARK:- Set of Mappable objects with a transform - Set<T: XMLBaseMappable where T: Hashable>

/// Set of Mappable objects with transform
public func <- <Transform: XMLTransformType>(left: inout Set<Transform.Object>, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        if let transformedValues = fromXMLArrayWithTransform(map.currentValue, transform: transform) {
            FromXML.basicType(&left, object: Set(transformedValues))
        }
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <Transform: XMLTransformType>(left: Set<Transform.Object>, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    if map.mappingType == .toXML {
        let transformedValues = toXMLArrayWithTransform(Array(left), transform: transform)
        ToXML.optionalBasicType(transformedValues, map: map)
    }
}


/// Optional Set of Mappable objects with transform
public func <- <Transform: XMLTransformType>(left: inout Set<Transform.Object>?, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        if let transformedValues = fromXMLArrayWithTransform(map.currentValue, transform: transform) {
            FromXML.basicType(&left, object: Set(transformedValues))
        }
    case .toXML:
        left >>> right
    default: ()
    }
}

public func >>> <Transform: XMLTransformType>(left: Set<Transform.Object>?, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    if map.mappingType == .toXML {
        if let values = left {
            let transformedValues = toXMLArrayWithTransform(Array(values), transform: transform)
            ToXML.optionalBasicType(transformedValues, map: map)
        }
    }
}


// Code targeting the Swift 4.1 compiler and below.
#if !(swift(>=4.1.50) || (swift(>=3.4) && !swift(>=4.0)))
/// Implicitly unwrapped Optional set of Mappable objects with transform
public func <- <Transform: XMLTransformType>(left: inout Set<Transform.Object>!, right: (XMLMap, Transform)) where Transform.Object: XMLBaseMappable {
    let (map, transform) = right
    switch map.mappingType {
    case .fromXML where map.isKeyPresent:
        if let transformedValues = fromXMLArrayWithTransform(map.currentValue, transform: transform) {
            FromXML.basicType(&left, object: Set(transformedValues))
        }
    case .toXML:
        left >>> right
    default: ()
    }
}
#endif


private func fromXMLArrayWithTransform<Transform: XMLTransformType>(_ input: Any?, transform: Transform) -> [Transform.Object]? {
    if let values = input as? [Any] {
        return values.compactMap { value in
            return transform.transformFromXML(value)
        }
    } else if let value = transform.transformFromXML(input) {
        return [value]
    } else {
        return nil
    }
}

private func fromXMLDictionaryWithTransform<Transform: XMLTransformType>(_ input: Any?, transform: Transform) -> [String: Transform.Object]? {
    if let values = input as? [String: Any] {
        return values.filterMap { value in
            return transform.transformFromXML(value)
        }
    } else {
        return nil
    }
}

private func toXMLArrayWithTransform<Transform: XMLTransformType>(_ input: [Transform.Object]?, transform: Transform) -> [Transform.XML]? {
    return input?.compactMap { value in
        return transform.transformToXML(value)
    }
}

private func toXMLDictionaryWithTransform<Transform: XMLTransformType>(_ input: [String: Transform.Object]?, transform: Transform) -> [String: Transform.XML]? {
    return input?.filterMap { value in
        return transform.transformToXML(value)
    }
}
