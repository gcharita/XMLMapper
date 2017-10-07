//
//  XMLDataTransform.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 15/09/2017.
//
//

import Foundation

open class XMLDataTransform: XMLTransformType {
    public typealias Object = Data
    public typealias XML = String
    
    public init() {}
    
    open func transformFromXML(_ value: Any?) -> Data? {
        guard let string = value as? String else{
            return nil
        }
        return Data(base64Encoded: string)
    }
    
    open func transformToXML(_ value: Data?) -> String? {
        guard let data = value else{
            return nil
        }
        return data.base64EncodedString()
    }
}
