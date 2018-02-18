//
//  CustomTransformTestsL.swift
//  XMLMapperTests
//
//  Created by Giorgos Charitakis on 18/02/2018.
//

import Foundation
import XCTest
import XMLMapper

#if os(iOS) || os(tvOS) || os(watchOS)
	typealias TestHexColor = UIColor
#else
	typealias TestHexColor = NSColor
#endif

class CustomTransformTests: XCTestCase {

	let mapper = XMLMapper<Transforms>()
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testDateTransform() {
		let transforms = Transforms()
		transforms.date = Date(timeIntervalSince1970: 946684800)
		transforms.dateOpt = Date(timeIntervalSince1970: 946684912)
		
		let XML = mapper.toXML(transforms)
		let parsedTransforms = mapper.map(XML: XML)
		XCTAssertNotNil(parsedTransforms)
		XCTAssertEqual(parsedTransforms?.date, transforms.date)
		XCTAssertEqual(parsedTransforms?.dateOpt, transforms.dateOpt)
		
		let XMLDateString: [String: Any] = ["date": "946684800", "dateOpt": "946684912"]
		let parsedTransformsDateString = mapper.map(XML: XMLDateString)
		
		XCTAssertNotNil(parsedTransformsDateString)
		XCTAssertEqual(parsedTransforms?.date, parsedTransformsDateString?.date)
		XCTAssertEqual(parsedTransforms?.dateOpt, parsedTransformsDateString?.dateOpt)

	}
	
	func testCustomFormatDateTransform(){
		let dateString = "2015-03-03T02:36:44"
		let XML: [String: Any] = ["customFormateDate": dateString]
		let transform: Transforms! = mapper.map(XML: XML)
		XCTAssertNotNil(transform)
		
		let XMLOutput = mapper.toXML(transform)

		XCTAssertEqual(XMLOutput["customFormateDate"] as? String, dateString)
	}
	
	func testIntToStringTransformOf() {
		let intValue = 12345
		let XML: [String: Any] = ["intWithString": "\(intValue)"]
		let transforms = mapper.map(XML: XML)

		XCTAssertEqual(transforms?.intWithString, intValue)
	}
	
	func testInt64MaxValue() {
		let transforms = Transforms()
		transforms.int64Value = INT64_MAX
		
		let XML = mapper.toXML(transforms)

		let parsedTransforms = mapper.map(XML: XML)
		XCTAssertNotNil(parsedTransforms)
		XCTAssertEqual(parsedTransforms?.int64Value, transforms.int64Value)
	}
	
	func testURLTranform() {
		let transforms = Transforms()
		transforms.URL = URL(string: "http://google.com/image/1234")!
		transforms.URLOpt = URL(string: "http://google.com/image/1234")
		transforms.URLWithoutEncoding = URL(string: "http://google.com/image/1234#fragment")!
		
		let XML = mapper.toXML(transforms)

		let parsedTransforms = mapper.map(XML: XML)
		
		XCTAssertNotNil(parsedTransforms)
		XCTAssertEqual(parsedTransforms?.URL, transforms.URL)
		XCTAssertEqual(parsedTransforms?.URLOpt, transforms.URLOpt)
		XCTAssertEqual(parsedTransforms?.URLWithoutEncoding, transforms.URLWithoutEncoding)
	}
	
	func testEnumTransform() {
		let XML: [String: Any] = ["firstImageType": "cover", "secondImageType": "thumbnail"]
		let transforms = mapper.map(XML: XML)

		let imageType = Transforms.ImageType.self
		XCTAssertEqual(transforms?.firstImageType, imageType.Cover)
		XCTAssertEqual(transforms?.secondImageType, imageType.Thumbnail)
	}
	
