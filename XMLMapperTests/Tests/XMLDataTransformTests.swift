//
//  XMLDataTransformTests.swift
//  XMLMapperTests
//
//  Created by Giorgos Charitakis on 18/02/2018.
//

import XCTest
import XMLMapper

class XMLDataTransformTests: XCTestCase {
	
	let mapper = XMLMapper<DataType>()

	func testXMLDataTransform() {

		let dataLength = 20
		let bytes = malloc(dataLength)
		
		let data = Data(bytes: bytes!, count: dataLength)
		let dataString = data.base64EncodedString()
		let XMLString = "<root><data>\(dataString)</data></root>"
		
		let mappedObject = mapper.map(XMLString: XMLString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.stringData, dataString)
		XCTAssertEqual(mappedObject?.data, data)
	}

}

class DataType: XMLMappable {
    var nodeName: String!
    
	var data: Data?
	var stringData: String?
	
	init(){
		
	}
	
	required init?(map: XMLMap){
		
	}
	
	func mapping(map: XMLMap) {
		stringData <- map["data"]
		data <- (map["data"], XMLDataTransform())
	}
}
