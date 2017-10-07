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
public func <- <T: RawRepresentable>(left: inout T, right: XMLMap) {
    left <- (right, XMLEnumTransform())
}

public func >>> <T: RawRepresentable>(left: T, right: XMLMap) {
    left >>> (right, XMLEnumTransform())
}


/// Optional Object of Raw Representable type
public func <- <T: RawRepresentable>(left: inout T?, right: XMLMap) {
    left <- (right, XMLEnumTransform())
}

public func >>> <T: RawRepresentable>(left: T?, right: XMLMap) {
    left >>> (right, XMLEnumTransform())
}


/// Implicitly Unwrapped Optional Object of Raw Representable type
public func <- <T: RawRepresentable>(left: inout T!, right: XMLMap) {
    left <- (right, XMLEnumTransform())
}

// MARK:- Arrays of Raw Representable type

/// Array of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [T], right: XMLMap) {
    left <- (right, XMLEnumTransform())
}

public func >>> <T: RawRepresentable>(left: [T], right: XMLMap) {
    left >>> (right, XMLEnumTransform())
}


/// Array of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [T]?, right: XMLMap) {
    left <- (right, XMLEnumTransform())
}

public func >>> <T: RawRepresentable>(left: [T]?, right: XMLMap) {
    left >>> (right, XMLEnumTransform())
}


/// Array of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [T]!, right: XMLMap) {
    left <- (right, XMLEnumTransform())
}

// MARK:- Dictionaries of Raw Representable type

/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [String: T], right: XMLMap) {
    left <- (right, XMLEnumTransform())
}

public func >>> <T: RawRepresentable>(left: [String: T], right: XMLMap) {
    left >>> (right, XMLEnumTransform())
}


/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [String: T]?, right: XMLMap) {
    left <- (right, XMLEnumTransform())
}

public func >>> <T: RawRepresentable>(left: [String: T]?, right: XMLMap) {
    left >>> (right, XMLEnumTransform())
}


/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable>(left: inout [String: T]!, right: XMLMap) {
    left <- (right, XMLEnumTransform())
}
