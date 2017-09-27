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
        testElement <- map["TestElementXMLMappable"]
    }
}

enum EnumTest: String {
    case theEnumValue = "enumValue"
}

class TestElementXMLMappable: XMLMappable {
    
    var testString: String?
    var testAttribute: EnumTest?
    var testList: [Element]?
    
    required init(map: XMLMap) {
        
    }
    
    func mapping(map: XMLMap) {
        testString <- map["testString"]
        testAttribute <- map.attributes["testAttribute"]
        testList <- map["testList.element"]
    }
}

class Element: XMLMappable {
    
    var testInt: Int?
    var testDouble: Float?
    
    required init(map: XMLMap) {
        
    }
    
    func mapping(map: XMLMap) {
        testInt <- map["testInt"]
        testDouble <- map["testDouble"]
    }
}
