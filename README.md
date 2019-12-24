# XMLMapper

[![CI Status](https://img.shields.io/travis/gcharita/XMLMapper.svg?style=flat)](https://travis-ci.org/gcharita/XMLMapper)
[![Version](https://img.shields.io/cocoapods/v/XMLMapper.svg?style=flat)](http://cocoapods.org/pods/XMLMapper)
[![License](https://img.shields.io/cocoapods/l/XMLMapper.svg?style=flat)](http://cocoapods.org/pods/XMLMapper)
[![Platform](https://img.shields.io/cocoapods/p/XMLMapper.svg?style=flat)](http://cocoapods.org/pods/XMLMapper)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

XMLMapper is a framework written in Swift that makes it easy for you to convert your model objects (classes and structs) to and from XML.

- [Example](#example)
- [Requirements](#requirements)
- [Definition of the protocols](#definition-of-the-protocols)
- [How to use](#how-to-use)
  - [Basic XML mapping](#basic-xml-mapping)
  - [Advanced mapping](#advanced-mapping)
  - [Swift 4.2 and unordered XML elements](#swift-42-and-unordered-xml-elements)
  - [XML Mapping example](#xml-Mapping-example)
- [Requests subspec](#requests-subspec)
- [Communication](#communication)
- [Installation](#installation)
- [Special thanks](#special-thanks)
- [License](#license)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 8.0+ / macOS 10.9+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 9.1+
- Swift 3.1+

## Definition of the protocols

### `XMLBaseMappable` Protocol

#### `var nodeName: String! { get set }`

This property is where the name of the XML node is being mapped

#### `mutating func mapping(map: XMLMap)`

This function is where all mapping definitions should go. When parsing XML, this function is executed after successful object creation. When generating XML, it is the only function that is called on the object.

Note: This protocol should not be implemented directly. `XMLMappable` or `XMLStaticMappable` should be used instead

### `XMLMappable` Protocol (sub protocol of `XMLBaseMappable`)

#### `init?(map: XMLMap)`

This failable initializer is used by XMLMapper for object creation. It can be used by developers to validate XML prior to object serialization. Returning nil within the function will prevent the mapping from occuring. You can inspect the `XML` stored within the `XMLMap` object to do your validation:

```swift
required init?(map: XMLMap) {
    // check if a required "id" element exists within the XML.
    if map.XML["id"] == nil {
        return nil
    }
}
```

### `XMLStaticMappable` Protocol (sub protocol of `XMLBaseMappable`)

`XMLStaticMappable` is an alternative to `XMLMappable`. It provides developers with a static function that is used by XMLMapper for object initialization instead of `init?(map: XMLMap)`.

#### `static func objectForMapping(map: XMLMap) -> XMLBaseMappable?`

XMLMapper uses this function to get objects to use for mapping. Developers should return an instance of an object that conforms to `XMLBaseMappable` in this function. This function can also be used to:

- validate XML prior to object serialization
- provide an existing cached object to be used for mapping
- return an object of another type (which also conforms to `XMLBaseMappable`) to be used for mapping. For instance, you may inspect the XML to infer the type of object that should be used for mapping

If you need to implement XMLMapper in an extension, you will need to adopt this protocol instead of `XMLMappable`.

## How to use

To support mapping, a class or struct just needs to implement the `XMLMappable` protocol:

```swift
var nodeName: String! { get set }
init?(map: XMLMap)
mutating func mapping(map: XMLMap)
```

XMLMapper uses the `<-` operator to define how each property maps to and from XML:

```xml
<food>
  <name>Belgian Waffles</name>
  <price>5.95</price>
  <description>
    Two of our famous Belgian Waffles with plenty of real maple syrup
  </description>
  <calories>650</calories>
</food>
```

```swift
class Food: XMLMappable {
    var nodeName: String!

    var name: String!
    var price: Float!
    var description: String?
    var calories: Int?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        name <- map["name"]
        price <- map["price"]
        description <- map["description"]
        calories <- map["calories"]
    }
}
```

XMLMapper can map classes or structs composed of the following types:

- `Int`
- `Bool`
- `Double`
- `Float`
- `String`
- `RawRepresentable` (Enums)
- `Array<Any>`
- `Dictionary<String, Any>`
- `Object<T: XMLBaseMappable>`
- `Array<T: XMLBaseMappable>`
- `Set<T: XMLBaseMappable>`
- `Dictionary<String, T: XMLBaseMappable>`
- `Dictionary<String, Array<T: XMLBaseMappable>>`
- Optionals and Implicitly Unwrapped Optionals of all the above

### Basic XML mapping

Convert easily an XML string to `XMLMappable`:

```swift
let food = Food(XMLString: xmlString)
```

Or an `XMLMappable` object to XML string:

```swift
let xmlString = food.toXMLString()
```

`XMLMapper` class can also provide the same functionality:

```swift
let food = XMLMapper<Food>().map(XMLString: xmlString)

let xmlString = XMLMapper().toXMLString(food)
```

### Advanced mapping

Set `nodeName` property of your class to change the element's name:

```swift
food.nodeName = "myFood"
```

```xml
<myFood>
  <name>Belgian Waffles</name>
  <price>5.95</price>
  <description>
    Two of our famous Belgian Waffles with plenty of real maple syrup
  </description>
  <calories>650</calories>
</myFood>
```

Map easily XML attributes using the `attributes` property of the `XMLMap`:

```xml
<food name="Belgian Waffles">
</food>
```

```swift
func mapping(map: XMLMap) {
    name <- map.attributes["name"]
}
```

Map array of elements:

```xml
<breakfast_menu>
  <food>
    <name>Belgian Waffles</name>
    <price>5.95</price>
    <description>
      Two of our famous Belgian Waffles with plenty of real maple syrup
    </description>
    <calories>650</calories>
  </food>
  <food>
    <name>Strawberry Belgian Waffles</name>
    <price>7.95</price>
    <description>
      Light Belgian waffles covered with strawberries and whipped cream
    </description>
    <calories>900</calories>
  </food>
</breakfast_menu>
```

```swift
func mapping(map: XMLMap) {
    foods <- map["food"]
}
```

Create your own custom transform type by implementing the `XMLTransformType` protocol:

```swift
public protocol XMLTransformType {
    associatedtype Object
    associatedtype XML

    func transformFromXML(_ value: Any?) -> Object?
    func transformToXML(_ value: Object?) -> XML?
}
```

and use it in mapping:

```swift
func mapping(map: XMLMap) {
    startTime <- (map["starttime"], XMLDateTransform())
}
```

Map nested XML elements by separating names with a dot:

```xml
<food>
  <details>
    <price>5.95</price>
  </details>
</food>
```

```swift
func mapping(map: XMLMap) {
    price <- map["details.price"]
}
```

---
**Note:** Nested mapping is currently supported only:

- for elements that are composed of only innerText (like the above example) and
- for attributes

This means that in order to map the actual price of the food in the following XML:

```xml
<food>
  <details>
    <price currency="euro">5.95</price>
  </details>
</food>
```

You need to use an XMLMappable object instead of a `Float`:

```swift
class Price: XMLMappable {
    var nodeName: String!

    var currency: String!
    var actualPrice: Float!

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        currency <- map.attributes["currency"]
        actualPrice <- map.innerText
    }
}
```

Because of `currency` attribute existence. The same applies to the following XML:

```xml
<food>
  <details>
    <price>
      5.95
      <currency>euro</currency>
  </details>
</food>
```

You need to use an XMLMappable object like:

```swift
class Price: XMLMappable {
    var nodeName: String!

    var currency: String!
    var actualPrice: Float!

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        currency <- map["currency"]
        actualPrice <- map.innerText
    }
}
```

Because of `currency` element existence.

---

### Swift 4.2 and unordered XML elements

Starting from Swift 4.2,  XML elements are highly likely to have different order each time you run your app. (This happens because they are represented by a `Dictionary`)

For this, since version 1.5.2 of the XMLMapper you can map and change the order of the nodes that appear inside another node using `nodesOrder` property of `XMLMap`:

```swift
class TestOrderedNodes: XMLMappable {
    var nodeName: String!

    var id: String?
    var name: String?
    var nodesOrder: [String]?

    init() {}
    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        id <- map["id"]
        name <- map["name"]
        nodesOrder <- map.nodesOrder
    }
}

let testOrderedNodes = TestOrderedNodes()
testOrderedNodes.id = "1"
testOrderedNodes.name = "the name"
testOrderedNodes.nodesOrder = ["id", "name"]
print(testOrderedNodes.toXMLString() ?? "nil")
```

**Note:** If you want to change the ordering of the nodes, make sure that you include, in the `nodesOrder` array, all the node names that you want to appear in the XML string

### XML Mapping example

map XML:

```xml
 <?xml version="1.0" encoding="UTF-8"?>
 <root>
    <TestElementXMLMappable testAttribute="enumValue">
        <testString>Test string</testString>
        <testList>
            <element>
                <testInt>1</testInt>
                <testDouble>1.0</testDouble>
            </element>
            <element>
                <testInt>2</testInt>
                <testDouble>2.0</testDouble>
            </element>
            <element>
                <testInt>3</testInt>
                <testDouble>3.0</testDouble>
            </element>
            <element>
                <testInt>4</testInt>
                <testDouble>4.0</testDouble>
            </element>
        </testList>
        <someTag>
            <someOtherTag>
                <nestedTag testNestedAttribute="nested attribute">
                </nestedTag>
            </someOtherTag>
        </someTag>
    </TestElementXMLMappable>
 </root>
```

to classes:

```swift
class TestXMLMappable: XMLMappable {
    var nodeName: String!

    var testElement: TestElementXMLMappable!
    var testNestedAttribute: String?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        testElement <- map["TestElementXMLMappable"]
        testNestedAttribute <- map.attributes["TestElementXMLMappable.someTag.someOtherTag.nestedTag.testNestedAttribute"]
    }
}

enum EnumTest: String {
    case theEnumValue = "enumValue"
}

class TestElementXMLMappable: XMLMappable {
    var nodeName: String!

    var testString: String?
    var testAttribute: EnumTest?
    var testList: [Element]?
    var nodesOrder: [String]?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        testString <- map["testString"]
        testAttribute <- map.attributes["testAttribute"]
        testList <- map["testList.element"]
        nodesOrder <- map.nodesOrder
    }
}

class Element: XMLMappable {
    var nodeName: String!

    var testInt: Int?
    var testDouble: Float?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        testInt <- map["testInt"]
        testDouble <- map["testDouble"]
    }
}
```

## Requests subspec

Create and send easily request with XML body using `Alamofire` (added missing `XMLEncoding` struct)

```swift
Alamofire.request(url, method: .post, parameters: xmlMappableObject.toXML(), encoding: XMLEncoding.default)
```

Also map XML responses to `XMLMappable` objects using the `Alamofire` extension. For example a URL returns the following CD catalog:

```xml
<CATALOG>
    <CD>
        <TITLE>Empire Burlesque</TITLE>
        <ARTIST>Bob Dylan</ARTIST>
        <COUNTRY>USA</COUNTRY>
        <COMPANY>Columbia</COMPANY>
        <PRICE>10.90</PRICE>
        <YEAR>1985</YEAR>
    </CD>
    <CD>
        <TITLE>Hide your heart</TITLE>
        <ARTIST>Bonnie Tyler</ARTIST>
        <COUNTRY>UK</COUNTRY>
        <COMPANY>CBS Records</COMPANY>
        <PRICE>9.90</PRICE>
        <YEAR>1988</YEAR>
    </CD>
</CATALOG>
```

Map the response as follows:

```swift
Alamofire.request(url).responseXMLObject { (response: DataResponse<CDCatalog>) in
    let catalog = response.result.value
    print(catalog?.cds?.first?.title ?? "nil")
}
```

The `CDCatalog` object will look something like this:

```swift
class CDCatalog: XMLMappable {
    var nodeName: String!

    var cds: [CD]?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        cds <- map["CD"]
    }
}

class CD: XMLMappable {
    var nodeName: String!

    var title: String!
    var artist: String?
    var country: String?
    var company: String?
    var price: Double?
    var year: Int?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        title <- map["TITLE"]
        artist <- map["ARTIST"]
        country <- map["COUNTRY"]
        company <- map["COMPANY"]
        price <- map["PRICE"]
        year <- map["YEAR"]
    }
}
```

Last but not least, create easily and send SOAP requests, again using `Alamofire`:

```swift
let soapMessage = SOAPMessage(soapAction: "ActionName", nameSpace: "ActionNameSpace")
let soapEnvelope = SOAPEnvelope(soapMessage: soapMessage)

Alamofire.request(url, method: .post, parameters: soapEnvelope.toXML(), encoding: XMLEncoding.soap(withAction: "ActionNameSpace#ActionName"))
```

The request will look something like this:

```http
POST / HTTP/1.1
Host: <The url>
Content-Type: text/xml; charset="utf-8"
Connection: keep-alive
SOAPAction: ActionNameSpace#ActionName
Accept: */*
User-Agent: XMLMapper_Example/1.0 (org.cocoapods.demo.XMLMapper-Example; build:1; iOS 11.0.0) Alamofire/4.5.1
Accept-Language: en;q=1.0
Content-Length: 251
Accept-Encoding: gzip;q=1.0, compress;q=0.5

<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
    <soap:Body>
        <m:ActionName xmlns:m="ActionNameSpace"/>
    </soap:Body>
</soap:Envelope>
```

Adding action parameters is as easy as subclassing the `SOAPMessage` class.

```swift
class MySOAPMessage: SOAPMessage {

    // Custom properties

    override func mapping(map: XMLMap) {
        super.mapping(map: map)

        // Map the custom properties
    }
}
```

Also specify the SOAP version that the endpoint use as follows:

```swift
let soapMessage = SOAPMessage(soapAction: "ActionName", nameSpace: "ActionNameSpace")
let soapEnvelope = SOAPEnvelope(soapMessage: soapMessage, soapVersion: .version1point2)

Alamofire.request(url, method: .post, parameters: soapEnvelope.toXML(), encoding: XMLEncoding.soap(withAction: "ActionNameSpace#ActionName", soapVersion: .version1point2))
```

and the request will change to this:

```http
POST / HTTP/1.1
Host: <The url>
Content-Type: application/soap+xml;charset=UTF-8;action="ActionNameSpace#ActionName"
Connection: keep-alive
Accept: */*
User-Agent: XMLMapper_Example/1.0 (org.cocoapods.demo.XMLMapper-Example; build:1; iOS 11.0.0) Alamofire/4.5.1
Accept-Language: en;q=1.0
Content-Length: 248
Accept-Encoding: gzip;q=1.0, compress;q=0.5

<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope/" soap:encodingStyle="http://www.w3.org/2003/05/soap-encoding">
    <soap:Body>
        <m:ActionName xmlns:m="ActionNameSpace"/>
    </soap:Body>
</soap:Envelope>
```

Unfortunately, there isn't an easy way to map SOAP response, other than creating your own XMLMappable objects (at least not for the moment)

## Communication

- If you **need help**, use [Stack Overflow](https://stackoverflow.com/questions/tagged/xmlmapper). (Tag 'xmlmapper')
- If you'd like to **ask a general question**, use [Stack Overflow](https://stackoverflow.com/questions/tagged/xmlmapper).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.

## Installation

### CocoaPods

XMLMapper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod 'XMLMapper'
```

To install the `Requests` subspec add the following line to your `Podfile`:

```ruby
pod 'XMLMapper/Requests'
```

### Carthage

To integrate XMLMapper into your Xcode project using [Carthage](https://github.com/Carthage/Carthage), add the following line to your  `Cartfile`:

```ogdl
github "gcharita/XMLMapper" ~> 1.6
```

### Swift Package Manager

To add XMLMapper to a [Swift Package Manager](https://swift.org/package-manager/) based project, add the following:

```swift
.package(url: "https://github.com/gcharita/XMLMapper.git", from: "1.6.0")
```

to the `dependencies` value of your `Package.swift`.

## Special thanks

- Special thanks to [Tristan Himmelman](https://github.com/tristanhimmelman). This project is based in  [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper) for the most part, which is a great solution for JSON mapping. Also the Requests subspec is based on [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper).
- A special thanks to [Nick Lockwood](https://github.com/nicklockwood) and his idea behind [XMLDictionary](https://github.com/nicklockwood/XMLDictionary)
- A special thanks to [Alamofire](https://github.com/Alamofire/Alamofire) for the subspec dependency

## License

XMLMapper is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
