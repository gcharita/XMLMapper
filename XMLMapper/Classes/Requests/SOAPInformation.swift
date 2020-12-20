//
//  SOAPInformation.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 02/10/2017.
//

import Foundation

open class SOAPInformation: XMLMappable {
    public var nodeName: String!
    
    private var xmlnsInformation: String?
    var informationName: String?
    
    public init(informationName: String, nameSpace: String) {
        self.informationName = informationName
        self.xmlnsInformation = nameSpace
    }
    
    required public init?(map: XMLMap) {}
    
    open func mapping(map: XMLMap) {
        xmlnsInformation <- map.attributes["xmlns:m"]
    }
}
