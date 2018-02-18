//
//  BasicTypesTestsToXML.swift
//  XMLMapperTests
//
//  Created by Giorgos Charitakis on 18/02/2018.
//

import Foundation
import XCTest
import XMLMapper

class BasicTypesTestsToXML: XCTestCase {

    let mapper = XMLMapper<BasicTypes>()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	// MARK: Test mapping to XML and back (basic types: Bool, Int, Double, Float, String)
	
//    func testShouldIncludeNilValues(){
//        let object = BasicTypes()
//
//        let XMLWithNil = XMLMapper<BasicTypes>().toXMLString(object)
//        let XMLWithoutNil = XMLMapper<BasicTypes>().toXMLString(object)
//
//        //TODO This test could be improved
//        XCTAssertNotNil(XMLWithNil)
//        XCTAssertTrue((XMLWithNil!.characters.count) > 5)
//        XCTAssertTrue((XMLWithNil!.characters.count) != (XMLWithoutNil!.characters.count))
//    }
	
    func testMappingBoolToXML(){
        let value: Bool = true
        let object = BasicTypes()
        object.bool = value
        object.boolOptional = value
        object.boolImplicityUnwrapped = value

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.bool, value)
        XCTAssertEqual(mappedObject?.boolOptional, value)
        XCTAssertEqual(mappedObject?.boolImplicityUnwrapped, value)
    }

    func testMappingIntegerToXML(){
        let object = BasicTypes()

        object.int = 123
        object.intOptional = 123
        object.intImplicityUnwrapped = 123

        object.int8 = 123
        object.int8Optional = 123
        object.int8ImplicityUnwrapped = 123

        object.int16 = 123
        object.int16Optional = 123
        object.int16ImplicityUnwrapped = 123

        object.int32 = 123
        object.int32Optional = 123
        object.int32ImplicityUnwrapped = 123

        object.int64 = 123
        object.int64Optional = 123
        object.int64ImplicityUnwrapped = 123

        object.uint = 123
        object.uintOptional = 123
        object.uintImplicityUnwrapped = 123

        object.uint8 = 123
        object.uint8Optional = 123
        object.uint8ImplicityUnwrapped = 123

        object.uint16 = 123
        object.uint16Optional = 123
        object.uint16ImplicityUnwrapped = 123

        object.uint32 = 123
        object.uint32Optional = 123
        object.uint32ImplicityUnwrapped = 123

        object.uint64 = 123
        object.uint64Optional = 123
        object.uint64ImplicityUnwrapped = 123

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)

        XCTAssertEqual(mappedObject?.int, 123)
        XCTAssertEqual(mappedObject?.intOptional, 123)
        XCTAssertEqual(mappedObject?.intImplicityUnwrapped, 123)

        XCTAssertEqual(mappedObject?.int8, 123)
        XCTAssertEqual(mappedObject?.int8Optional, 123)
        XCTAssertEqual(mappedObject?.int8ImplicityUnwrapped, 123)

        XCTAssertEqual(mappedObject?.int16, 123)
        XCTAssertEqual(mappedObject?.int16Optional, 123)
        XCTAssertEqual(mappedObject?.int16ImplicityUnwrapped, 123)

        XCTAssertEqual(mappedObject?.int32, 123)
        XCTAssertEqual(mappedObject?.int32Optional, 123)
        XCTAssertEqual(mappedObject?.int32ImplicityUnwrapped, 123)

        XCTAssertEqual(mappedObject?.int64, 123)
        XCTAssertEqual(mappedObject?.int64Optional, 123)
        XCTAssertEqual(mappedObject?.int64ImplicityUnwrapped, 123)

        XCTAssertEqual(mappedObject?.uint, 123)
        XCTAssertEqual(mappedObject?.uintOptional, 123)
        XCTAssertEqual(mappedObject?.uintImplicityUnwrapped, 123)

        XCTAssertEqual(mappedObject?.uint8, 123)
        XCTAssertEqual(mappedObject?.uint8Optional, 123)
        XCTAssertEqual(mappedObject?.uint8ImplicityUnwrapped, 123)

        XCTAssertEqual(mappedObject?.uint16, 123)
        XCTAssertEqual(mappedObject?.uint16Optional, 123)
        XCTAssertEqual(mappedObject?.uint16ImplicityUnwrapped, 123)

        XCTAssertEqual(mappedObject?.uint32, 123)
        XCTAssertEqual(mappedObject?.uint32Optional, 123)
        XCTAssertEqual(mappedObject?.uint32ImplicityUnwrapped, 123)

        XCTAssertEqual(mappedObject?.uint64, 123)
        XCTAssertEqual(mappedObject?.uint64Optional, 123)
        XCTAssertEqual(mappedObject?.uint64ImplicityUnwrapped, 123)
    }

    func testMappingDoubleToXML(){
        let value: Double = 11
        let object = BasicTypes()
        object.double = value
        object.doubleOptional = value
        object.doubleImplicityUnwrapped = value

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.double, value)
        XCTAssertEqual(mappedObject?.doubleOptional, value)
        XCTAssertEqual(mappedObject?.doubleImplicityUnwrapped, value)
    }

    func testMappingFloatToXML(){
        let value: Float = 11
        let object = BasicTypes()
        object.float = value
        object.floatOptional = value
        object.floatImplicityUnwrapped = value

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.float, value)
        XCTAssertEqual(mappedObject?.floatOptional, value)
        XCTAssertEqual(mappedObject?.floatImplicityUnwrapped, value)
    }

    func testMappingStringToXML(){
        let value: String = "STRINGNGNGG"
        let object = BasicTypes()
        object.string = value
        object.stringOptional = value
        object.stringImplicityUnwrapped = value

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.string, value)
        XCTAssertEqual(mappedObject?.stringOptional, value)
        XCTAssertEqual(mappedObject?.stringImplicityUnwrapped, value)
    }

    func testMappingAnyObjectToXML(){
        let value: String = "STRINGNGNGG"
        let object = BasicTypes()
        object.anyObject = value
        object.anyObjectOptional = value
        object.anyObjectImplicitlyUnwrapped = value

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.anyObject as? String, value)
        XCTAssertEqual(mappedObject?.anyObjectOptional as? String, value)
        XCTAssertEqual(mappedObject?.anyObjectImplicitlyUnwrapped as? String, value)
    }

    // MARK: Test mapping Arrays to XML and back (with basic types in them Bool, Int, Double, Float, String)
    
