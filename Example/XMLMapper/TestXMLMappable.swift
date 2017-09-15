//
//  TestXMLMappable.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 14/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import XMLMapper

class TestXMLMappable: XMLMappable {
    
    var testElement: TestElementXMLMappable!
    
    required init(map: XMLMap) {
        
    }
    
    func mapping(map: XMLMap) {
        testElement <<- map["TestElementXMLMappable"]
    }
    
    var elementName: String {
        return ""
    }
}

enum EnumTest: String {
    case theEnumValue = "enumValue"
}

class TestElementXMLMappable: XMLMappable {
    
    var testString: String?
    var testAttribute: EnumTest?
    
    required init(map: XMLMap) {
        
    }
    
    func mapping(map: XMLMap) {
        testString <<- map["testString"]
        testAttribute <<- map.attributes["testAttribute"]
    }
}
