//
//  SOAPBody.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 02/10/2017.
//

import Foundation

public class SOAPBody: XMLMappable {
    public var nodeName: String!
    
    var soapMessage: SOAPMessage?
    
    private var soapAction: String?
    
    init(soapMessage: SOAPMessage) {
        self.soapAction = soapMessage.soapAction
        self.soapMessage = soapMessage
    }
    
    required public init?(map: XMLMap) {}
    
    public func mapping(map: XMLMap) {
        soapMessage <- map["m:\(soapAction ?? "")"]
    }
}
