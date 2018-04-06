//
//  BasicTypesTestsFromXML.swift
//  XMLMapperTests
//
//  Created by Giorgos Charitakis on 16/02/2018.
//

import Foundation
import XCTest
import XMLMapper

class BasicTypesTestsFromXML: XCTestCase {

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
	
	func testMappingBoolFromXML(){
		let value: Bool = true
		let XMLString = "<root><bool>\(value)</bool><boolOpt>\(value)</boolOpt><boolImp>\(value)</boolImp></root>"
		
		let mappedObject = mapper.map(XMLString: XMLString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.bool, value)
		XCTAssertEqual(mappedObject?.boolOptional, value)
		XCTAssertEqual(mappedObject?.boolImplicityUnwrapped, value)
	}

	/// - warning: This test doens't consider integer overflow/underflow.
	func testMappingIntegerFromXML(){
        let value = "123"
        let xml: [String: Any] = [
            "int": value,
            "intOpt": value,
            "intImp": value,
            
            "int8": value,
            "int8Opt": value,
            "int8Imp": value,
            
            "int16": value,
            "int16Opt": value,
            "int16Imp": value,
            
            "int32": value,
            "int32Opt": value,
            "int32Imp": value,
            
            "int64": value,
            "int64Opt": value,
            "int64Imp": value,
            
            "uint": value,
            "uintOpt": value,
            "uintImp": value,
            
            "uint8": value,
            "uint8Opt": value,
            "uint8Imp": value,
            
            "uint16": value,
            "uint16Opt": value,
            "uint16Imp": value,
            
            "uint32": value,
            "uint32Opt": value,
            "uint32Imp": value,
            
            "uint64": value,
            "uint64Opt": value,
            "uint64Imp": value,
        ]
        let mappedObject = mapper.map(XML: xml)
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

	func testMappingIntegerWithOverflowFromXML(){
		let signedValue = Int.max.description
		let unsignedValue = UInt.max.description

		let xml: [String: Any] = [
			"int": signedValue,
			"intOpt": signedValue,
			"intImp": signedValue,

			"int8": signedValue,
			"int8Opt": signedValue,
			"int8Imp": signedValue,

			"int16": signedValue,
			"int16Opt": signedValue,
			"int16Imp": signedValue,

			"int32": signedValue,
			"int32Opt": signedValue,
			"int32Imp": signedValue,

			"int64": signedValue,
			"int64Opt": signedValue,
			"int64Imp": signedValue,

			"uint": unsignedValue,
			"uintOpt": unsignedValue,
			"uintImp": unsignedValue,

			"uint8": unsignedValue,
			"uint8Opt": unsignedValue,
			"uint8Imp": unsignedValue,

			"uint16": unsignedValue,
			"uint16Opt": unsignedValue,
			"uint16Imp": unsignedValue,

			"uint32": unsignedValue,
			"uint32Opt": unsignedValue,
			"uint32Imp": unsignedValue,

			"uint64": unsignedValue,
			"uint64Opt": unsignedValue,
			"uint64Imp": unsignedValue,
		]
		let mappedObject = mapper.map(XML: xml)
		XCTAssertNotNil(mappedObject)

		XCTAssertEqual(mappedObject?.int, Int.max)
		XCTAssertEqual(mappedObject?.intOptional, Int.max)
		XCTAssertEqual(mappedObject?.intImplicityUnwrapped, Int.max)

		XCTAssertEqual(mappedObject?.int8, 0)
		XCTAssertEqual(mappedObject?.int8Optional, nil)
		XCTAssertEqual(mappedObject?.int8ImplicityUnwrapped, nil)

		XCTAssertEqual(mappedObject?.int16, 0)
		XCTAssertEqual(mappedObject?.int16Optional, nil)
		XCTAssertEqual(mappedObject?.int16ImplicityUnwrapped, nil)

#if arch(x86_64) || arch(arm64)
		XCTAssertEqual(mappedObject?.int32, 0)
		XCTAssertEqual(mappedObject?.int32Optional, nil)
		XCTAssertEqual(mappedObject?.int32ImplicityUnwrapped, nil)

		XCTAssertEqual(mappedObject?.int64, Int64.max)
		XCTAssertEqual(mappedObject?.int64Optional, Int64.max)
		XCTAssertEqual(mappedObject?.int64ImplicityUnwrapped, Int64.max)
#else
		XCTAssertEqual(mappedObject?.int32, Int32.max)
		XCTAssertEqual(mappedObject?.int32Optional, Int32.max)
		XCTAssertEqual(mappedObject?.int32ImplicityUnwrapped, Int32.max)

		XCTAssertEqual(mappedObject?.int64, Int64(Int32.max))
		XCTAssertEqual(mappedObject?.int64Optional, Int64(Int32.max))
		XCTAssertEqual(mappedObject?.int64ImplicityUnwrapped, Int64(Int32.max))
#endif

		XCTAssertEqual(mappedObject?.uint, UInt.max)
		XCTAssertEqual(mappedObject?.uintOptional, UInt.max)
		XCTAssertEqual(mappedObject?.uintImplicityUnwrapped, UInt.max)

		XCTAssertEqual(mappedObject?.uint8, 0)
		XCTAssertEqual(mappedObject?.uint8Optional, nil)
		XCTAssertEqual(mappedObject?.uint8ImplicityUnwrapped, nil)

		XCTAssertEqual(mappedObject?.uint16, 0)
		XCTAssertEqual(mappedObject?.uint16Optional, nil)
		XCTAssertEqual(mappedObject?.uint16ImplicityUnwrapped, nil)

#if arch(x86_64) || arch(arm64)
		XCTAssertEqual(mappedObject?.uint32, 0)
		XCTAssertEqual(mappedObject?.uint32Optional, nil)
		XCTAssertEqual(mappedObject?.uint32ImplicityUnwrapped, nil)

		XCTAssertEqual(mappedObject?.uint64, UInt64.max)
		XCTAssertEqual(mappedObject?.uint64Optional, UInt64.max)
		XCTAssertEqual(mappedObject?.uint64ImplicityUnwrapped, UInt64.max)
#else
		XCTAssertEqual(mappedObject?.uint32, UInt32.max)
		XCTAssertEqual(mappedObject?.uint32Optional, UInt32.max)
		XCTAssertEqual(mappedObject?.uint32ImplicityUnwrapped, UInt32.max)

		XCTAssertEqual(mappedObject?.uint64, UInt64(UInt32.max))
		XCTAssertEqual(mappedObject?.uint64Optional, UInt64(UInt32.max))
		XCTAssertEqual(mappedObject?.uint64ImplicityUnwrapped, UInt64(UInt32.max))
#endif
	}
	
	func testMappingDoubleFromXML(){
		let value: Double = 11
		let XMLString = "<root><double>\(value)</double><doubleOpt>\(value)</doubleOpt><doubleImp>\(value)</doubleImp></root>"

		let mappedObject = mapper.map(XMLString: XMLString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.double, value)
		XCTAssertEqual(mappedObject?.doubleOptional, value)
		XCTAssertEqual(mappedObject?.doubleImplicityUnwrapped, value)
	}
	
	func testMappingFloatFromXML(){
		let value: Float = 11
		let XMLString = "<root><float>\(value)</float><floatOpt>\(value)</floatOpt><floatImp>\(value)</floatImp></root>"
		
		let mappedObject = mapper.map(XMLString: XMLString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.float, value)
		XCTAssertEqual(mappedObject?.floatOptional, value)
		XCTAssertEqual(mappedObject?.floatImplicityUnwrapped, value)
	}
	
	func testMappingStringFromXML(){
		let value: String = "STRINGNGNGG"
		let XMLString = "<root><string>\(value)</string><stringOpt>\(value)</stringOpt><stringImp>\(value)</stringImp></root>"

		let mappedObject = mapper.map(XMLString: XMLString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.string, value)
		XCTAssertEqual(mappedObject?.stringOptional, value)
		XCTAssertEqual(mappedObject?.stringImplicityUnwrapped, value)
	}
	
	func testMappingAnyObjectFromXML(){
		let value1 = "STRING"
		let value2: Int = 1234
		let value3: Double = 11.11
		let XMLString = "<root><anyObject>\(value1)</anyObject><anyObjectOpt>\(value2)</anyObjectOpt><anyObjectImp>\(value3)</anyObjectImp></root>"
		
		let mappedObject = mapper.map(XMLString: XMLString)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.anyObject as? String, value1)
		XCTAssertEqual(mappedObject?.anyObjectOptional as? String, value2.description)
		XCTAssertEqual(mappedObject?.anyObjectImplicitlyUnwrapped as? String, value3.description)
	}