//    func testMappingEmptyArrayToXML(){
//        let object = BasicTypes()
//        object.arrayBool = []
//        object.arrayBoolOptional = []
//        object.arrayBoolImplicityUnwrapped = []
//
//        let XMLString = XMLMapper().toXMLString(object)
//        let mappedObject = mapper.map(XMLString: XMLString!)
//
//        XCTAssertNotNil(mappedObject)
//        XCTAssertEqual(mappedObject!.arrayBool, [])
//        XCTAssertEqual(mappedObject!.arrayBoolOptional!, [])
//        XCTAssertEqual(mappedObject!.arrayBoolImplicityUnwrapped, [])
//    }
    
    func testMappingBoolArrayToXML(){
        let value: Bool = true
        let object = BasicTypes()
        object.arrayBool = [value, !value]
        object.arrayBoolOptional = [value, !value]
        object.arrayBoolImplicityUnwrapped = [value, !value]

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.arrayBool.first, value)
        XCTAssertEqual(mappedObject?.arrayBool.last, !value)
        XCTAssertEqual(mappedObject?.arrayBoolOptional?.first, value)
        XCTAssertEqual(mappedObject?.arrayBoolOptional?.last, !value)
        XCTAssertEqual(mappedObject?.arrayBoolImplicityUnwrapped.first, value)
        XCTAssertEqual(mappedObject?.arrayBoolImplicityUnwrapped.last, !value)
    }

    func testMappingIntArrayToXML(){
        let value1: Int = 1
        let value2: Int = 2
        let object = BasicTypes()
        object.arrayInt = [value1, value2]
        object.arrayIntOptional = [value1, value2]
        object.arrayIntImplicityUnwrapped = [value1, value2]

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.arrayInt.first, value1)
        XCTAssertEqual(mappedObject?.arrayInt.last, value2)
        XCTAssertEqual(mappedObject?.arrayIntOptional?.first, value1)
        XCTAssertEqual(mappedObject?.arrayIntOptional?.last, value2)
        XCTAssertEqual(mappedObject?.arrayIntImplicityUnwrapped.first, value1)
        XCTAssertEqual(mappedObject?.arrayIntImplicityUnwrapped.last, value2)
    }

    func testMappingDoubleArrayToXML(){
        let value1: Double = 1.0
        let value2: Double = 2.0
        let object = BasicTypes()
        object.arrayDouble = [value1, value2]
        object.arrayDoubleOptional = [value1, value2]
        object.arrayDoubleImplicityUnwrapped = [value1, value2]

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.arrayDouble.first, value1)
        XCTAssertEqual(mappedObject?.arrayDouble.last, value2)
        XCTAssertEqual(mappedObject?.arrayDoubleOptional?.first, value1)
        XCTAssertEqual(mappedObject?.arrayDoubleOptional?.last, value2)
        XCTAssertEqual(mappedObject?.arrayDoubleImplicityUnwrapped.first, value1)
        XCTAssertEqual(mappedObject?.arrayDoubleImplicityUnwrapped.last, value2)
    }

    func testMappingFloatArrayToXML(){
        let value1: Float = 1.001
        let value2: Float = 2.002
        let object = BasicTypes()
        object.arrayFloat = [value1, value2]
        object.arrayFloatOptional = [value1, value2]
        object.arrayFloatImplicityUnwrapped = [value1, value2]

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.arrayFloat.first, value1)
        XCTAssertEqual(mappedObject?.arrayFloat.last, value2)
        XCTAssertEqual(mappedObject?.arrayFloatOptional?.first, value1)
        XCTAssertEqual(mappedObject?.arrayFloatOptional?.last, value2)
        XCTAssertEqual(mappedObject?.arrayFloatImplicityUnwrapped.first, value1)
        XCTAssertEqual(mappedObject?.arrayFloatImplicityUnwrapped.last, value2)
    }

    func testMappingStringArrayToXML(){
        let value: String = "Stringgggg"
        let object = BasicTypes()
        object.arrayString = [value, value]
        object.arrayStringOptional = [value, value]
        object.arrayStringImplicityUnwrapped = [value, value]

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.arrayString.first, value)
        XCTAssertEqual(mappedObject?.arrayString.last, value)
        XCTAssertEqual(mappedObject?.arrayStringOptional?.first, value)
        XCTAssertEqual(mappedObject?.arrayStringOptional?.last, value)
        XCTAssertEqual(mappedObject?.arrayStringImplicityUnwrapped.first, value)
        XCTAssertEqual(mappedObject?.arrayStringImplicityUnwrapped.last, value)
    }

    func testMappingAnyObjectArrayToXML(){
        let value: String = "Stringgggg"
        let object = BasicTypes()
        object.arrayAnyObject = [value, value]
        object.arrayAnyObjectOptional = [value, value]
        object.arrayAnyObjectImplicitlyUnwrapped = [value, value]

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.arrayAnyObject.first as? String, value)
        XCTAssertEqual(mappedObject?.arrayAnyObject.last as? String, value)
        XCTAssertEqual(mappedObject?.arrayAnyObjectOptional?.first as? String, value)
        XCTAssertEqual(mappedObject?.arrayAnyObjectOptional?.last as? String, value)
        XCTAssertEqual(mappedObject?.arrayAnyObjectImplicitlyUnwrapped.first as? String, value)
        XCTAssertEqual(mappedObject?.arrayAnyObjectImplicitlyUnwrapped.last as? String, value)
    }

    // MARK: Test mapping Dictionaries to XML and back (with basic types in them Bool, Int, Double, Float, String)

