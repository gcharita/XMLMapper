//
//  XMLDictionaryTransformTests.swift
//  XMLMapperTests
//
//  Created by Giorgos Charitakis on 18/02/2018.
//

import Foundation
import XCTest
import XMLMapper

class XMLDictionaryTransformTests: XCTestCase {
	
	func testDictionaryTransform() {
		
		let XML = "<root><dictionary><one><foo>uno</foo><bar>1</bar></one><two><foo>dve</foo><bar>2</bar></two><foobar><foo>bar</foo><bar>777</bar></foobar></dictionary></root>"
		
		guard let result = DictionaryTransformTestsObject(XMLString: XML) else {
			
			XCTFail("Unable to parse the XML")
			return
		}
		
		XCTAssertEqual(result.dictionary.count, 3)
		
		XCTAssertEqual(result.dictionary[.one]?.foo, "uno")
		XCTAssertEqual(result.dictionary[.one]?.bar, 1)
		
		XCTAssertEqual(result.dictionary[.two]?.foo, "dve")
		XCTAssertEqual(result.dictionary[.two]?.bar, 2)
		
		XCTAssertEqual(result.dictionary[.foobar]?.foo, "bar")
		XCTAssertEqual(result.dictionary[.foobar]?.bar, 777)
	}
}

class DictionaryTransformTestsObject: XMLMappable {
    var nodeName: String!
	
	var dictionary: [MyKey: MyValue] = [:]
	
	required init?(map: XMLMap) {

		
	}
	
	func mapping(map: XMLMap) {
		
		self.dictionary <- (map["dictionary"], XMLDictionaryTransform<MyKey, MyValue>())
	}
}

extension DictionaryTransformTestsObject {
	
	enum MyKey: String {
		case one = "one"
		case two = "two"
		case foobar = "foobar"
	}
}

extension DictionaryTransformTestsObject {
	
    class MyValue: XMLMappable {
        var nodeName: String!
		
		var foo: String
		var bar: Int
		
		required init?(map: XMLMap) {
			
			self.foo = "__foo"
			self.bar = self.foo.hash
			
			self.mapping(map: map)
		}
		
		func mapping(map: XMLMap) {
			
			self.foo <- map["foo"]
			self.bar <- map["bar"]
		}
	}
}

