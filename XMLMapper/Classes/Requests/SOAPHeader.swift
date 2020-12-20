//
//  SOAPHeader.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 02/10/2017.
//

import Foundation

public class SOAPHeader: XMLMappable {
    public var nodeName: String!
    
    var soapInformation: SOAPInformation?
    
    private var informationName: String?
    
    init(soapInformation: SOAPInformation) {
        self.informationName = soapInformation.informationName
        self.soapInformation = soapInformation
    }
    
    required public init?(map: XMLMap) {}
    
    public func mapping(map: XMLMap) {
        soapInformation <- map["m:\(informationName ?? "")"]
    }
}
