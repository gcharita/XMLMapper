//
//  XMLSerialization+Error.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 21/10/2017.
//

import Foundation

extension XMLSerialization {
    public enum XMLSerializationError: String, Error {
        case invalidXMLDocument = "Invalid XML document"
        case invalidFoundationObject = "Invalid Foundation object"
        case invalidData = "Invalid data"
        
        var localizedDescription: String {
            return rawValue
        }
    }
}
