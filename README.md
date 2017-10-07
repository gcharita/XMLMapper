# XMLMapper

[![CI Status](https://img.shields.io/travis/gcharita/XMLMapper.svg?style=flat)](https://travis-ci.org/gcharita/XMLMapper)
[![Version](https://img.shields.io/cocoapods/v/XMLMapper.svg?style=flat)](http://cocoapods.org/pods/XMLMapper)
[![License](https://img.shields.io/cocoapods/l/XMLMapper.svg?style=flat)](http://cocoapods.org/pods/XMLMapper)
[![Platform](https://img.shields.io/cocoapods/p/XMLMapper.svg?style=flat)](http://cocoapods.org/pods/XMLMapper)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 8.0+
- Xcode 8.3+
- Swift 3.1+

## How to use

To map XML to a class (or the reverse) the class must implement the ```XMLMappable``` protocol:

```swift
var nodeName: String! { get set }
init(map: XMLMap)
mutating func mapping(map: XMLMap)
```

XMLMapper uses the ```<-``` operator to map properties to and from XML elements:

```swift
class Food: XMLMappable {
    var nodeName: String!

    var name: String!
    var price: Float!
    var description: String?
    var calories: Int?

    required init(map: XMLMap) {

    }

    func mapping(map: XMLMap) {
        name <- map["name"]
        price <- map["price"]
        description <- map["description"]
        calories <- map["calories"]
    }
}
```

### Basic XML mapping

Convert easily an XML string to ```XMLMappable```:

```swift
let food = Food(XMLString: xmlString)
```

Or an ```XMLMappable``` object to XML string:

```swift
let xmlString = food.toXMLString()
```

```XMLMapper.swift``` can also provide the same functionality:

```swift
let food = XMLMapper<Food>().map(XMLString: xmlString)

let xmlString = XMLMapper().toXMLString(food)
 ```

### Advanced mapping

Set ```nodeName``` property of your class to change the element's name:

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

Map easily XML attributes using the ```attributes``` property of the ```XMLMap```:

```xml
<food name="Belgian Waffles">
</food>
```

```swift
func mapping(map: XMLMap) {
    name <- map.attributes["name"]
}
```

Map arrays of elements:

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

Map nested XML elements by separating names with a dot:

```xml
<food>
  <name>Belgian Waffles</name>
  <details>
    <price>5.95</price>
    <description>
      Two of our famous Belgian Waffles with plenty of real maple syrup
    </description>
    <calories>650</calories>
  </details>
</food>
```

```swift
func mapping(map: XMLMap) {
    price <- map["details.price"]
}
```

Or create your own custom transform type by implementing the ```XMLTransformType``` protocol:

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
    </TestElementXMLMappable>
 </root>
```

to classes:

```swift
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
```

## Installation

XMLMapper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XMLMapper'
```

## Special thanks

- Special thanks to [Hearst-DD](https://github.com/Hearst-DD). This project is based in  [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) for the most part, which is a great solution for JSON mapping
- A special thanks to [Nick Lockwood](https://github.com/nicklockwood) and [XMLDictionary](https://github.com/nicklockwood/XMLDictionary) for the project dependency

## License

XMLMapper is available under the MIT license. See the LICENSE file for more info.
