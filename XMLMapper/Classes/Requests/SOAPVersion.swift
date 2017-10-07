//
//  SOAPVersion.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 07/10/2017.
//

import Foundation

public enum SOAPVersion: String {
    case version1point1 = "v1.1"
    case version1point2 = "v1.2"
    
    var namespace: String {
        switch self {
        case .version1point1:
            return "http://schemas.xmlsoap.org/soap/envelope/"
        case .version1point2:
            return "http://www.w3.org/2003/05/soap-envelope/"
        }
    }
    
    var encodingStyle: String {
        switch self {
        case .version1point1:
            return "http://schemas.xmlsoap.org/soap/encoding/"
        case .version1point2:
            return "http://www.w3.org/2003/05/soap-encoding"
        }
    }
    
    var contentType: String {
        switch self {
        case .version1point1:
            return "text/xml; charset=\"utf-8\""
        case .version1point2:
            return "application/soap+xml;charset=UTF-8"
        }
    }
}
