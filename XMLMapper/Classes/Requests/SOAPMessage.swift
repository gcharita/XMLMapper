//
//  SOAPMessage.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 02/10/2017.
//

import Foundation

open class SOAPMessage: XMLMappable {
    public var nodeName: String!
    
    private var xmlnsMessage: String?
    var soapAction: String?
    
    public init(soapAction: String, nameSpace: String) {
        self.soapAction = soapAction
        self.xmlnsMessage = nameSpace
    }
    
    required public init?(map: XMLMap) {}
    
    open func mapping(map: XMLMap) {
        xmlnsMessage <- map.attributes["xmlns:m"]
    }
}
