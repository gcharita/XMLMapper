//
//  XMLMappableExtensionsTests.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 09/04/2018.
//

import XCTest
import XMLMapper

struct TestXMLMappable: XMLMappable, Equatable, Hashable {
    var nodeName: String!
    
    static let valueForString = "This string should work"
    static let workingXMLString = "<root><value>\(valueForString)</value></root>"
    static let workingXML: [String: Any] = ["value": valueForString]
    static let workingXMLArrayString = "\(workingXMLString)"
    
    var value: String?
    
    init() {}
    init?(map: XMLMap) {    }
    
    mutating func mapping(map: XMLMap) {
        value <- map["value"]
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

func ==(lhs: TestXMLMappable, rhs: TestXMLMappable) -> Bool {
    return lhs.value == rhs.value
}

class XMLMappableExtensionsTests: XCTestCase {
    
    var testMappable: TestXMLMappable!
    
    override func setUp() {
        super.setUp()
        testMappable = TestXMLMappable()
        testMappable.value = TestXMLMappable.valueForString
    }
    
    func testInitFromString() {
        let mapped = TestXMLMappable(XMLString: TestXMLMappable.workingXMLString)
        
        XCTAssertNotNil(mapped)
        XCTAssertEqual(mapped?.value, TestXMLMappable.valueForString)
    }
    
    func testToXMLAndBack() {
        let mapped = TestXMLMappable(XML: testMappable.toXML())
        XCTAssertEqual(mapped, testMappable)
    }
    
    func testArrayFromString() {
        let mapped = [TestXMLMappable](XMLString: TestXMLMappable.workingXMLArrayString)!
        XCTAssertEqual(mapped, [testMappable])
    }
    
    func testArrayToXMLAndBack() {
        let mapped = [TestXMLMappable](XMLArray: [testMappable].toXML())
        XCTAssertEqual(mapped, [testMappable])
    }
    
    func testSetInitFailsWithEmptyString() {
        XCTAssertNil(Set<TestXMLMappable>(XMLString: ""))
    }
    
    func testSetFromString() {
        let mapped = Set<TestXMLMappable>(XMLString: TestXMLMappable.workingXMLArrayString)!
        XCTAssertEqual(mapped, Set<TestXMLMappable>([testMappable]))
    }
    
    func testSetToXMLAndBack() {
        let mapped = Set<TestXMLMappable>(XMLArray: Set([testMappable]).toXML())
        XCTAssertEqual(mapped, [testMappable])
    }
    
}
