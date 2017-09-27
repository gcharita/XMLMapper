//
//  XMLStringConvertibleOperators.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 27/09/2017.
//

import Foundation

// MARK: - Lossless String Convertible types

/// Object of Lossless String Convertible type
public func <- <T: LosslessStringConvertible>(left: inout T, right: XMLMap) {
    left <- (right, XMLStringConvertibleTransform())
}

public func >>> <T: LosslessStringConvertible>(left: T, right: XMLMap) {
    left >>> (right, XMLStringConvertibleTransform())
}


/// Optional Object of Lossless String Convertible type
public func <- <T: LosslessStringConvertible>(left: inout T?, right: XMLMap) {
    left <- (right, XMLStringConvertibleTransform())
}

public func >>> <T: LosslessStringConvertible>(left: T?, right: XMLMap) {
    left >>> (right, XMLStringConvertibleTransform())
}


/// Implicitly Unwrapped Optional Object of Lossless String Convertible
public func <- <T: LosslessStringConvertible>(left: inout T!, right: XMLMap) {
    left <- (right, XMLStringConvertibleTransform())
}

// MARK:- Arrays of Lossless String Convertible type

/// Array of Lossless String Convertible object
public func <- <T: LosslessStringConvertible>(left: inout [T], right: XMLMap) {
    left <- (right, XMLStringConvertibleTransform())
}

public func >>> <T: LosslessStringConvertible>(left: [T], right: XMLMap) {
    left >>> (right, XMLStringConvertibleTransform())
}


/// Array of Lossless String Convertible object
public func <- <T: LosslessStringConvertible>(left: inout [T]?, right: XMLMap) {
    left <- (right, XMLStringConvertibleTransform())
}

public func >>> <T: LosslessStringConvertible>(left: [T]?, right: XMLMap) {
    left >>> (right, XMLStringConvertibleTransform())
}


/// Array of Lossless String Convertible object
public func <- <T: LosslessStringConvertible>(left: inout [T]!, right: XMLMap) {
    left <- (right, XMLStringConvertibleTransform())
}

// MARK:- Dictionaries of Lossless String Convertible type

/// Dictionary of Lossless String Convertible object
public func <- <T: LosslessStringConvertible>(left: inout [String: T], right: XMLMap) {
    left <- (right, XMLStringConvertibleTransform())
}

public func >>> <T: LosslessStringConvertible>(left: [String: T], right: XMLMap) {
    left >>> (right, XMLStringConvertibleTransform())
}


/// Dictionary of Lossless String Convertible object
public func <- <T: LosslessStringConvertible>(left: inout [String: T]?, right: XMLMap) {
    left <- (right, XMLStringConvertibleTransform())
}

public func >>> <T: LosslessStringConvertible>(left: [String: T]?, right: XMLMap) {
    left >>> (right, XMLStringConvertibleTransform())
}


/// Dictionary of Lossless String Convertible object
public func <- <T: LosslessStringConvertible>(left: inout [String: T]!, right: XMLMap) {
    left <- (right, XMLStringConvertibleTransform())
}
