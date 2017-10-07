//
//  XMLTransformType.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 14/09/2017.
//
//

public protocol XMLTransformType {
    associatedtype Object
    associatedtype XML
    
    func transformFromXML(_ value: Any?) -> Object?
    func transformToXML(_ value: Object?) -> XML?
}
