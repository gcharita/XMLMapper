//
//  GenericObjectsTests.swift
//  XMLMapperTests
//
//  Created by Giorgos Charitakis on 07/04/2018.
//

import XCTest
import XMLMapper

class GenericObjectsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSubclass() {
        let object = Subclass()
        object.base = "base var"
        object.sub = "sub var"
        
        let XML = XMLMapper().toXML(object)
        let parsedObject = XMLMapper<Subclass>().map(XML: XML)
        
        XCTAssertEqual(object.base, parsedObject?.base)
        XCTAssertEqual(object.sub, parsedObject?.sub)
    }
    
    func testGenericSubclass() {
        let object = GenericSubclass<String>()
        object.base = "base var"
        object.sub = "sub var"
        
        let XML = XMLMapper().toXML(object)
        let parsedObject = XMLMapper<GenericSubclass<String>>().map(XML: XML)
        
        XCTAssertEqual(object.base, parsedObject?.base)
        XCTAssertEqual(object.sub, parsedObject?.sub)
    }
    
    func testSubclassWithGenericArrayInSuperclass() {
        let XMLString = "<root><genericItems><value>value0</value></genericItems><genericItems><value>value1</value></genericItems></root>"
        
        let parsedObject = XMLMapper<SubclassWithGenericArrayInSuperclass<AnyObject>>().map(XMLString: XMLString)
        
        let genericItems = parsedObject?.genericItems
        
        XCTAssertNotNil(genericItems)
        XCTAssertEqual(genericItems?[0].value, "value0")
        XCTAssertEqual(genericItems?[1].value, "value1")
    }
    
    
    func testMappingAGenericObject(){
        let code: Int = 22
        let XMLString = "<root><result><code>\(code)</code></result></root>"
        
        let response = XMLMapper<Response<Status>>().map(XMLString: XMLString)
        
        let status = response?.result?.status
        
        XCTAssertNotNil(status)
        XCTAssertEqual(status, code)
    }
    
    
    func testMappingAGenericObjectViaMappableExtension(){
        let code: Int = 22
        let XMLString = "<root><result><code>\(code)</code></result></root>"
        
        let response = Response<Status>(XMLString: XMLString)
        
        let status = response?.result?.status
        
        XCTAssertNotNil(status)
        XCTAssertEqual(status, code)
    }
    
}

class Base: XMLMappable {
    var nodeName: String!
    
    var base: String?
    
    init(){
        
    }
    
    required init(map: XMLMap){
        
    }
    
    func mapping(map: XMLMap) {
        base <- map["base"]
    }
}

class Subclass: Base {

    var sub: String?

    override init(){
        super.init()
    }

    required init(map: XMLMap){
        super.init(map: map)
    }

    override func mapping(map: XMLMap) {
        super.mapping(map: map)

        sub <- map["sub"]
    }
}


class GenericSubclass<T>: Base {

    var sub: String?

    override init(){
        super.init()
    }

    required init(map: XMLMap){
        super.init(map: map)
    }

    override func mapping(map: XMLMap) {
        super.mapping(map: map)

        sub <- map["sub"]
    }
}

class WithGenericArray<T: XMLMappable>: XMLMappable {
    var nodeName: String!

    var genericItems: [T]?

    required init(map: XMLMap){

    }

    func mapping(map: XMLMap) {
        genericItems <- map["genericItems"]
    }
}

class ConcreteItem: XMLMappable {
    var nodeName: String!

    var value: String?

    required init(map: XMLMap){

    }

    func mapping(map: XMLMap) {
        value <- map["value"]
    }
}

class SubclassWithGenericArrayInSuperclass<Unused>: WithGenericArray<ConcreteItem> {
    required init(map: XMLMap){
        super.init(map: map)
    }
}

class Response<T: XMLMappable>: XMLMappable {
    var nodeName: String!

    var result: T?

    required init(map: XMLMap){

    }

    func mapping(map: XMLMap) {
        result <- map["result"]
    }
}