//    func testMappingEmptyDictionaryToXML(){
//        let object = BasicTypes()
//        object.dictBool = [:]
//        object.dictBoolOptional = [:]
//        object.dictBoolImplicityUnwrapped = [:]
//
//        let XMLString = XMLMapper().toXMLString(object)
//        let mappedObject = mapper.map(XMLString: XMLString!)
//
//        XCTAssertNotNil(mappedObject)
//        XCTAssertEqual(mappedObject!.dictBool, [:])
//        XCTAssertEqual(mappedObject!.dictBoolOptional!, [:])
//        XCTAssertEqual(mappedObject!.dictBoolImplicityUnwrapped, [:])
//    }

    func testMappingBoolDictionaryToXML(){
        let key = "key"
        let value: Bool = true
        let object = BasicTypes()
        object.dictBool = [key:value]
        object.dictBoolOptional = [key:value]
        object.dictBoolImplicityUnwrapped = [key:value]

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.dictBool[key], value)
        XCTAssertEqual(mappedObject?.dictBoolOptional?[key], value)
        XCTAssertEqual(mappedObject?.dictBoolImplicityUnwrapped[key], value)
    }

    func testMappingIntDictionaryToXML(){
        let key = "key"
        let value: Int = 11
        let object = BasicTypes()
        object.dictInt = [key:value]
        object.dictIntOptional = [key:value]
        object.dictIntImplicityUnwrapped = [key:value]

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.dictInt[key], value)
        XCTAssertEqual(mappedObject?.dictIntOptional?[key], value)
        XCTAssertEqual(mappedObject?.dictIntImplicityUnwrapped[key], value)
    }

    func testMappingDoubleDictionaryToXML(){
        let key = "key"
        let value: Double = 11
        let object = BasicTypes()
        object.dictDouble = [key:value]
        object.dictDoubleOptional = [key:value]
        object.dictDoubleImplicityUnwrapped = [key:value]

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.dictDouble[key], value)
        XCTAssertEqual(mappedObject?.dictDoubleOptional?[key], value)
        XCTAssertEqual(mappedObject?.dictDoubleImplicityUnwrapped[key], value)
    }

    func testMappingFloatDictionaryToXML(){
        let key = "key"
        let value: Float = 11
        let object = BasicTypes()
        object.dictFloat = [key:value]
        object.dictFloatOptional = [key:value]
        object.dictFloatImplicityUnwrapped = [key:value]

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.dictFloat[key], value)
        XCTAssertEqual(mappedObject?.dictFloatOptional?[key], value)
        XCTAssertEqual(mappedObject?.dictFloatImplicityUnwrapped[key], value)
    }

    func testMappingStringDictionaryToXML(){
        let key = "key"
        let value = "value"
        let object = BasicTypes()
        object.dictString = [key:value]
        object.dictStringOptional = [key:value]
        object.dictStringImplicityUnwrapped = [key:value]

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.dictString[key], value)
        XCTAssertEqual(mappedObject?.dictStringOptional?[key], value)
        XCTAssertEqual(mappedObject?.dictStringImplicityUnwrapped[key], value)
    }

    func testMappingAnyObjectDictionaryToXML(){
        let key = "key"
        let value = "value"
        let object = BasicTypes()
        object.dictAnyObject = [key:value]
        object.dictAnyObjectOptional = [key:value]
        object.dictAnyObjectImplicitlyUnwrapped = [key:value]

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.dictAnyObject[key] as? String, value)
        XCTAssertEqual(mappedObject?.dictAnyObjectOptional?[key] as? String, value)
        XCTAssertEqual(mappedObject?.dictAnyObjectImplicitlyUnwrapped[key] as? String, value)
    }

    func testMappingStringEnumToXML(){
        let value = BasicTypes.EnumString.another
        let object = BasicTypes()
        object.enumString = value
        object.enumStringOptional = value
        object.enumStringImplicitlyUnwrapped = value

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.enumString, value)
        XCTAssertEqual(mappedObject?.enumStringOptional, value)
        XCTAssertEqual(mappedObject?.enumStringImplicitlyUnwrapped, value)
    }

    func testMappingEnumStringArrayToXML(){
        let value = BasicTypes.EnumString.another
        let object = BasicTypes()
        object.arrayEnumString = [value, value]
        object.arrayEnumStringOptional = [value, value]
        object.arrayEnumStringImplicitlyUnwrapped = [value, value]

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.arrayEnumString.first, value)
        XCTAssertEqual(mappedObject?.arrayEnumString.last, value)
        XCTAssertEqual(mappedObject?.arrayEnumStringOptional?.first, value)
        XCTAssertEqual(mappedObject?.arrayEnumStringOptional?.last, value)
        XCTAssertEqual(mappedObject?.arrayEnumStringImplicitlyUnwrapped.first, value)
        XCTAssertEqual(mappedObject?.arrayEnumStringImplicitlyUnwrapped.last, value)
    }

    func testMappingEnumStringDictionaryToXML(){
        let key = "key"
        let value = BasicTypes.EnumString.another
        let object = BasicTypes()
        object.dictEnumString = [key: value]
        object.dictEnumStringOptional = [key: value]
        object.dictEnumStringImplicitlyUnwrapped = [key: value]

        let XMLString = XMLMapper().toXMLString(object)
        let mappedObject = mapper.map(XMLString: XMLString!)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.dictEnumString[key], value)
        XCTAssertEqual(mappedObject?.dictEnumStringOptional?[key], value)
        XCTAssertEqual(mappedObject?.dictEnumStringImplicitlyUnwrapped[key], value)
    }

    func testObjectToModelDictionnaryOfPrimitives() {
        let object = TestCollectionOfPrimitives()
        object.dictStringString = ["string": "string"]
        object.dictStringBool = ["string": false]
        object.dictStringInt = ["string": 1]
        object.dictStringDouble = ["string": 1.2]
        object.dictStringFloat = ["string": 1.3]

        let XML = XMLMapper<TestCollectionOfPrimitives>().toXML(object)

        XCTAssertTrue((XML["dictStringString"] as? [String:String])?.count ?? 0 > 0)
        XCTAssertTrue((XML["dictStringBool"] as? [String:String])?.count ?? 0 > 0)
        XCTAssertTrue((XML["dictStringInt"] as? [String:String])?.count ?? 0 > 0)
        XCTAssertTrue((XML["dictStringDouble"] as? [String:String])?.count ?? 0 > 0)
        XCTAssertTrue((XML["dictStringFloat"] as? [String:String])?.count ?? 0 > 0)
        XCTAssertEqual((XML["dictStringString"] as? [String:String])?["string"], "string")
    }
}
