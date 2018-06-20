//
//  XMLEnumOperators.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 15/09/2017.
//
//

import Foundation


// MARK:- Raw Representable types

/// Object of Raw Representable type
public func <- <T: RawRepresentable>(left: inout T, right: XMLMap) where T.RawValue: LosslessStringConvertible {
    left <- (right, XMLEnumTransform())
}

public func >>> <T: RawRepresentable>(left: T, right: XMLMap) where T.RawValue: LosslessStringConvertible {
    left >>> (right, XMLEnumTransform())
}


/// Optional Object of Raw Representable type
public func <- <T: RawRepresentable>(left: inout T?, right: XMLMap) where T.RawValue: LosslessStringConvertible {
    left <- (right, XMLEnumTransform())
}

public func >>> <T: RawRepresentable>(left: T?, right: XMLMap) where T.RawValue: LosslessStringConvertible {
    left >>> (right, XMLEnumTransform())
}


// Code targeting the Swift 4.1 compiler and below.
#if !(swift(>=4.1.50) || (swift(>=3.4) && !swift(>=4.0)))
/// Implicitly Unwrapped Optional Object of Raw Representable type
public func <- <T: RawRepresentable>(left: inout T!, right: XMLMap) where T.RawValue: LosslessStringConvertible {
    left <- (right, XMLEnumTransform())
}
#endif

// MARK:- Arrays of Raw Representable type

/// Array of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [T], right: XMLMap) where T.RawValue: LosslessStringConvertible {
    left <- (right, XMLEnumTransform())
}

public func >>> <T: RawRepresentable>(left: [T], right: XMLMap) where T.RawValue: LosslessStringConvertible {
    left >>> (right, XMLEnumTransform())
}


/// Array of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [T]?, right: XMLMap) where T.RawValue: LosslessStringConvertible {
    left <- (right, XMLEnumTransform())
}

public func >>> <T: RawRepresentable>(left: [T]?, right: XMLMap) where T.RawValue: LosslessStringConvertible {
    left >>> (right, XMLEnumTransform())
}


// Code targeting the Swift 4.1 compiler and below.
#if !(swift(>=4.1.50) || (swift(>=3.4) && !swift(>=4.0)))
/// Array of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [T]!, right: XMLMap) where T.RawValue: LosslessStringConvertible {
    left <- (right, XMLEnumTransform())
}
#endif

// MARK:- Dictionaries of Raw Representable type

/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [String: T], right: XMLMap) where T.RawValue: LosslessStringConvertible {
    left <- (right, XMLEnumTransform())
}

public func >>> <T: RawRepresentable>(left: [String: T], right: XMLMap) where T.RawValue: LosslessStringConvertible {
    left >>> (right, XMLEnumTransform())
}


/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [String: T]?, right: XMLMap) where T.RawValue: LosslessStringConvertible {
    left <- (right, XMLEnumTransform())
}

public func >>> <T: RawRepresentable>(left: [String: T]?, right: XMLMap) where T.RawValue: LosslessStringConvertible {
    left >>> (right, XMLEnumTransform())
}


// Code targeting the Swift 4.1 compiler and below.
#if !(swift(>=4.1.50) || (swift(>=3.4) && !swift(>=4.0)))
/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [String: T]!, right: XMLMap) where T.RawValue: LosslessStringConvertible {
    left <- (right, XMLEnumTransform())
}
#endif