	func testHexColorTransform() {
		let XML: [String: Any] = [
			"colorRed": "#FF0000",
			"colorGreenLowercase": "#00FF00",
			"colorBlueWithoutHash": "0000FF",
			"color3lenght": "F00",
			"color4lenght": "F00f",
			"color8lenght": "ff0000ff"
		]
		
		let transform = mapper.map(XML: XML)
		
		XCTAssertEqual(transform?.colorRed, TestHexColor.red)
		XCTAssertEqual(transform?.colorGreenLowercase, TestHexColor.green)
		XCTAssertEqual(transform?.colorBlueWithoutHash, TestHexColor.blue)
		XCTAssertEqual(transform?.color3lenght, TestHexColor.red)
		XCTAssertEqual(transform?.color4lenght, TestHexColor.red)
		XCTAssertEqual(transform?.color8lenght, TestHexColor.red)
		
		let XMLOutput = mapper.toXML(transform!)
		
		XCTAssertEqual(XMLOutput["colorRed"] as? String, "FF0000")
		XCTAssertEqual(XMLOutput["colorGreenLowercase"] as? String, "00FF00")
		XCTAssertEqual(XMLOutput["colorBlueWithoutHash"] as? String, "#0000FF") // prefixToXML = true
		XCTAssertEqual(XMLOutput["color3lenght"] as? String, "FF0000")
		XCTAssertEqual(XMLOutput["color4lenght"] as? String, "FF0000")
		XCTAssertEqual(XMLOutput["color8lenght"] as? String, "FF0000FF") // alphaToXML = true
	}
}

class Transforms: XMLMappable {
    var nodeName: String!
	
	internal enum ImageType: String {
		case Cover = "cover"
		case Thumbnail = "thumbnail"
	}

	var date = Date()
	var dateOpt: Date?
	
	var customFormatDate = Date()
	var customFormatDateOpt: Date?
	
	var URL = Foundation.URL(string: "")
	var URLOpt: Foundation.URL?
	var URLWithoutEncoding = Foundation.URL(string: "")
	
	var intWithString: Int = 0
	
	var int64Value: Int64 = 0
	
	var firstImageType: ImageType?
	var secondImageType: ImageType?
	
	var colorRed: TestHexColor?
	var colorGreenLowercase: TestHexColor?
	var colorBlueWithoutHash: TestHexColor?
	var color3lenght: TestHexColor?
	var color4lenght: TestHexColor?
	var color8lenght: TestHexColor?

	init(){
		
	}
	
	required init(map: XMLMap){
		
	}
	
	func mapping(map: XMLMap) {
		date				<- (map["date"], XMLDateTransform())
		dateOpt				<- (map["dateOpt"], XMLDateTransform())
		
		customFormatDate	<- (map["customFormateDate"], XMLCustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss"))
		customFormatDateOpt <- (map["customFormateDateOpt"], XMLCustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss"))

		URL					<- (map["URL"], XMLURLTransform())
		URLOpt				<- (map["URLOpt"], XMLURLTransform())
		URLWithoutEncoding  <- (map["URLWithoutEncoding"], XMLURLTransform(shouldEncodeURLString: false))
		
		intWithString		<- (map["intWithString"], XMLTransformOf<Int, String>(fromXML: { $0 == nil ? nil : Int($0!) }, toXML: { $0.map { String($0) } }))
		int64Value			<- (map["int64Value"], XMLTransformOf<Int64, NSNumber>(fromXML: { $0?.int64Value }, toXML: { $0.map { NSNumber(value: $0) } }))
		
		firstImageType		<- (map["firstImageType"], XMLEnumTransform<ImageType>())
		secondImageType		<- (map["secondImageType"], XMLEnumTransform<ImageType>())
		
		colorRed			<- (map["colorRed"], XMLHexColorTransform())
		colorGreenLowercase <- (map["colorGreenLowercase"], XMLHexColorTransform())
		colorBlueWithoutHash <- (map["colorBlueWithoutHash"], XMLHexColorTransform(prefixToXML: true))
		color3lenght			<- (map["color3lenght"], XMLHexColorTransform())
		color4lenght			<- (map["color4lenght"], XMLHexColorTransform())
		color8lenght			<- (map["color8lenght"], XMLHexColorTransform(alphaToXML: true))
	}
}