	func testMappingStringFromNSStringXML(){
		let value: String = "STRINGNGNGG"
		let XMLString : NSString = "<root><string>\(value)</string><stringOpt>\(value)</stringOpt><stringImp>\(value)</stringImp></root>" as NSString
		
		let mappedObject = mapper.map(XMLString: XMLString as String)

		XCTAssertNotNil(mappedObject)
		XCTAssertEqual(mappedObject?.string, value)
		XCTAssertEqual(mappedObject?.stringOptional, value)
		XCTAssertEqual(mappedObject?.stringImplicityUnwrapped, value)
	}

	// MARK: Test mapping Arrays to XML and back (with basic types in them Bool, Int, Double, Float, String)
	
    func testMappingBoolArrayFromXML(){
        let value: Bool = true
        let XMLString = "<root><arrayBool>\(value)</arrayBool><arrayBoolOpt>\(value)</arrayBoolOpt><arrayBoolImp>\(value)</arrayBoolImp></root>"

        let mappedObject = mapper.map(XMLString: XMLString)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.arrayBool.first, value)
        XCTAssertEqual(mappedObject?.arrayBoolOptional?.first, value)
        XCTAssertEqual(mappedObject?.arrayBoolImplicityUnwrapped.first, value)
    }
    
    func testMappingIntArrayFromXML(){
        let value1: Int = 1
        let XMLString = "<root><arrayInt>\(value1)</arrayInt><arrayIntOpt>\(value1)</arrayIntOpt><arrayIntImp>\(value1)</arrayIntImp></root>"

        let mappedObject = mapper.map(XMLString: XMLString)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.arrayInt.first, value1)
        XCTAssertEqual(mappedObject?.arrayIntOptional?.first, value1)
        XCTAssertEqual(mappedObject?.arrayIntImplicityUnwrapped.first, value1)
    }
    
    func testMappingDoubleArrayFromXML(){
        let value1: Double = 1.0
        let XMLString = "<root><arrayDouble>\(value1)</arrayDouble><arrayDoubleOpt>\(value1)</arrayDoubleOpt><arrayDoubleImp>\(value1)</arrayDoubleImp></root>"

        let mappedObject = mapper.map(XMLString: XMLString)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.arrayDouble.first, value1)
        XCTAssertEqual(mappedObject?.arrayDoubleOptional?.first, value1)
        XCTAssertEqual(mappedObject?.arrayDoubleImplicityUnwrapped.first, value1)
    }
    
    func testMappingFloatArrayFromXML(){
        let value1: Float = 1.001
        let XMLString = "<root><arrayFloat>\(value1)</arrayFloat><arrayFloatOpt>\(value1)</arrayFloatOpt><arrayFloatImp>\(value1)</arrayFloatImp></root>"
        
        let mappedObject = mapper.map(XMLString: XMLString)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.arrayFloat.first, value1)
        XCTAssertEqual(mappedObject?.arrayFloatOptional?.first, value1)
        XCTAssertEqual(mappedObject?.arrayFloatImplicityUnwrapped?.first, value1)
    }
    
    func testMappingStringArrayFromXML(){
        let value: String = "Stringgggg"
        let XMLString = "<root><arrayString>\(value)</arrayString><arrayStringOpt>\(value)</arrayStringOpt><arrayStringImp>\(value)</arrayStringImp></root>"
        
        let mappedObject = mapper.map(XMLString: XMLString)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.arrayString.first, value)
        XCTAssertEqual(mappedObject?.arrayStringOptional?.first, value)
        XCTAssertEqual(mappedObject?.arrayStringImplicityUnwrapped.first, value)
    }
    
    func testMappingAnyObjectArrayFromXML(){
        let value1 = "STRING"
        let value2: Int = 1234
        let value3: Double = 11.11
        let XMLString = "<root><arrayAnyObject>\(value1)</arrayAnyObject><arrayAnyObjectOpt>\(value2)</arrayAnyObjectOpt><arrayAnyObjectImp>\(value3)</arrayAnyObjectImp></root>"
        
        let mappedObject = mapper.map(XMLString: XMLString)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.arrayAnyObject.first as? String, value1)
        XCTAssertEqual(mappedObject?.arrayAnyObjectOptional?.first as? String, value2.description)
        XCTAssertEqual(mappedObject?.arrayAnyObjectImplicitlyUnwrapped.first as? String, value3.description)
    }
    
    // MARK: Test mapping Dictionaries to XML and back (with basic types in them Bool, Int, Double, Float, String)
    
    func testMappingBoolDictionaryFromXML(){
        let key = "key"
        let value: Bool = true
        let XMLString = "<root><dictBool><\(key)>\(value)</\(key)></dictBool><dictBoolOpt><\(key)>\(value)</\(key)></dictBoolOpt><dictBoolImp><\(key)>\(value)</\(key)></dictBoolImp></root>"
        
        let mappedObject = mapper.map(XMLString: XMLString)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.dictBool[key], value)
        XCTAssertEqual(mappedObject?.dictBoolOptional?[key], value)
        XCTAssertEqual(mappedObject?.dictBoolImplicityUnwrapped[key], value)
    }
    
    func testMappingIntDictionaryFromXML(){
        let key = "key"
        let value: Int = 11
        let XMLString = "<root><dictInt><\(key)>\(value)</\(key)></dictInt><dictIntOpt><\(key)>\(value)</\(key)></dictIntOpt><dictIntImp><\(key)>\(value)</\(key)></dictIntImp></root>"
        
        let mappedObject = mapper.map(XMLString: XMLString)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.dictInt[key], value)
        XCTAssertEqual(mappedObject?.dictIntOptional?[key], value)
        XCTAssertEqual(mappedObject?.dictIntImplicityUnwrapped[key], value)
    }
    
    func testMappingDoubleDictionaryFromXML(){
        let key = "key"
        let value: Double = 11
        let XMLString = "<root><dictDouble><\(key)>\(value)</\(key)></dictDouble><dictDoubleOpt><\(key)>\(value)</\(key)></dictDoubleOpt><dictDoubleImp><\(key)>\(value)</\(key)></dictDoubleImp></root>"
        
        let mappedObject = mapper.map(XMLString: XMLString)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.dictDouble[key], value)
        XCTAssertEqual(mappedObject?.dictDoubleOptional?[key], value)
        XCTAssertEqual(mappedObject?.dictDoubleImplicityUnwrapped[key], value)
    }
    
    func testMappingFloatDictionaryFromXML(){
        let key = "key"
        let value: Float = 111.1
        let XMLString = "<root><dictFloat><\(key)>\(value)</\(key)></dictFloat><dictFloatOpt><\(key)>\(value)</\(key)></dictFloatOpt><dictFloatImp><\(key)>\(value)</\(key)></dictFloatImp></root>"

        let mappedObject = mapper.map(XMLString: XMLString)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.dictFloat[key], value)
        XCTAssertEqual(mappedObject?.dictFloatOptional?[key], value)
        XCTAssertEqual(mappedObject?.dictFloatImplicityUnwrapped?[key], value)
    }
    
    func testMappingStringDictionaryFromXML(){
        let key = "key"
        let value = "value"
        let XMLString = "<root><dictString><\(key)>\(value)</\(key)></dictString><dictStringOpt><\(key)>\(value)</\(key)></dictStringOpt><dictStringImp><\(key)>\(value)</\(key)></dictStringImp></root>"
        
        let mappedObject = mapper.map(XMLString: XMLString)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.dictString[key], value)
        XCTAssertEqual(mappedObject?.dictStringOptional?[key], value)
        XCTAssertEqual(mappedObject?.dictStringImplicityUnwrapped?[key], value)
    }
    
    func testMappingAnyObjectDictionaryFromXML(){
        let key = "key"
        let value1 = "STRING"
        let value2: Int = 1234
        let value3: Double = 11.11
        let XMLString = "<root><dictAnyObject><\(key)>\(value1)</\(key)></dictAnyObject><dictAnyObjectOpt><\(key)>\(value2)</\(key)></dictAnyObjectOpt><dictAnyObjectImp><\(key)>\(value3)</\(key)></dictAnyObjectImp></root>"
        
        let mappedObject = mapper.map(XMLString: XMLString)

        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.dictAnyObject[key] as? String, value1)
        XCTAssertEqual(mappedObject?.dictAnyObjectOptional?[key] as? String, value2.description)
        XCTAssertEqual(mappedObject?.dictAnyObjectImplicitlyUnwrapped[key] as? String, value3.description)
    }
    
    func testMappingIntEnumFromXML(){
        let value: BasicTypes.EnumInt = .another
        let XMLString = "<root><enumInt>\(value.rawValue)</enumInt><enumIntOpt>\(value.rawValue)</enumIntOpt><enumIntImp>\(value.rawValue)</enumIntImp></root>"
        
        let mappedObject = mapper.map(XMLString: XMLString)
        
        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.enumInt, value)
        XCTAssertEqual(mappedObject?.enumIntOptional, value)
        XCTAssertEqual(mappedObject?.enumIntImplicitlyUnwrapped, value)
    }
    
    func testMappingIntEnumFromXMLShouldNotCrashWithNonDefinedvalue() {
        let value = Int.min
        let XMLString = "<root><enumInt>\(value)</enumInt><enumIntOpt>\(value)</enumIntOpt><enumIntImp>\(value)</enumIntImp></root>"
        
        let mappedObject = mapper.map(XMLString: XMLString)
        
        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.enumInt, BasicTypes.EnumInt.default)
        XCTAssertNil(mappedObject?.enumIntOptional)
        XCTAssertNil(mappedObject?.enumIntImplicitlyUnwrapped)
    }
    
    func testMappingDoubleEnumFromXML(){
        let value: BasicTypes.EnumDouble = .another
        let XMLString = "<root><enumDouble>\(value.rawValue)</enumDouble><enumDoubleOpt>\(value.rawValue)</enumDoubleOpt><enumDoubleImp>\(value.rawValue)</enumDoubleImp></root>"
        
        let mappedObject = mapper.map(XMLString: XMLString)
        
        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.enumDouble, value)
        XCTAssertEqual(mappedObject?.enumDoubleOptional, value)
        XCTAssertEqual(mappedObject?.enumDoubleImplicitlyUnwrapped, value)
    }
    
    func testMappingFloatEnumFromXML(){
        let value: BasicTypes.EnumFloat = .another
        let XMLString = "<root><enumFloat>\(value.rawValue)</enumFloat><enumFloatOpt>\(value.rawValue)</enumFloatOpt><enumFloatImp>\(value.rawValue)</enumFloatImp></root>"
        
        let mappedObject = mapper.map(XMLString: XMLString)
        
        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.enumFloat, value)
        XCTAssertEqual(mappedObject?.enumFloatOptional, value)
        XCTAssertEqual(mappedObject?.enumFloatImplicitlyUnwrapped, value)
    }
    
    func testMappingStringEnumFromXML(){
        let value: BasicTypes.EnumString = .another
        let XMLString = "<root><enumString>\(value.rawValue)</enumString><enumStringOpt>\(value.rawValue)</enumStringOpt><enumStringImp>\(value.rawValue)</enumStringImp></root>"
        
        let mappedObject = mapper.map(XMLString: XMLString)
        
        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.enumString, value)
        XCTAssertEqual(mappedObject?.enumStringOptional, value)
        XCTAssertEqual(mappedObject?.enumStringImplicitlyUnwrapped, value)
    }

    func testMappingStringEnumFromXMLShouldNotCrashWithNonDefinedValue() {
        let value = "NonDefinedValue"
        let XMLString = "<root><enumString>\(value)</enumString><enumStringOpt>\(value)</enumStringOpt><enumStringImp>\(value)</enumStringImp></root>"

        let mappedObject = mapper.map(XMLString: XMLString)
        
        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.enumString, BasicTypes.EnumString.default)
        XCTAssertNil(mappedObject?.enumStringOptional)
        XCTAssertNil(mappedObject?.enumStringImplicitlyUnwrapped)
    }

    func testMappingEnumIntArrayFromXML(){
        let value: BasicTypes.EnumInt = .another
        let XMLString = "<root><arrayEnumInt>\(value.rawValue)</arrayEnumInt><arrayEnumIntOpt>\(value.rawValue)</arrayEnumIntOpt><arrayEnumIntImp>\(value.rawValue)</arrayEnumIntImp></root>"

        let mappedObject = mapper.map(XMLString: XMLString)
        
        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.arrayEnumInt.first, value)
        XCTAssertEqual(mappedObject?.arrayEnumIntOptional?.first, value)
        XCTAssertEqual(mappedObject?.arrayEnumIntImplicitlyUnwrapped.first, value)
    }

    func testMappingEnumIntArrayFromXMLShouldNotCrashWithNonDefinedValue() {
        let value = Int.min
        let XMLString = "<root><arrayEnumInt>\(value)</arrayEnumInt><arrayEnumIntOpt>\(value)</arrayEnumIntOpt><arrayEnumIntImp>\(value)</arrayEnumIntImp></root>"

        let mappedObject = mapper.map(XMLString: XMLString)
        
        XCTAssertNotNil(mappedObject)
        XCTAssertNil(mappedObject?.arrayEnumInt.first)
        XCTAssertNil(mappedObject?.arrayEnumIntOptional?.first)
        XCTAssertNil(mappedObject?.arrayEnumIntImplicitlyUnwrapped?.first)
    }

    func testMappingEnumIntDictionaryFromXML(){
        let key = "key"
        let value: BasicTypes.EnumInt = .another
        let XMLString = "<root><dictEnumInt><\(key)>\(value.rawValue)</\(key)></dictEnumInt><dictEnumIntOpt><\(key)>\(value.rawValue)</\(key)></dictEnumIntOpt><dictEnumIntImp><\(key)>\(value.rawValue)</\(key)></dictEnumIntImp></root>"

        let mappedObject = mapper.map(XMLString: XMLString)
        
        XCTAssertNotNil(mappedObject)
        XCTAssertEqual(mappedObject?.dictEnumInt[key], value)
        XCTAssertEqual(mappedObject?.dictEnumIntOptional?[key], value)
        XCTAssertEqual(mappedObject?.dictEnumIntImplicitlyUnwrapped[key], value)
    }

    func testMappingEnumIntDictionaryFromXMLShouldNotCrashWithNonDefinedValue() {
        let key = "key"
        let value = Int.min
        let XMLString = "<root><dictEnumInt><\(key)>\(value)</\(key)></dictEnumInt><dictEnumIntOpt><\(key)>\(value)</\(key)></dictEnumIntOpt><dictEnumIntImp><\(key)>\(value)</\(key)></dictEnumIntImp></root>"

        let mappedObject = mapper.map(XMLString: XMLString)
        
        XCTAssertNotNil(mappedObject)
        XCTAssertNil(mappedObject?.dictEnumInt[key])
        XCTAssertNil(mappedObject?.dictEnumIntOptional?[key])
        XCTAssertNil(mappedObject?.dictEnumIntImplicitlyUnwrapped[key])
    }

    func testObjectModelOptionalDictionnaryOfPrimitives() {
        let XML: [String: [String: Any]] = ["dictStringString":["string": "string"], "dictStringBool":["string": false.description], "dictStringInt":["string": 1.description], "dictStringDouble":["string": 1.1.description], "dictStringFloat":["string": Float(1.2).description]]
        
        let mapper = XMLMapper<TestCollectionOfPrimitives>()
        let testSet: TestCollectionOfPrimitives! = mapper.map(XML: XML)

        XCTAssertNotNil(testSet)

        XCTAssertTrue(testSet.dictStringString.count > 0)
        XCTAssertTrue(testSet.dictStringInt.count > 0)
        XCTAssertTrue(testSet.dictStringBool.count > 0)
        XCTAssertTrue(testSet.dictStringDouble.count > 0)
        XCTAssertTrue(testSet.dictStringFloat.count > 0)
    }
}
